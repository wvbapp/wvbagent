#!/bin/zsh

# WVB Package Verification Script for macOS
# Uses built-in openssl (no Python required)

if [[ $# -lt 2 ]]; then
    echo "Usage: $0 <package_file> <public_key_pem> [signature_file]"
    echo "Example: $0 wvb-agent-macos.pkg license_public.pem"
    exit 1
fi

PACKAGE=$1
PUBKEY=$2
SIGFILE=${3:-"$PACKAGE.sig"}

if [[ ! -f "$PACKAGE" ]]; then
    echo "Error: Package not found: $PACKAGE"
    exit 1
fi

if [[ ! -f "$PUBKEY" ]]; then
    echo "Error: Public key not found: $PUBKEY"
    exit 1
fi

if [[ ! -f "$SIGFILE" ]]; then
    echo "Error: Signature file not found: $SIGFILE"
    exit 1
fi

echo "Verifying $PACKAGE..."

# 1. Decode base64 signature to binary
SIG_BIN=$(mktemp /tmp/wvb_sig.XXXXXX)
base64 -d -i "$SIGFILE" -o "$SIG_BIN"

# 2. Verify RSA-PSS signature
# Note: macOS built-in openssl supports PSS since Catalina.
# We must use the same salt length (32), hash (sha256), AND MGF1 hash (sha256) 
# as the signing script.
openssl dgst -sha256 -verify "$PUBKEY" \
    -sigopt rsa_padding_mode:pss \
    -sigopt rsa_pss_saltlen:32 \
    -sigopt rsa_mgf1_md:sha256 \
    -signature "$SIG_BIN" \
    "$PACKAGE"

RESULT=$?

rm -f "$SIG_BIN"

if [[ $RESULT -eq 0 ]]; then
    echo "------------------------"
    echo "VERIFICATION SUCCESSFUL"
    echo "------------------------"
else
    echo "------------------------"
    echo "VERIFICATION FAILED"
    echo "------------------------"
    exit 1
fi

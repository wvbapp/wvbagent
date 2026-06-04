#!/usr/bin/env python3
import os
import sys
import argparse
import hashlib
import base64
from cryptography.hazmat.primitives import hashes, serialization
from cryptography.hazmat.primitives.asymmetric import padding, utils

def sign_file(file_path, private_key_path, output_sig_path=None):
    if not os.path.exists(file_path):
        print(f"Error: File not found: {file_path}")
        return False
    if not os.path.exists(private_key_path):
        print(f"Error: Private key not found: {private_key_path}")
        return False

    print(f"Signing {file_path} with {private_key_path}...")
    
    # Load private key
    with open(private_key_path, "rb") as key_file:
        private_key = serialization.load_pem_private_key(key_file.read(), password=None)

    # Read file and hash it
    sha256_hash = hashes.Hash(hashes.SHA256())
    with open(file_path, "rb") as f:
        for byte_block in iter(lambda: f.read(4096), b""):
            sha256_hash.update(byte_block)
    digest = sha256_hash.finalize()

    # Sign the digest using Prehashed to avoid hashing it again
    signature = private_key.sign(
        digest,
        padding.PSS(
            mgf=padding.MGF1(hashes.SHA256()),
            salt_length=32
        ),
        utils.Prehashed(hashes.SHA256())
    )

    # Output signature (base64)
    sig_b64 = base64.b64encode(signature).decode('utf-8')
    
    if not output_sig_path:
        output_sig_path = file_path + ".sig"
        
    with open(output_sig_path, "w") as f:
        f.write(sig_b64)
    
    print(f"Signature saved to: {output_sig_path}")
    return True

def verify_file(file_path, signature_path, public_key_path):
    if not all(os.path.exists(p) for p in [file_path, signature_path, public_key_path]):
        print("Error: Missing file, signature, or public key.")
        return False

    print(f"Verifying {file_path}...")
    
    # Load public key
    with open(public_key_path, "rb") as key_file:
        public_key = serialization.load_pem_public_key(key_file.read())

    # Load signature
    with open(signature_path, "r") as f:
        signature = base64.b64decode(f.read())

    # Hash the file
    sha256_hash = hashes.Hash(hashes.SHA256())
    with open(file_path, "rb") as f:
        for byte_block in iter(lambda: f.read(4096), b""):
            sha256_hash.update(byte_block)
    digest = sha256_hash.finalize()

    try:
        public_key.verify(
            signature,
            digest,
            padding.PSS(
                mgf=padding.MGF1(hashes.SHA256()),
                salt_length=32
            ),
            utils.Prehashed(hashes.SHA256())
        )
        print("VERIFICATION SUCCESSFUL")
        return True
    except Exception as e:
        print(f"VERIFICATION FAILED: {e}")
        return False

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Sign or verify a file using RSA-PSS")
    parser.add_argument("action", choices=["sign", "verify"])
    parser.add_argument("file", help="Path to the file to sign/verify")
    parser.add_argument("--key", required=True, help="Path to the private (for sign) or public (for verify) key")
    parser.add_argument("--sig", help="Path to the signature file (defaults to <file>.sig)")
    
    args = parser.parse_args()
    
    if args.action == "sign":
        sign_file(args.file, args.key, args.sig)
    else:
        if not args.sig:
            args.sig = args.file + ".sig"
        verify_file(args.file, args.sig, args.key)

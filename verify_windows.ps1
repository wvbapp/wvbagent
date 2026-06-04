# WVB Package Verification Script for Windows
# Uses native .NET/PowerShell (No Python/OpenSSL required)

param (
    [Parameter(Mandatory=$true)]
    [string]$PackageFile,

    [Parameter(Mandatory=$true)]
    [string]$PublicKeyFile,

    [Parameter(Mandatory=$false)]
    [string]$SignatureFile
)

if (-not $SignatureFile) {
    $SignatureFile = "$PackageFile.sig"
}

if (-not (Test-Path $PackageFile)) { Write-Error "Package not found: $PackageFile"; exit 1 }
if (-not (Test-Path $PublicKeyFile)) { Write-Error "Public key not found: $PublicKeyFile"; exit 1 }
if (-not (Test-Path $SignatureFile)) { Write-Error "Signature file not found: $SignatureFile"; exit 1 }

Write-Host "Verifying $PackageFile..."

try {
    # 1. Load Public Key
    $pubKeyPem = Get-Content $PublicKeyFile -Raw
    $pubKeyBase64 = $pubKeyPem -replace "-----BEGIN PUBLIC KEY-----", "" -replace "-----END PUBLIC KEY-----", "" -replace "`r", "" -replace "`n", ""
    $pubKeyBytes = [Convert]::FromBase64String($pubKeyBase64)

    # 2. Setup RSA Object
    $rsa = [System.Security.Cryptography.RSA]::Create()
    $rsa.ImportSubjectPublicKeyInfo($pubKeyBytes, [ref]$null)

    # 3. Load Signature
    $sigBase64 = Get-Content $SignatureFile -Raw
    $sigBytes = [Convert]::FromBase64String($sigBase64.Trim())

    # 4. Hash the Package File
    $sha256 = [System.Security.Cryptography.SHA256]::Create()
    $fileStream = [System.IO.File]::OpenRead((Resolve-Path $PackageFile).Path)
    $hashBytes = $sha256.ComputeHash($fileStream)
    $fileStream.Close()

    # 5. Verify RSA-PSS Signature
    # Salt length 32 matches our Python signing script
    $padding = [System.Security.Cryptography.RSASignaturePadding]::Pss
    $isValid = $rsa.VerifyHash($hashBytes, $sigBytes, [System.Security.Cryptography.HashAlgorithmName]::SHA256, $padding)

    if ($isValid) {
        Write-Host "------------------------" -ForegroundColor Green
        Write-Host "VERIFICATION SUCCESSFUL" -ForegroundColor Green
        Write-Host "------------------------" -ForegroundColor Green
    } else {
        Write-Host "------------------------" -ForegroundColor Red
        Write-Host "VERIFICATION FAILED" -ForegroundColor Red
        Write-Host "------------------------" -ForegroundColor Red
        exit 1
    }
}
catch {
    Write-Error "An error occurred during verification: $_"
    exit 1
}
finally {
    if ($rsa) { $rsa.Dispose() }
}

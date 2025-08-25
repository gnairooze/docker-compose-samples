# SSL Certificate Generator for *.dev.test

This directory contains two Python scripts for generating SSL certificates for local development:

1. **`generate_ssl_cert.py`** - Generates a simple self-signed certificate
2. **`generate_ca_and_cert.py`** - Generates a CA certificate and server certificate (RECOMMENDED)

## Recommended Approach: CA + Server Certificate

The `generate_ca_and_cert.py` script creates:
- A Certificate Authority (CA) certificate that can be imported into browsers
- A server certificate signed by the CA for `*.dev.test`

### Features

- **CA Certificate**: 4096-bit RSA key, valid for 10 years
- **Server Certificate**: 2048-bit RSA key, valid for 1 year
- Supports wildcard domain `*.dev.test`
- Includes Subject Alternative Names (SAN) for:
  - `*.dev.test` (wildcard)
  - `dev.test` (base domain)
  - `localhost` (for local testing)
  - `127.0.0.1` (localhost IP)
- Proper file permissions (private keys are owner-readable only)
- Ready-to-use with web servers like nginx

## Requirements

- Python 3.6+
- cryptography library

## Installation

1. Install the required dependency:
```bash
pip install cryptography
```

## Usage

### Generate CA and Server Certificates (Recommended)

```bash
python generate_ca_and_cert.py
```

This will generate four files:
- `dev-test-ca.crt` - The Certificate Authority certificate (import this into browsers)
- `dev-test-ca.key` - The CA private key (keep secure)
- `dev.test.crt` - The server SSL certificate (use with nginx)
- `dev.test.key` - The server private key (use with nginx)

### Generate Simple Self-Signed Certificate

```bash
python generate_ssl_cert.py
```

This will generate two files:
- `dev.test.crt` - The SSL certificate
- `dev.test.key` - The private key

## Using with nginx

Add these lines to your nginx server block:
```nginx
server {
    listen 443 ssl;
    server_name *.dev.test;
    
    ssl_certificate     /path/to/dev.test.crt;
    ssl_certificate_key /path/to/dev.test.key;
    
    # Your other configuration...
}
```

## Trusting the Certificate

To avoid browser security warnings, you need to trust the certificate:

### Chrome/Edge (Windows) - Import CA Certificate
1. Double-click the `dev-test-ca.crt` file (CA certificate, NOT the server certificate)
2. Click "Install Certificate"
3. Choose "Local Machine" and click "Next"
4. Select "Place all certificates in the following store"
5. Click "Browse" and select "Trusted Root Certification Authorities"
6. Click "Next" and "Finish"
7. Restart your browser

### Firefox (Import CA Certificate)
1. Go to Settings → Privacy & Security → Certificates → View Certificates
2. Click "Import" in the **Authorities** tab
3. Select the `dev-test-ca.crt` file (CA certificate, NOT the server certificate)
4. Check "Trust this CA to identify websites"
5. Restart Firefox

### macOS - Import CA Certificate
```bash
# Import CA certificate (NOT the server certificate)
sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain dev-test-ca.crt
```

### Linux - Import CA Certificate
```bash
# Import CA certificate (NOT the server certificate)
sudo cp dev-test-ca.crt /usr/local/share/ca-certificates/
sudo update-ca-certificates
```

## Security Notice

⚠️ **This certificate is for development use only!** 

- It's self-signed and not issued by a trusted Certificate Authority
- Never use self-signed certificates in production
- The private key is generated without a passphrase for convenience

## Customization

You can modify the script to change:
- Domain name
- Certificate validity period
- Output file names
- Certificate subject information

Edit the variables in the `main()` function or modify the `generate_self_signed_cert()` parameters.

## Important Notes

**For Firefox Certificate Import Issues:**

If you're getting "This is not a certificate authority certificate" error in Firefox, you're trying to import the wrong file:

- ❌ **DON'T import**: `dev.test.crt` (server certificate)
- ✅ **DO import**: `dev-test-ca.crt` (CA certificate)

The CA certificate is what you import into your browser's trusted authorities. The server certificate is used by nginx/web servers.

**Certificate Chain:**
- `dev-test-ca.crt` → Certificate Authority (import into browser)
- `dev.test.crt` → Server certificate signed by the CA (use with nginx)
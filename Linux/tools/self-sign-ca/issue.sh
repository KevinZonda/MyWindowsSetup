#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# KevinZonda One-Time TLS Server Certificate Authority
#
# Usage:
#   ./issue.sh [server-name] [output-dir]
#
# Example:
#   ./issue.sh '*.kvzd.cn' ./certs
#
# Output:
#   ca.crt       -> put on verifier / upstream client side
#   server.crt   -> put on TLS server side
#   server.key   -> put on TLS server side, KEEP SECRET
#
# The CA private key is DESTROYED after signing.
# ============================================================

SERVER_NAME="${1:-*.kvzd.cn}"
OUT_DIR="${2:-./certs}"

# 10 years
VALID_DAYS="${VALID_DAYS:-3650}"

CA_CN="KevinZonda One-Time Certificate Authority"

mkdir -p "$OUT_DIR"
chmod 700 "$OUT_DIR"

CA_KEY="$OUT_DIR/.ca.key"
CA_CRT="$OUT_DIR/ca.crt"

SERVER_KEY="$OUT_DIR/server.key"
SERVER_CSR="$OUT_DIR/.server.csr"
SERVER_CRT="$OUT_DIR/server.crt"

CA_CONF="$OUT_DIR/.ca.cnf"
SERVER_CONF="$OUT_DIR/.server.cnf"

# ------------------------------------------------------------
# Refuse accidental overwrite
# ------------------------------------------------------------

for f in "$CA_CRT" "$SERVER_KEY" "$SERVER_CRT"; do
    if [[ -e "$f" ]]; then
        echo "ERROR: $f already exists."
        exit 1
    fi
done


echo "[1/7] Generating one-time CA private key..."

openssl genpkey \
    -algorithm EC \
    -pkeyopt ec_paramgen_curve:P-256 \
    -out "$CA_KEY"

chmod 600 "$CA_KEY"


echo "[2/7] Creating CA certificate..."

cat > "$CA_CONF" <<EOF
[req]
prompt = no
distinguished_name = dn
x509_extensions = v3_ca

[dn]
C  = GB
ST = Greater London
L  = London
O  = KevinZonda Research
OU = One-Time Certificate
CN = ${CA_CN}

[v3_ca]
basicConstraints = critical, CA:TRUE, pathlen:0
keyUsage = critical, keyCertSign, cRLSign
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid:always
EOF

openssl req \
    -new \
    -x509 \
    -sha256 \
    -days "$VALID_DAYS" \
    -key "$CA_KEY" \
    -out "$CA_CRT" \
    -config "$CA_CONF"


echo "[3/7] Generating server private key..."

openssl genpkey \
    -algorithm EC \
    -pkeyopt ec_paramgen_curve:P-256 \
    -out "$SERVER_KEY"

chmod 600 "$SERVER_KEY"


echo "[4/7] Creating server CSR..."

cat > "$SERVER_CONF" <<EOF
[req]
prompt = no
distinguished_name = dn
req_extensions = v3_server

[dn]
C  = GB
ST = Greater London
L  = London
O  = KevinZonda Research
OU = One-Time Certificate
CN = ${SERVER_NAME}

[v3_server]
basicConstraints = critical, CA:FALSE
keyUsage = critical, digitalSignature
extendedKeyUsage = serverAuth
subjectKeyIdentifier = hash
authorityKeyIdentifier = keyid,issuer
subjectAltName = DNS:${SERVER_NAME}
EOF

openssl req \
    -new \
    -sha256 \
    -key "$SERVER_KEY" \
    -out "$SERVER_CSR" \
    -config "$SERVER_CONF"


echo "[5/7] Signing server certificate..."

# Random 128-bit certificate serial.
SERIAL_HEX="$(openssl rand -hex 16)"

openssl x509 \
    -req \
    -sha256 \
    -days "$VALID_DAYS" \
    -in "$SERVER_CSR" \
    -CA "$CA_CRT" \
    -CAkey "$CA_KEY" \
    -set_serial "0x${SERIAL_HEX}" \
    -out "$SERVER_CRT" \
    -extfile "$SERVER_CONF" \
    -extensions v3_server


echo "[6/7] Verifying server certificate..."

openssl verify \
    -purpose sslserver \
    -CAfile "$CA_CRT" \
    "$SERVER_CRT"

echo

openssl x509 \
    -in "$SERVER_CRT" \
    -noout \
    -subject \
    -issuer \
    -serial \
    -dates \
    -fingerprint \
    -sha256

echo

openssl x509 \
    -in "$SERVER_CRT" \
    -noout \
    -ext subjectAltName \
    -ext extendedKeyUsage \
    -ext keyUsage \
    -ext basicConstraints


echo
echo "[7/7] Destroying one-time CA private key..."

# Remove sensitive and temporary material.
rm -f \
    "$CA_KEY" \
    "$SERVER_CSR" \
    "$CA_CONF" \
    "$SERVER_CONF"

chmod 644 "$CA_CRT" "$SERVER_CRT"
chmod 600 "$SERVER_KEY"


echo
echo "============================================================"
echo "Certificate provisioning complete."
echo
echo "Verifier / upstream client:"
echo "  $CA_CRT"
echo
echo "TLS server:"
echo "  $SERVER_CRT"
echo "  $SERVER_KEY"
echo
echo "Certificate name:"
echo "  $SERVER_NAME"
echo
echo "CA private key:"
echo "  DESTROYED"
echo "============================================================"

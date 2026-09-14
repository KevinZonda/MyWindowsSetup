#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# KevinZonda One-Time Certificate Authority
#
# Usage:
#   ./issue.sh [client-name] [output-dir]
#
# Example:
#   ./issue.sh kevinnas ./certs
#
# Output:
#   ca.crt       -> put on verifier / server side
#   client.crt   -> put on client side
#   client.key   -> put on client side, KEEP SECRET
#
# CA private key is DESTROYED after signing.
# ============================================================

CLIENT_NAME="${1:-kevinnar-frpc}"
OUT_DIR="${2:-./certs}"

# 10 years
VALID_DAYS="${VALID_DAYS:-3650}"

CA_CN="KevinZonda One-Time Certificate Authority"

mkdir -p "$OUT_DIR"
chmod 700 "$OUT_DIR"

CA_KEY="$OUT_DIR/.ca.key"
CA_CRT="$OUT_DIR/ca.crt"

CLIENT_KEY="$OUT_DIR/client.key"
CLIENT_CSR="$OUT_DIR/.client.csr"
CLIENT_CRT="$OUT_DIR/client.crt"

CA_CONF="$OUT_DIR/.ca.cnf"
CLIENT_CONF="$OUT_DIR/.client.cnf"

# Refuse accidental overwrite.
for f in "$CA_CRT" "$CLIENT_KEY" "$CLIENT_CRT"; do
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
EOF

openssl req -new -x509 -sha256 \
    -days "$VALID_DAYS" \
    -key "$CA_KEY" \
    -out "$CA_CRT" \
    -config "$CA_CONF"


echo "[3/7] Generating client private key..."

openssl genpkey \
    -algorithm EC \
    -pkeyopt ec_paramgen_curve:P-256 \
    -out "$CLIENT_KEY"

chmod 600 "$CLIENT_KEY"


echo "[4/7] Creating client CSR..."

cat > "$CLIENT_CONF" <<EOF
[req]
prompt = no
distinguished_name = dn
req_extensions = req_ext

[dn]
C  = GB
ST = Greater London
L  = London
O  = KevinZonda Research
OU = One-Time Certificate
CN = ${CLIENT_NAME}

[req_ext]
basicConstraints = critical, CA:FALSE
keyUsage = critical, digitalSignature
extendedKeyUsage = clientAuth
subjectKeyIdentifier = hash
EOF

openssl req -new -sha256 \
    -key "$CLIENT_KEY" \
    -out "$CLIENT_CSR" \
    -config "$CLIENT_CONF"


echo "[5/7] Signing client certificate..."

# Random 128-bit certificate serial.
SERIAL_HEX="$(openssl rand -hex 16)"

openssl x509 -req -sha256 \
    -days "$VALID_DAYS" \
    -in "$CLIENT_CSR" \
    -CA "$CA_CRT" \
    -CAkey "$CA_KEY" \
    -set_serial "0x${SERIAL_HEX}" \
    -out "$CLIENT_CRT" \
    -extfile "$CLIENT_CONF" \
    -extensions req_ext


echo "[6/7] Verifying certificate..."

openssl verify \
    -purpose sslclient \
    -CAfile "$CA_CRT" \
    "$CLIENT_CRT"

echo

openssl x509 \
    -in "$CLIENT_CRT" \
    -noout \
    -subject \
    -issuer \
    -serial \
    -dates \
    -fingerprint \
    -sha256


echo
echo "[7/7] Destroying one-time CA private key..."

# Remove temporary material.
rm -f \
    "$CA_KEY" \
    "$CLIENT_CSR" \
    "$CA_CONF" \
    "$CLIENT_CONF"

chmod 644 "$CA_CRT" "$CLIENT_CRT"
chmod 600 "$CLIENT_KEY"


echo
echo "============================================================"
echo "Certificate provisioning complete."
echo
echo "Server / verifier:"
echo "  $CA_CRT"
echo
echo "Client:"
echo "  $CLIENT_CRT"
echo "  $CLIENT_KEY"
echo
echo "CA private key:"
echo "  DESTROYED"
echo "============================================================"
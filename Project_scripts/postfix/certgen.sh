#!/bin/bash shell
#script for generating self-signed certs. Run this in a folder, as it
# generates a few files. Large portions of this script were taken from the
# following artcile:
#
# http://usrportage.de/archives/919-Batch-generating-SSL-certificates.html

# Function accepts a single argument, the fqdn for the cert
function docert () {
DOMAIN="$1"
if [ -z "$DOMAIN" ]; then
 echo "Usage: $(basename $0) <domain>"
 exit 11
fi

fail_if_error() {
 [ $1 != 0 ] && {
   unset PASSPHRASE
   exit 10
 }
}

# Generate a passphrase
export PASSPHRASE=$(head -c 500 /dev/urandom | tr -dc a-z0-9A-Z | head -c 128; echo)

# Certificate details; replace items in angle brackets with your own info
subj="
C=CA
ST=BC
O=dtc
localityName=Vancouver
commonName=$DOMAIN
organizationalUnitName=
emailAddress=ajones125@my.bcit.ca
"

# Generate the server private key
openssl genrsa -des3 -out $DOMAIN.key -passout env:PASSPHRASE 2048
fail_if_error $?

# Generate the CSR
openssl req \
   -new \
   -batch \
   -subj "$(echo -n "$subj" | tr "\n" "/")" \
   -key $DOMAIN.key \
   -out $DOMAIN.csr \
   -passin env:PASSPHRASE
fail_if_error $?
#cp $DOMAIN.key $keypath
#cp $DOMAIN.crt $certpath
#fail_if_error $?

# Strip the password so we don't have to type it every time we restart
openssl rsa -in $DOMAIN.key -out $DOMAIN.key -passin env:PASSPHRASE
fail_if_error $?

# Generate the cert (good for 10 years)
openssl x509 -req -days 365 -in $DOMAIN.csr -signkey $DOMAIN.key -out $DOMAIN.crt
fail_if_error $?

cp $DOMAIN.key $keypath
cp $DOMAIN.crt $certpath
fail_if_error $?
}

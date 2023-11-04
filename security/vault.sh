#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

function red {
    printf "${RED}$@${NC}\n"
}

function green {
    printf "${GREEN}$@${NC}\n"
}

function yellow {
    printf "${YELLOW}$@${NC}\n"
}

case $1 in
    (encrypt|decrypt) ;;
    (*) printf >&2 "${RED}Error: '$1' is unsupported; provide either 'encrypt' or 'decrypt'${NC}\n"; exit 1;;
esac

# Check dependencies
if ! which gpg &> /dev/null
then
    echo "Error: gpg not installed." >&2
    echo "Please install gpg (on Mac: 'brew install gpg')" >&2
    exit 2
fi

if [ "$1" == "encrypt" ]; then
    if ! which gpg-agent &> /dev/null
    then
        echo "Error: gpg-agent not installed." >&2
        echo "Please install gpg-agent (on Mac: 'brew install gpg-agent' / on Linux: apt-get update -y && apt-get install -y gpg-agent)" >&2
        exit 2
    fi
fi

# Obtain vault password
vaultpwd=$VAULT_PASSWORD
if [ -n "$vaultpwd" ]; then
    echo $(green 'Vault password provided')
else
    echo $(red 'No vault password provided')
    if [ -n "$CI" ]; then
        echo "Running in CI, unable to obtain vault password. Exiting." >&2
        exit 1
    else
        echo "Enter the vault password for this project:"
        read -s vaultpwd
    fi
fi

function encrypt {
    file="$@"
    encrypted_file="$file.encrypted"
    if [ -f "$file" ]; then
        echo -e "Encrypting $file"
        if [ -f "$encrypted_file" ]; then
        echo $(yellow " • File $encrypted_file found")
        if [ "$encrypted_file" -nt "$file" ]; then
            echo ' • No changes since last encryption, skipping.'
            return
        fi
    fi
    rm "$encrypted_file"
    gpg --quiet --cipher-algo AES256 --batch --output "$encrypted_file" --passphrase "$vaultpwd" --symmetric "$file"
    echo $(green " • File encrypted.")
    else
       echo $(red "File $file not found, skipping.")
    fi
}

function decrypt {
    file="$@"
    encrypted_file="$file.encrypted"
    if [ -f "$encrypted_file" ]; then
        echo -e "Decrypting $encrypted_file"
        if [ -f "$file" ]; then
            echo " • File $file already exists, skipping."
            return
        fi
        gpg --quiet --cipher-algo AES256 --batch --output "$file" --passphrase "$vaultpwd" --decrypt "$encrypted_file"
        echo $(green " • File decrypted.")
    else
        echo $(red "Encrypted file $encrypted_file not found, skipping.")
    fi
}

securefiles="$PWD/security/secure-files"
while read file; do
    $1 "$file"
done < "$securefiles"
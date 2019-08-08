#!/usr/bin/env bash

#set -x

POSITIONAL=()
while [[ $# -gt 0 ]]
    do
    key="$1"

    case $key in
        --ext)
        EXTENSION="$2"
        shift # past argument
        shift # past value
        ;;
        -h|--help)
        HELP='yes'
        shift # past argument
        ;;
        *)    # unknown option
        POSITIONAL+=("$1") # save it in an array for later
        shift # past argument
        ;;
    esac
done

ACTION=${POSITIONAL[0]}
FILE=${POSITIONAL[1]}
EXTENSION=${EXTENSION:-dec}


function usage() {
    echo "Encrypt file with aes-256-cbc cipher using openssl"
    echo "Usage for encrypting: ./encrypt -e file [--ext enc]"
    echo "Usage for decrypting: ./encrypt -d file [--ext enc]"
}


if [ "${HELP:-no}" == 'yes' ] || [ ! "${ACTION}" ] || [ ! "${FILE}" ]; then
    usage
fi


function encrypt() {
    local input=$1
    local output="${input}.${EXTENSION}"
    openssl aes-256-cbc -a -e -salt -in "$input" -out "$output"
    echo "Encrypted file $output"
    rm "$input"
}

function decrypt() {
    local input=$1
    local output=${input%".$EXTENSION"}
    openssl aes-256-cbc -a -d -salt -in "$input" -out "$output"
    echo "Decrypted file $output"
    rm "$input"
}


if [ ! -f "$FILE" ]; then
    echo "File $FILE doesn't exists"
    exit 1
fi

if [ "$ACTION" == "-e" ]; then
    encrypt "$FILE"
elif [ "$ACTION" == "-d" ]; then
    decrypt "$FILE"
fi

#!/bin/bash
fileid="$1"   # file id gotten from the download link
filename="$2" # output filename to be given as argument to the script

 wget --load-cookies /tmp/cookies.txt \
 "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cook$
 /tmp/cookies.txt --keep-session-cookies --no-check-certificate \
 'https://docs.google.com/uc?export=download&id=${fileid}' \
 -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=${fileid}" \
-O ${filename} && rm -rf /tmp/cookies.txt


# usage bash downlaod_wget.sh <fileid> <filename>


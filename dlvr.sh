#!/bin/bash

set -e

USAGE=$(cat <<- EOF
    Usage: $0 <username:password> <url> <seconds> <outfile base>
EOF
)

if [ $# -ne 4 ]; then
    echo ${USAGE}
    exit 1
fi

auth=$1
url=$2
seconds=$3
outfile="${4:-output}-$(date +%Y%m%d-%H%M%S)"

get_video() {
    curl -u ${auth} ${url} -o ${outfile}.mjpeg &
    PID=$!
    sleep ${seconds}
    kill ${PID}
}

convert_video() {
    ffmpeg -i ${outfile}.mjpeg -c:v libx264 -preset veryslow -crf 23 ${outfile}.mp4
    rm ${outfile}.mjpeg
}

main() {
    get_video
    convert_video
}

main
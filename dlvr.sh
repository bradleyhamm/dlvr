#!/bin/bash

set -e

USAGE=$(cat <<- EOF
    Usage: $0 <username:password> <url> <seconds> <count> <outfile base>
EOF
)

if [ $# -ne 5 ]; then
    echo ${USAGE}
    exit 1
fi

auth="${1}"
url="${2}"
seconds="${3}"
count="${4}"
outfile="${5}"

get_video() {
    curl -su ${auth} ${url} -o "${1}.mjpeg" &
    PID=$!
    sleep ${seconds}
    kill ${PID}
}

convert_video() {
    ffmpeg -loglevel quiet -framerate 15 -i "${1}.mjpeg" -c:v libx264 -crf 23 "${1}.mp4"
    rm "${1}.mjpeg"
}

main() {
    for x in $(seq 1 $count); do
        outfile_="${outfile}-$(date +%Y%m%d-%H%M%S)"
        get_video $outfile_
        convert_video $outfile_ &
    done
}

main


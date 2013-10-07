#!/bin/bash
#
# License
#
# Applies ReplayGain to a MP3 music collection
# Copyright (c) 2013 Flexion.Org, http://flexion.org/
#
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation
# files (the "Software"), to deal in the Software without
# restriction, including without limitation the rights to use,
# copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following
# conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.

IFS=$'\n'
VER="1.21"

echo "MP3Gainer v${VER} - Applies ReplayGain to a MP3 music collection."
echo "Copyright (c) 2013 Flexion.Org, http://flexion.org. MIT License"
echo

replaygain() {
    echo -n "Processing MP3s in `pwd` : "
    if [ ${MODE_TRACK} -eq 1 ]; then
        echo "Track mode"
        mp3gain -r -k -s i *.mp3
    elif [ ${MODE_ALBUM} -eq 1 ]; then
        echo "Album mode"
        mp3gain -a -k -s i *.mp3
    elif [ ${MODE_UNDO} -eq 1 ]; then
        echo "Undo mode"
        mp3gain -u *.mp3
    fi
}

recurse() {
    cd "${1}"

    # Are we in a directory that contains MP3s?
    MP3S=`ls -1 *.mp3 2>/dev/null`
    if [ "$?" = "0" ]; then
        replaygain
    fi

    for dir in *
    do
        if [ -d "${dir}" ]; then
            ( recurse "${dir}" )
        fi;
    done
}

usage() {
    echo
    echo "Usage"
    echo "  ${0} musicdirectory [--track] [--album] [--undo] [--help]"
    echo ""
    echo "You must supply one of the following modes of operation"
    echo "  --track : apply Track gain automatically (all files set to equal loudness)"
    echo "  --album : apply Album gain automatically (files are all from the same"
    echo "            album: a single gain change is applied to all files, so"
    echo "            their loudness relative to each other remains unchanged,"
    echo "            but the average album loudness is normalized)"
    echo "  --undo  : undo changes made by mp3gain (based on stored tag info)"
    echo "  --help  : This help."
    echo
    exit 1
}

# Define the commands we will be using. If you don't have them, get them! ;-)
REQUIRED_TOOLS=`cat << EOF
echo
ls
mp3gain
pwd
EOF`

for REQUIRED_TOOL in ${REQUIRED_TOOLS}
do
    # Is the required tool in the path?
    which ${REQUIRED_TOOL} >/dev/null

    if [ $? -eq 1 ]; then
        echo "ERROR! \"${REQUIRED_TOOL}\" is missing. ${0} requires it to operate."
        echo "       Please install \"${REQUIRED_TOOL}\"."
        exit 1
    fi
done

# Get the first parameter passed in and validate it.
if [ $# -ne 2 ]; then
    echo "ERROR! ${0} requires a music directory and mode of operation as input"
    usage
elif [ "${1}" == "-h" ] || [ "${1}" == "--h" ] || [ "${1}" == "-help" ] || [ "${1}" == "--help" ] || [ "${1}" == "-?" ]; then
    usage
else
    MUSIC_DIR="${1}"

    if [ ! -d ${MUSIC_DIR} ]; then
        echo "ERROR! ${MUSIC_DIR} was not found."
        usage
    fi
    shift
fi

MODE_TRACK=0
MODE_ALBUM=0
MODE_UNDO=0

# Check for optional parameters
while [ $# -gt 0 ];
do
    case "${1}" in
        -t|-T|--track|-track)
            MODE_TRACK=1
            shift;;
        -a|-A|--album|-album)
            MODE_ALBUM=1
            shift;;
        -u|-U|--undo|-undo)
            MODE_UNDO=1
            shift;;
        -h|--h|-help|--help|-?)
            usage;;
        *)
            echo "ERROR! \"${1}\" is not s supported parameter."
            usage;;
    esac
done

recurse "${MUSIC_DIR}"

echo "All Done!"

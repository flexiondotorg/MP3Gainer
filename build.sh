#!/bin/bash

function build {
    RELEASE_NAME="MP3Gainer"
    RELEASE_VER="1.0"
    RELEASE_DESC="Applies ReplayGain to a MP3 music collection"
    RELEASE_KEYWORDS="replaygain, replay, gain, MP3, script, automatic, music, normalise, volume, album, track"

    rm ${RELEASE_NAME}-v${RELEASE_VER}.tar* 2>/dev/null
    bzr export ${RELEASE_NAME}-v${RELEASE_VER}.tar
    tar --delete -f ${RELEASE_NAME}-v${RELEASE_VER}.tar ${RELEASE_NAME}-v${RELEASE_VER}/build.sh
    gzip ${RELEASE_NAME}-v${RELEASE_VER}.tar
}

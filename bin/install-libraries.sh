#!/usr/bin/env sh

set -e

bin="`dirname "$0"`"
root="$bin/.."
libs="$root/.."

checkAlreadyInstalled() {
    if [ `ls "$libs" | wc -l` != "1" ]; then
        echo "Already installed" >&2
        exit 1
    fi
}

installLibrary() {
    (mkdir -p "$libs/$1" && cd "$libs/$1" && wget -O - "$2" | tar -xz --strip-components=1)
}

checkAlreadyInstalled

installLibrary flux-ilias-base-api https://github.com/fluxfw/flux-ilias-base-api/archive/refs/tags/v2023-02-10-1.tar.gz

installLibrary flux-rest-api https://github.com/fluxfw/flux-rest-api/archive/refs/tags/v2023-02-09-1.tar.gz

#!/usr/bin/env bash

set -euo pipefail

PREDEFINED=(
    "Github"
    "Wikipedia"
    "Youtube"
    "Arch Wiki"
    "Gentoo Wiki"
    "Reddit"
    "SOF"
    "Cyber News"
    "Linux News"
)

CHOICE=$(printf '%s\n' "${PREDEFINED[@]}" | rofi \
    -dmenu \
    -p "Search" \
    -i \
    -theme-str '
    window {width: 350px;}
    listview {
        columns: 2;
        lines: 6;
    }
    ' \
    -kb-accept-entry "Return")

[ -z "$CHOICE" ] && exit 0

browser(){
 if command -v helium-browser &>/dev/null; then
    helium-browser "$1"
 elif command -v librewolf &>/dev/null; then
    librewolf "$1"
 elif command -v firefox &>/dev/null; then
    firefox $1
 else
    echo "Please Install a Browser!"
    exit 1
 fi
}

urlencode() {
    python3 -c "import urllib.parse, sys; print(urllib.parse.quote(sys.argv[1]))" "$1"
}

case "$CHOICE" in
"Github"*) browser "https://github.com";;
"Wikipedia"*) browser "https://en.wikipedia.org/wiki/Main_Page";;
"Youtube"*) browser "https://www.youtube.com/";;
"Arch Wiki"*) browser "https://wiki.archlinux.org/title/Main_page";;
"Gentoo Wiki"*) browser "https://wiki.gentoo.org/wiki/Main_Page";;
"Reddit"*) browser "https://reddit.com/";;
"SOF"*) browser "https://stackoverflow.com/questions";;
"Cyber News"*) browser "https://cybernews.com/";;
"Linux News"*) browser "https://www.phoronix.com/recent-linux-news";;
*) browser "https://www.duckduckgo.com/search?q=$(urlencode "$CHOICE")";;
esac

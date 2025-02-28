#!/bin/sh
echo -ne '\033c\033]0;BaboonCrossing\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/baboon_crossing_linux.x86_64" "$@"

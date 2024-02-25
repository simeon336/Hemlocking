#!/bin/sh
echo -ne '\033c\033]0;Hemlocking\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/exportche.x86_64" "$@"

#!/bin/bash

if [ $# -eq 0 ]; then # leading and trailing spaces are necessary
	echo "Usage: ./asm-14500-cc65.sh file.asm"
	exit 1
fi

if ! command -v ca65 2>&1 >/dev/null; then
	echo "ca65 not found.  use apt install cc65 cc65-doc or see https://cc65.github.io/"
	exit 1
fi

if ! command -v ld65 2>&1 >/dev/null; then
	echo "ld65 not found.  use apt install cc65 cc65-doc or see https://cc65.github.io/"
	exit 1
fi

if 	[ ! -d ".build" ]; then
	mkdir ".build"
fi

filename=$(basename -- "$1")
filename="${filename%.*}"
if [ -d ".build/${filename}" ]; then
	rm ".build/${filename}"
fi

echo "Assembling ${1}"
ca65 -g $1 -o ".build/${filename}.o" -l ".build/${filename}.lst" --list-bytes 0

echo "Linking ${1}"

ld65 -o ".build/${filename}.bin" -Ln ".build/${filename}.labels" -m ".build/${filename}.map" -C plc14500-nano.cfg ".build/${filename}.o"

echo "Finished.  Binary in .build/${filename}.bin"

exit 0


#!/bin/bash
SALVEIFS=$IFS
IFS=$(echo -en "\n\b")

function move() {
	for file in `ls $1`
		do
			dirOrFile=$1"/"$file
			if [ -d $(echo $dirOrFile) ]
			then
				echo "dir="$dirOrFile
				move $dirOrFile
			elif [ -n "$(echo $dirOrFile | sed -n "/\.\(wmv\|avi\)$/p")" ] && [ -f $(echo $dirOrFile) ]
			then
				echo "parent dir="$1
				echo "file="$dirOrFile
				mv $dirOrFile './video/'
			fi
		done
}

move "."

IFS=$SAVEIFS
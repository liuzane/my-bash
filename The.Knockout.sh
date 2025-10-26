#!/bin/bash

initDirectory="狂飙 The.Knockout"
episodeIndexStart=17
timeIndexStart=20
resolutionIndexStart=25
oldFileName="The.Knockout.S01E01.2023.1080p.WEB-DL.H264.AAC-BlackTV.mp4"
newFileName="狂飙 The.Knockout"

SALVEIFS=$IFS
IFS=$(echo -en "\n\b")

function setFileName() {
	oldFile=$1"/"$2
	newFile=$1"/"$newFileName"."$3"."$4".E"$5"."$6
	echo "old file="$oldFile
	echo "new file="$newFile
	if [ -f $(echo $oldFile) ]
	then
		mv $oldFile $newFile
		echo "rename successed:"$newFile
	else
		echo "old file not exist:"$oldFile
	fi
}


function readDir() {
	# for file in `ls "$1" | tr " " "\?"`
	for file in `ls $1`
		do
			# file=`tr "\?" " " <<<$file`
			dirOrFile=$1"/"$file
			echo "file="$file
			echo "dirOrFile="$dirOrFile
			if [ -d $(echo $dirOrFile) ]
			then
				readDir $dirOrFile
			else
				episodeIndex=${file:episodeIndexStart:2}
				timeIndex=${file:timeIndexStart:4}
				resolutionIndex=${file:resolutionIndexStart:5}
				resolutionIndex=${resolutionIndex^^}
				suffix=${file##*.}
				echo "episodeIndex="$episodeIndex
				echo "timeIndex="$timeIndex
				echo "resolutionIndex="$resolutionIndex
				echo "suffix="$suffix
				if [ -f $(echo $dirOrFile) ] && [ -n "$(echo $episodeIndex | sed -n "/^[0-9]\{1,2\}$/p")" ] && [ -n "$(echo $timeIndex | sed -n "/^[0-9]\{4\}$/p")" ] && [ -n "$(echo $resolutionIndex | sed -n "/^[0-9]\{3,4\}P$/p")" ] 
				then
					setFileName $1 $file $timeIndex $resolutionIndex $episodeIndex $suffix
				fi
			fi
		done
}

readDir $initDirectory

IFS=$SAVEIFS
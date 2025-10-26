#!/bin/bash

initDirectory="知否知否应是绿肥红瘦 The.Story.Of.MingLan"
episodeIndexStart=11
oldFileName="知否知否应是绿肥红瘦 01.mp4"
newFileName="知否知否应是绿肥红瘦 The.Story.Of.MingLan"

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
				timeIndex="2018"
				resolutionIndex="1080P"
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
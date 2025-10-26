#!/bin/bash

initDirectory="新建文件夹"
episodeIndexStart=34
timeIndexStart=28
resolutionIndexStart=37
oldFileName="红楼梦.A.Dream.in.Red.Mansions.1987.E01.1080p.WEB-DL.H264.AAC-HotWEB.mp4"
newFileName="红楼梦 A.Dream.in.Red.Mansions"

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
				# echo "===Directory==="dirOrFile
				timeIndex=${file:timeIndexStart:4}
				echo "timeIndex="$timeIndex
				readDir $dirOrFile $timeIndex
			else
				episodeIndex=${file:episodeIndexStart:2}
        if [ ! $2 ]
        then
          timeIndex=${file:timeIndexStart:4}
        else
          timeIndex=$2
        fi
				resolutionIndex=${file:resolutionIndexStart:5}
				resolutionIndex=${resolutionIndex^^}
				suffix=${file##*.}
				echo "episodeIndex="$episodeIndex
				echo "timeIndex="$timeIndex
				echo "resolutionIndex="$resolutionIndex
				echo "suffix="$suffix
				if [ -f $(echo $dirOrFile) ] && [ -n "$(echo $episodeIndex | sed -n "/^[0-9]\{1,2\}$/p")" ] && [ -n "$(echo $timeIndex | sed -n "/^[0-9]\{4\}$/p")" ] && [ -n "$(echo $resolutionIndex | sed -n "/^[0-9]\{4\}P$/p")" ] 
				then
					setFileName $1 $file $timeIndex $resolutionIndex $episodeIndex $suffix
				fi
			fi
		done
}

readDir $initDirectory

IFS=$SAVEIFS
#!/bin/bash

initDirectory="生活大爆炸 The.Big.Bang.Theory"
seriesIndexStart=19
episodeIndexStart=22
timeIndexStart=32
resolutionIndexStart=11
directoryName="生活大爆炸01 The.Big.Bang.Theory.S01.2007"
oldFileName="生活大爆炸.H265.1080P.SE01.01.mkv"
newFileName="生活大爆炸 The.Big.Bang.Theory"

SALVEIFS=$IFS
IFS=$(echo -en "\n\b")

function setFileName() {
	oldFile=$1"/"$2
	newFile=$1"/"$newFileName"."$5"."$6".S"$3"E"$4"."$7
	echo "old file="$oldFile
	echo "new file="$newFile
	if [ -f $(echo $oldFile) ]
	then
		mv $oldFile $newFile
		# echo "rename successed:"$newFile
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
			# echo "dirOrFile="$dirOrFile
			if [ -d $(echo $dirOrFile) ]
			then
				# echo "===Directory==="dirOrFile
				timeIndex=${file:timeIndexStart:4}
				echo "timeIndex="$timeIndex
				readDir $dirOrFile $timeIndex
			else
				seriesIndex=${file:seriesIndexStart:2}
				episodeIndex=${file:episodeIndexStart:2}
				timeIndex=$2
				resolutionIndex=${file:resolutionIndexStart:5}
				resolutionIndex=${resolutionIndex^^}
				suffix=${file##*.}
				# suffix="mkv"
				echo "seriesIndex="$seriesIndex
				echo "episodeIndex="$episodeIndex
				echo "timeIndex="$timeIndex
				echo "resolutionIndex="$resolutionIndex
				echo "suffix="$suffix
				if [ -f $(echo $dirOrFile) ] && [ -n "$(echo $seriesIndex | sed -n "/^[0-9]\{1,2\}$/p")" ] && [ -n "$(echo $episodeIndex | sed -n "/^[0-9]\{1,2\}$/p")" ] && [ -n "$(echo $timeIndex | sed -n "/^[0-9]\{4\}$/p")" ] && [ -n "$(echo $resolutionIndex | sed -n "/^[0-9]\{4\}P$/p")" ] 
				then
					setFileName $1 $file $seriesIndex $episodeIndex $timeIndex $resolutionIndex $suffix
				fi
			fi
		done
}

readDir $initDirectory

IFS=$SAVEIFS
#!/bin/bash

initDirectory="破产姐妹 Broke.Girls"
seriesIndexStart=31
episodeIndexStart=34
# timeIndexStart 相对于 directoryName 取值
timeIndexStart=25
resolutionIndexStart=24
directoryName="破产姐妹01 2.Broke.Girls.S01.2011"
oldFileName="破产姐妹 2.Broke.Girls.2011.1080P.S01E01.mkv"
newFileName="破产姐妹 Broke.Girls"

SALVEIFS=$IFS
IFS=$(echo -en "\n\b")

function setFileName() {
	oldFile=$1"/"$3
	newFile=$2"/"$newFileName"."$6"."$7".S"$4"E"$5"."$8
	echo "old file="$oldFile
	echo "new file="$newFile
	if [ -f $(echo $oldFile) ]
	then
    if [ ! -d $(echo $2) ]
    then
      mkdir $2
      # echo "created dir successed:"$2
      #应该在加一个移除旧文件夹命令
    fi
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
			echo "dirOrFile="$dirOrFile
			if [ -d $(echo $dirOrFile) ]
			then
				# echo "===Directory==="dirOrFile
				timeIndex=${file:timeIndexStart:4}
				echo "timeIndex="$timeIndex
				readDir $dirOrFile $timeIndex
			else
				newDirectory=${1/2./}
				seriesIndex=${file:seriesIndexStart:2}
				seriesIndex=${file:seriesIndexStart:2}
				episodeIndex=${file:episodeIndexStart:2}
				timeIndex=$2
				resolutionIndex=${file:resolutionIndexStart:5}
				resolutionIndex=${resolutionIndex^^}
				suffix=${file##*.}
				# suffix="mkv"
				echo "newDirectory="$newDirectory
				echo "episodeIndex="$episodeIndex
				echo "timeIndex="$timeIndex
				echo "resolutionIndex="$resolutionIndex
				echo "suffix="$suffix
				if [ -f $(echo $dirOrFile) ] && [ -n "$(echo $seriesIndex | sed -n "/^[0-9]\{1,2\}$/p")" ] && [ -n "$(echo $episodeIndex | sed -n "/^[0-9]\{1,2\}$/p")" ] && [ -n "$(echo $timeIndex | sed -n "/^[0-9]\{4\}$/p")" ] && [ -n "$(echo $resolutionIndex | sed -n "/^[0-9]\{4\}P$/p")" ] 
				then
					setFileName $1 $newDirectory $file $seriesIndex $episodeIndex $timeIndex $resolutionIndex $suffix
				fi
			fi
		done
}

readDir $initDirectory

IFS=$SAVEIFS
#!/bin/bash
#Author			:Igor Szemela igor@wp.pl	
#Created on			:21.01.2021		
#Last Modified by		:Igor Szemela igor@wp.pl
#Last Modified on		:23.01.2021		
#Version			:1.0
#
#Description:
#Script allows user to search multimedia files and then run them in appropriate programs.
#
#Licensed under GPL (see /usr/share/common-licenses/GPL for more details
#or contact the Free Software Foundation for a copy)

FIND=" /home/igor/files/"
CHOICE=""
GIF=""
JPG=""
MP3=""
MP4=""
TXT=""
WAV=""


function Version { #dispalying script's version
	zenity --info --title "Version" --text "Mulitmedia Player version 1.0\n Creator: Igor Szemela" --width 250 --height 100 
}
 
function Help { #dispalying help for user
	zenity --info --title "Help" --text "Look for .gif file - find and run file with .gif format\n
Look for .jpg file - find and run file with .jpg format\n
Look for .mp3 file - find and run file with .mp3 format\n
Look for .mp4 file - find and run file with .mp4 format\n
Look for .txt file - find and run file with .txt format\n
Look for .wav file - find and run file with .wav format\n
Finish - finish script." --width 400 --height 200 
}

showList(){
CHOICE=$(zenity --list --column=Menu "${MENU[@]}" --width 280 --height 320)
}

menu(){
MENU=(	
	"Look for .gif file:" 
	"Look for .jpg file:" 
	"Look for .mp3 file:" 
	"Look for .mp4 file:" 
	"Look for .txt file:" 	
	"Look for .wav file:" 
	"Finish")
}

function main {
 
while [ "$CHOICE" != "Finish" ]
do

   menu	
   clear
   showList
   case "$CHOICE" in #handling finding files with appropriate formats
       "${MENU[0]}") GIF=$(find $FIND -type f -name "*.gif" | zenity --list --column "Choose file");;
       "${MENU[1]}") JPG=$(find $FIND -type f -name "*.jpg" | zenity --list --column "Choose file");;
       "${MENU[2]}") MP3=$(find $FIND -type f -name "*.mp3" | zenity --list --column "Choose file");;
       "${MENU[3]}") MP4=$(find $FIND -type f -name "*.mp4" | zenity --list --column "Choose file");;
       "${MENU[4]}") TXT=$(find $FIND -type f -name "*.txt" | zenity --list --column "Choose file");;
       "${MENU[5]}") WAV=$(find $FIND -type f -name "*.wav" | zenity --list --column "Choose file");;
       "${MENU[6]}") echo "Enough for today, let's finish";;
   esac
	  
   if [ -n "$GIF" ];
   then
	   mplayer $GIF
	   GIF=""
   fi

   if [ -n "$JPG" ];
   then
	   shotwell $JPG
	   JPG=""
   fi

   if [ -n "$MP3" ];
   then
	   mplayer $MP3
	   MP3=""
   fi

   if [ -n "$MP4" ];
   then
	   mplayer $MP4
	   MP4=""
   fi
   
   if [ -n "$TXT" ];
   then
	   nano $TXT
	   TXT=""
   fi
   
   if [ -n "$WAV" ];
   then
	   mplayer $WAV
	   WAV=""
   fi
    
   clear
done
}
while getopts hv OPT; do
		case $OPT in
			h) Help;;
			v) Version;; 
			*) exit;;
		esac
	done
main

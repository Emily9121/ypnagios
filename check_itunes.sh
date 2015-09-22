#!/bin/bash
#/bin/ksh
source_page='https://itunes.apple.com/us/tv-season/my-little-pony-friendship/id975102612'
total_eps=`curl --silent --connect-timeout 30 --max-time 60 --retry 6 ${source_page} | grep "Episodes</span>" | tr '<>' '[\n*]' | head -n3 | tail -n1 | sed -e 's/\([[:digit:]]\{1,2\}\) Episodes/\1/g'`
if [[ $# != 0 ]];then
   if [[ $1 -eq $total_eps ]];then
      echo "No new ponies :/"
      exit 0
   elif [[ -z $total_eps ]];then
      echo "Failed to Grab Page"
      exit 0
   else
      echo "Expected was $1 EP, found ${total_eps} EP"
      exit 2
   fi
else
   echo ${total_eps}
fi

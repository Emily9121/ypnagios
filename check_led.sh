#!/usr/bin/bash
### SCRIPT by FLYingG0D - Hooray for Ponies! ###

myImage='http://192.168.9.129:8080/shot.jpg'
#myImage='http://www.beautycolorcode.com/006600-500x500.png'

myOutput=`convert "${myImage}" -crop '1x1+400+300' txt:- | sed -n 2p | sed "s/.*srgb(\([0-9]*\),[0-9]*,[0-9]*).*/\1/g"`

if [[ `echo "${myOutput}"` -ge 150 ]] ; then
        echo "The LED is RED"
        exit 0
elif [[ `echo "${myOutput}"` -lt 150 ]] ; then
        echo "The LED is not RED"
        exit 2
else
        echo "I just don't know what went wrong"
        exit 1
fi

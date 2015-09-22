#!/usr/bin/bash
myPath=`pwd`
myBook=""
myBookInfo=""
myBookWebPage=""
mySearchURL=""
case $2 in
    ''|*[!0-9]*)
    	echo "ERROR - Usage: ${0##*/} [FF|FiM|A] <Search Number>"
    	exit 0
    ;;
    *) myBookNumber=$2 ;;
esac
case $1 in
	"FiM")
#			Friendship is Magic
		myBook="My Little Pony: Friendship is Magic #${myBookNumber}"
		mySearchURL="https://search.itunes.apple.com/WebObjects/MZSearch.woa/wa/search?entity=ebook&media=all&restrict=false&submit=seeAllLockups&term=my+little+pony+book+${myBookNumber}"
	;;
	"FF")
#			Friends Forever
		myBook="My Little Pony: Friends Forever #${myBookNumber}"
		mySearchURL="https://search.itunes.apple.com/WebObjects/MZSearch.woa/wa/search?entity=ebook&media=all&restrict=false&submit=seeAllLockups&term=my+little+pony+friends+forever+${myBookNumber}"
	;;
	"A")
#			TESTING PRE-ORDER
#			My Little Pony Annual ????
		myBook="My Little Pony Annual ${myBookNumber}"
		mySearchURL="https://search.itunes.apple.com/WebObjects/MZSearch.woa/wa/search?entity=ebook&media=all&restrict=false&submit=seeAllLockups&term=my+little+pony+${myBookNumber}"
	;;
	*)
    	echo "ERROR - Usage: ${0##*/} [FF|FiM|A] <Search Number>"
    	exit 0
	;;
esac
myBookWebPage=`curl -L -k -H "X-Apple-Store-Front: 143444,5" -H "X-Apple-Tz: 3600" -A "iTunes/9.2.1 (Macintosh; Intel Mac OS X 10.5.8) AppleWebKit/533.16"  --silent --connect-timeout 30 --max-time 60 --retry 6 "${mySearchURL}"`
myBookInfo=`echo "${myBookWebPage}" | grep "item-name=\"${myBook}\"" | grep -v "twitter"`
if [[ -z ${myBookWebPage} ]] ; then
	echo "ERROR: ${myBook} - Failed to Get Page! :/"
	exit 0
elif [[ `echo ${myBookInfo} | grep -c 'is-pre-order="1"'` -ge 1 ]] ; then
	echo "ERROR: ${myBook} - Pre-Order Only! :/"
	exit 0
elif [[ `echo ${myBookInfo} | grep -c 'aria-label="Buy Book'` -ge 1 ]] ; then
	echo "SUCCESS: ${myBook} - Avaialble for Purchase! :)"
	exit 2
else
	echo "ERROR: ${myBook} - Not Found! :/"
	exit 0
fi
#!/bin/bash
#Script to create zip archive with date and timestamp in name. 
confFile=$1
storeDir=$2

if [ $# -eq 0 ]; then
        echo "There are no arguments."
        exit
fi

if [ "$storeDir" = "" ]; then

currtime=$(date "+%T_%d-%m-%y")
 echo "$currtime"
zip /remote_homes/svukelic/$currtime $(grep .log$ $confFile | grep ^[^#])


grep ^[^#] $confFile | grep -v .log$ > dirfiles.txt

while read p;
do
        currtimeD=$(date "+%T_%d-%m-%y")
         echo "$currtimeD"
        zip /remote_homes/svukelic/D"$currtimeD" $(find $p -mmin +3000)
done < dirfiles.txt

else
        currtime=$(date "+%T_%d-%m-%y")
echo "$currtime"
zip $storeDir/$currtime $(grep .log$ $confFile | grep ^[^#])

grep ^[^#] $confFile | grep -v .log$ > dirfiles.txt
cat dirfiles.txt
while read p;
do
       currtimeD=$(date "+%T_%d-%m-%y")
        echo "$currtimeD"
        zip $storeDir/D"$currtimeD" $(find $p -mmin +3000)
done < dirfiles.txt

fi

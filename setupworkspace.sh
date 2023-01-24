#!/bin/bash
#Script for configuration user workspace.

echo "Choose your environment:
0 \f1\endash  artifactory
1 \endash  nexus
2 \endash  docker-compose
Abort operation: "."  "
read choice
if [  "$choice" = \. ]; then
        exit
fi
if [ "$choice" -eq 0 ]; then
        cd ~/tgengo_lab/artifactory
elif [ "$choice" -eq 1 ]; then
        cd ~/tgengo_lab/nexus
elif [  "$choice" -eq 2 ]; then
         cd ~/tgengo_lab/docker-compose
fi
echo "Type name  for your workspace:
(You can use: letters-small and capitals, numbers, underscore, and dash signs)"
read nameWorkspace

mkdir $nameWorkspace
cd $nameWorkspace
git init

echo "Would you like to stay on master branch?y/n"
read masterChoice
if [ "$masterChoice" = n ]; then
        echo "Type name of the new branch:"
        read nameNew
        git checkout -b "$nameNew"
fi
find . -maxdepth 3 '!' -name '.git' '!'  -name '.*' > fileforlinks.txt
while read p;
do
ln -s "$p" "$p".slink
done < $PWD/fileforlinks.txt
echo "Your workspace is created.
Location: $PWD
Available memory(Gigabyte): $(free -m | grep -i mem | awk '{print $4}')
Number of running processes: $(ps -e | wc -l)
"

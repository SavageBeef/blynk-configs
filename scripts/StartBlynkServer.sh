#! /bin/bash

cd "$(dirname "$(realpath "$0")")" 
directory=$(pwd)
echo "**************************"
echo "Starting Blynk Server"
echo "Script created by"
echo "SavageBeef" 
echo "**************************"
echo "based on CMD script by"
echo "Waleed El-Badry"
echo "waleed.elbadry@must.edu.eg"
echo "**************************"
echo "Your working directory is $directory"  
echo "**************************"

for ip in $(ip addr | grep "inet " | cut -d " " -f 6 | cut -d "/" -f 1); do
  	echo "Local Server IP Address is: $ip"
  	echo "Hardware Port : 8080"
		echo "Application Port : 9443"
	done
echo "**************************"
echo "Available server files"
ls -lh *.jar
for jar in $(ls server*.jar); do
	latestjar=$jar
done
echo "Server latest version in folder is $latestjar"

java -jar $latestjar -dataFolder server_data
: 'if [[ $? -ne 0 ||$? -ne 130 ]]; then
	echo "Server failed to start"
fi'


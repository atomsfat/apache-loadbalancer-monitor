#!/bin/bash

#webpage to monitor
web="www.google.com"

#users space separated sample: @atosmfat @lau
reportByMention="@atomsfat"
#users space separated without @
reportByDM="atomsfat"  
start_dir="$(pwd)"

#--------
# Absolute path to this script. 
SCRIPT=$(readlink -f $0)
# Absolute path this script is in.
SCRIPTPATH=`dirname $SCRIPT`

echo "===========running $0 $(date +'%T')]============="
echo "in path $SCRIPTPATH"
cd $SCRIPTPATH

function sendTweet(){
 echo "sendig tweet [$1 $(date +'%T')]"
 cd ../ttytter/
 ./1.1.11.txt -status="$1 $(date +'%T')"
 cd $SCRIPTPATH	
}

function sendDM(){

	for toDM in $reportByDM 
	do
	 sendTweet "/dm $toDM $1"
	done
}


function rp_error(){
	echo "reporting errores"
	msg="Ups problems in: $1"	
        sendDM "$msg"
    	sendTweet "$reportByMention $msg"

}




tempFile=.status_server
status_code=$(bash server_status.sh $web)

echo "===============web: $web status code: $status_code at $(date +'%T')======================"


if [ -n "$status_code" -a $status_code != '200' ];
	then
 	rp_error "$web code: $status_code"
fi    



echo "Done!"

cd $start_dir

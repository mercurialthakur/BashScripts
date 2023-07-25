#!/bin/bash

######################################################################################################################

myErr=/tmp/remote_error.log
myFile="$1"
alias sp='sshpass -p $myPass ssh -t -o ConnectTimeout=10 -o StrictHostKeyChecking=no $myUsr@$line'

#######Check if the parameter provided with the script is correct######
if [ "$#" -eq 1 -a -s "$myFile" ]
 then
     read -p "Enter your username: " myUsr
         stty -echo
     read -p "Enter your password: " myPass
         stty echo
	  else
	      echo -e "\n Syntax error: \nEither the file is empty or no filename"
          echo -e "\n Syntax: \n $0 <textfile name> \n"
 exit
 fi

######### Doing operation on the remote servers ########
rm -f $myErr
for line in `cat $myFile`
do
sp "sudo bash -s" < remote_cmd.sh 2> /dev/null
if [ $? -eq 0 ]
 then
     echo -e  "$line: OK"
 else
     echo "ssh to  $line failed" >> $myErr
 fi
done

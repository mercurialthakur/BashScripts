#!/bin/bash

######################################################################################################################
######################################################################################################################

myFile="$1"
alias sp='timeout 30 sshpass -p $myPass ssh -t -o ConnectTimeout=10 -o StrictHostKeyChecking=no $myUsr@$line'

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

for line in `cat $myFile`
do
#    timeout 30 sshpass -p $myPass sudo scp -p Svr_info_colct.sh $myUsr@$line:/var/tmp/
     sleep 2
     sp "sudo rpm --rebuilddb"
     if [ $? -eq 0 ]
       then
           echo -e  "$line: OK"
       else
           echo "ssh to  $line failed" >> vas_join_fail
       fi
     done

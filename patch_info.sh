#!/bin/bash

#### Define Variables here #####
myOpt=/tmp/output.txt
myLog=/tmp/patch_info.log
myErr=/tmp/patch_info_error.log
myFile="$1"

#######Check if the file provided as parameter is correct######
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

  #########Gathering info from remote servers########
  rm -f $myOpt
  for line in `cat $myFile`
      do
        sshpass -p $myPass ssh -o ConnectTimeout=10 -o StrictHostKeyChecking=no $myUsr@$line "> /tmp/$myUsr;cat /etc/redhat-release >> /tmp/$myUsr;rpm -qa --last | head -10 | tr -s ' ' ' ' | cut -d ' ' -f3,4,5 | uniq -c | sort -nr | head -1 >> /tmp/$myUsr" > /dev/null 2>&1
     if [ $? -eq 0 ]
       then
        sshpass -p $myPass scp -r $myUsr@$line:/tmp/$myUsr /tmp/tp.txt > /dev/null 2>&1
	echo "$line, `cat /tmp/tp.txt|tr -s '\n' ','`" >> $myOpt
	echo -e  "."
       else
     echo "ssh to $line failed"
     fi
done

while read SERVER PASSWORD
do
  sshpass -e scp /home/user/file "$SERVER":/path/
  done <./file_list


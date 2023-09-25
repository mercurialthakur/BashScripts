#!/bin/bash

#Query multiple servers for splunk agent and save output in file.
for server in $(cat serverlist); do sshpass -f pass_file ssh -t -o ConnectTimeout=10 -o StrictHostKeyChecking=no $server "echo -e \"Server: $server: \$(sudo rpm -qa splunkforwarder)\"" 2> /dev/null >> splunk_output.txt; done

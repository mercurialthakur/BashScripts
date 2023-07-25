uptime
needs-restarting -r
uname -a
ls -l /etc/sysconfig/rhn/allowed-actions/script/run
sudo package-cleanup -y --oldkernels --count=1
sudo service sshd restart
df -Ph /boot /var /var/log
rpm -qa kernel
pwsh --version
sudo yum --enablerepo=centos-7-latest-updates-x86_64 clean metadata
git --version

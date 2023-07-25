#!/bin/bash

svr_nme=`hostname`
info_dir=/var/tmp
dsk_info=$info_dir/disk_info
memry_info=$info_dir/memory_info
rte_info=$info_dir/route_info
ntwrk_info=$info_dir/network_info
ps_info=$info_dir/ps_info
srvs_info=$info_dir/services_info
mtipth_info=$info_dir/multipath_info
sys_pra_info=$info_dir/sysctl_info
svr_info=$info_dir/Server_cfg_info
fdsk_info=$info_dir/fdsk_info
mnts_info=$info_dir/mounts_info
blkls_info=$info_dir/lsblk_info

rm -f $info_dir/*_info

echo -e "======================== $svr_nme config info ==========================\n\n" >> $svr_info
echo -e "uptime: `uptime`" >> $svr_info
echo -e "Kernel Version: `uname -r`" >> $svr_info
echo -e "=====================Memory =======================\n" >> $svr_info
free -g >> $svr_info
cat /proc/meminfo  | egrep -i "memtotal|swaptotal" | awk '{print $2}' > $memry_info
cat /proc/meminfo  | egrep -i "memtotal|swaptotal" >> $svr_info
echo -e "=====================Disk =========================\n" >> $svr_info
df -h >> $svr_info
echo -e "\n\nFstab output=======" >> $svr_info
cat /etc/fstab >> $svr_info
df -h > $dsk_info
/sbin/fdisk -l > $fdsk_info
cat /proc/mounts > $mnts_info
lsblk > $blkls_info
echo -e "\n\nMount output=======" >> $svr_info
cat /proc/mounts >> $svr_info

echo -e "====================Network =======================\n" >> $svr_info
/sbin/ifconfig -a >> $svr_info
/sbin/ifconfig -a > $ntwrk_info
eth_adptr=`/sbin/ifconfig -a | head -1 | awk '{print $1}' | sed -e 's/:$//g'`

if [[ $eth_adptr == bond* ]]
 then
     cat /proc/net/bonding/$eth_adptr >> $ntwrk_info
         /sbin/ethtool $eth_adptr >> $ntwrk_info
	     for eth in `cat /proc/net/bonding/bond0  | grep "Slave Interface" | cut -d ' ' -f3`; do echo -e "\n **************************ethtool output *********************************\n";/sbin/ethtool $eth;done >> $ntwrk_info
 else
     #ethtool $eth_adptr >> $ntwrk_info
             for eth in `/sbin/ifconfig | egrep "^e|^b" | awk '{print $1}' | awk -F ":" '{print $1}'`; do /sbin/ethtool $eth; done >> $ntwrk_info
	             /sbin/ip a >> $ntwrk_info
		     fi
		     cat $ntwrk_info >> $svr_info
		     echo -e "\n\nRoute output =======" >> $svr_info
		     netstat -nr >> $svr_info
		     netstat -nr > $rte_info
		     echo -e "====================Running Process ================\n" >> $svr_info
		     ps -aux >> $ps_info
		     ps -aux >> $svr_info
		     echo -e "======================Services Active ===============\n" >> $svr_info
		     systemctl list-units --type service --state active >> $svr_info
		     systemctl list-units --type service --state active > $srvs_info
		     /sbin/chkconfig --list  >> $srvs_info
		     echo -e "==================Multipath Info=====================\n\n" >> $svr_info
		     multipath -ll >> $svr_info
		     multipath -ll > $mtipth_info
		     echo -e "\n ************** Multipath config ********************\n\n" >> $mtipth_info
		     cat /etc/multipath.conf >> $mtipth_info
		     echo -e "==================Kernel Parameters==================\n\n" >> $svr_info
		     cat /etc/sysctl.conf >> $svr_info
		     cat /etc/sysctl.conf > $sys_pra_info
		     echo -e "\n\n ******* loaded Modules ********\n\n" >> $sys_pra_info
		     lsmod >> $sys_pra_info
		     echo -e "===================DNS server Entries================\n\n" >> $svr_info
		     cat /etc/resolv.conf >> $svr_info


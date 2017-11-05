#!/bin/bash
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

echo "
  ____                                   _       _____           
 / ___|  ___  ___ _   _ _ __ ___        / \     |_   _|   ___  __
 \___ \ / _ \/ __| | | | '__/ _ \_____ / _ \ _____| || | | \ \/ /
  ___) |  __/ (__| |_| | | |  __/_____/ ___ \_____| || |_| |>  < 
 |____/ \___|\___|\__,_|_|  \___|    /_/   \_\    |_| \__,_/_/\_\
                                                                 "

echo -e "\e[1;32mWelcome to Secure-A-Tux v2 'Magnum Opus'\e[0m"
echo -e "\e[1;32mBy: Jude Poole\e[0m"
echo -e "\e[1;32m----------------------------------------\e[0m"
echo -e "\e[0;36mWhat is your username (home directory)?\e[0m"
read username
echo -e "\e[0;36mHello $username\e[0m"

#Updating apt folder with fixed config files and repositories
echo -e "\e[0;36mUpdating apt folder with fixed config files and repositories\e[0m"
apt-cache policy
read -rsp $'\e[1;31mHow does this look? If it looks fine, feel free to answer N for the next promt. If not, answer Y. Press space to continue...\e[0m\n' -n1 key
echo -e "\e[1;32m----------------------------------------\e[0m"
apt-key list
read -rsp $'\e[1;31mHow does this look? If it looks fine, feel free to answer N for the next promt. If not, answer Y. Press space to continue...\e[0m\n' -n1 key

read -p "Are you on Ubuntu 14? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    mv /etc/apt/sources.list /home/$username/SecureATux/Backups/
    mv /etc/apt/trustdb.gpg /home/$username/SecureATux/Backups/
    mv /etc/apt/trusted.gpg /home/$username/SecureATux/Backups/
    cp /home/$username/SecureATux/sources.list /etc/apt/
    cp /home/$username/SecureATux/sources.list.save /etc/apt/
    cp /home/$username/SecureATux/trustdb.gpg /etc/apt/
    cp /home/$username/SecureATux/trusted.gpg /etc/apt/
    #apt.conf.f
    mv /etc/apt/apt.conf.d/00aptitude /home/$username/SecureATux/Backups/
    mv /etc/apt/apt.conf.d/00trustcdrom /home/$username/SecureATux/Backups/
    mv /etc/apt/apt.conf.d/01autoremove /home/$username/SecureATux/Backups/
    mv /etc/apt/apt.conf.d/01autoremove-kernels /home/$username/SecureATux/Backups/
    mv /etc/apt/apt.conf.d/10periodic /home/$username/SecureATux/Backups/
    mv /etc/apt/apt.conf.d/15update-stamp /home/$username/SecureATux/Backups/
    mv /etc/apt/apt.conf.d/20archive /home/$username/SecureATux/Backups/
    mv /etc/apt/apt.conf.d/20changelog /home/$username/SecureATux/Backups/
    mv /etc/apt/apt.conf.d/20dbus /home/$username/SecureATux/Backups/
    mv /etc/apt/apt.conf.d/50unattended-upgrades /home/$username/SecureATux/Backups/
    mv /etc/apt/apt.conf.d/70debconf /home/$username/SecureATux/Backups/
    mv /etc/apt/apt.conf.d/99update-notifier /home/$username/SecureATux/Backups/
    cp /home/$username/SecureATux/00aptitude /etc/apt/apt.conf.d/
    cp /home/$username/SecureATux/00trustcdrom /etc/apt/apt.conf.d/
    cp /home/$username/SecureATux/01autoremove /etc/apt/apt.conf.d/
    cp /home/$username/SecureATux/01autoremove-kernels /etc/apt/apt.conf.d/
    cp /home/$username/SecureATux/10periodic /etc/apt/apt.conf.d/
    cp /home/$username/SecureATux/15update-stamp /etc/apt/apt.conf.d/
    cp /home/$username/SecureATux/20archive /etc/apt/apt.conf.d/
    cp /home/$username/SecureATux/20changelog /etc/apt/apt.conf.d/
    cp /home/$username/SecureATux/20dbus /etc/apt/apt.conf.d/
    cp /home/$username/SecureATux/50unattended-upgrades /etc/apt/apt.conf.d/
    cp /home/$username/SecureATux/70debconf /etc/apt/apt.conf.d/
    cp /home/$username/SecureATux/99update-notifier /etc/apt/apt.conf.d/
fi

clear

echo -e "\e[0;36mUsing the GUI, schedule automatic updates\e[0m"
read -rsp $'\e[1;31mSchedule automatic updates and then press space to continue...\e[0m\n' -n1 key
read -rsp $'\e[1;31mAnswer forensics questions and then press space to continue...\e[0m\n' -n1 key
echo -e "\e[0;36mInstalling gnome-system-tools for UAC\e[0m"
apt-get -y install gnome-system-tools
clear
cat /etc/passwd | awk -F: '($3 == 0) { print $1 }'
echo -e "\e[0;36mEnsure that root is the only UID 0 account, otherwise remove the other users, or assign them a new UID\e[0m"
echo -e "\e[0;36mNow, check UAC ensuring that authorized users are permitted and given proper permissions (CHANGE INSECURE PASSWORDS) (NO USERS SHOULD BE IN SHADOW GROUP)\e[0m"
clear
echo -e "\e[0;36mDisabling root account\e[0m"
sudo passwd -l root
clear
ls /etc/cron.d
echo -e "\e[1;32m----------------------------------------\e[0m"
ls /etc/cron.hourly
echo -e "\e[1;32m----------------------------------------\e[0m"
ls /etc/cron.daily
echo -e "\e[1;32m----------------------------------------\e[0m"
ls /etc/cron.weekly
echo -e "\e[1;32m----------------------------------------\e[0m"
ls /etc/cron.monthly
echo -e "\e[1;32m----------------------------------------\e[0m"
ls /etc/cron.d
echo -e "\e[1;32m----------------------------------------\e[0m"
read -rsp $'\e[1;31mHow does cron look? [ENSURE CRON AS A SERVICE IS ENABLED] Press space to continue...\e[0m\n' -n1 key
chown root:root /etc/cron.hourly
chmod og-rwx /etc/cron.hourly
chown root:root /etc/cron.daily
chmod og-rwx /etc/cron.daily
chown root:root /etc/cron.weekly
chmod og-rwx /etc/cron.weekly
chown root:root /etc/cron.monthly
chmod og-rwx /etc/cron.monthly
chown root:root /etc/cron.d
chmod og-rwx /etc/cron.d
clear

#Anacrontab and crontab
read -p "Do you want to import an /etc/anacrontab and /etc/crontab file? (so long as the folders above are empty, thats fine)" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    mv /etc/anacrontab /home/$username/SecureATux/Backups/
    cp /home/$username/SecureATux/anacrontab /etc/
    mv /etc/crontab /home/$username/SecureATux/Backups/
    cp /home/$username/SecureATux/crontab /etc/
fi
chown root:root /etc/anacrontab
chmod og-rwx /etc/anacrontab
chown root:root /etc/crontab
chmod og-rwx /etc/crontab
clear

ls /home/ -R
read -rsp $'\e[1;31mHow do the users directories look? (Remember to check hidden files) Press space to continue...\e[0m\n' -n1 key
clear

echo -e "\e[0;36mRemoving hacking tools (in case they are present)\e[0m"
apt-get -y remove john
apt-get -y remove hydra-gtk
apt-get -y autoremove
clear

echo -e "\e[0;36mNow enabling UFW firewall and importing hosts.allow and hosts.deny\e[0m"
ufw enable
ufw logging high
cp /home/$username/SecureATux/hosts.allow /etc/
cp /home/$username/SecureATux/hosts.deny /etc/
chown root:root /etc/hosts.allow
chmod 644 /etc/hosts.allow
chown root:root /etc/hosts.deny
chmod 644 /etc/hosts.deny
clear

echo -e "\e[0;36mNow installing clamAV, chkrootkit, and rkhunter\e[0m"
sleep 5
apt-get -y install clamav clamav-daemon clamav-freshclam clamtk rkhunter
clear

#TEST THIS
gnome-terminal -e rkhunter -c
gedit /home/$username/SecureATux/info
clear

echo -e "\e[0;36mInstalling bum for bootup script management\e[0m"
apt-get -y install bum
read -rsp $'\e[1;31mUse bum if needed, then press space to continue...\e[0m\n' -n1 key
clear

read -p $'\e[1;31mIs there an SSH server that you want secured? [y/n] \e[0m\n' -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    ufw allow ssh
    mv /etc/ssh/sshd_config /home/$username/SecureATux/Backups/
    cp /home/$username/SecureATux/sshd_config /etc/ssh/
    chown root:root /etc/ssh/sshd_config
    chmod og-rwx /etc/ssh/sshd_config
    echo Restarting sshd...
    systemctl restart sshd
    echo ...done
fi

#WEBSERVER
read -p $'\e[1;31mIs there a LAMP/Web server that you want secured? [y/n] \e[0m\n' -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    ufw allow http
    ufw allow https
    echo ADD MORE
fi

#Add more services here

clear
apt-get -y install libpam-cracklib
mv /etc/login.defs /home/$username/SecureATux/Backups/
cp /home/$username/SecureATux/login.defs /etc/
useradd -D -f 30

chown root:root /etc/passwd
chmod 644 /etc/passwd
chown root:shadow /etc/shadow
chmod o-rwx,g-wx /etc/shadow
chown root:root /etc/group
chmod 644 /etc/group
chown root:shadow /etc/gshadow
chmod o-rwx,g-rw /etc/gshadow
chown root:root /etc/passwd-
chmod 600 /etc/passwd-
chown root:root /etc/shadow-
chmod 600 /etc/shadow-
chown root:root /etc/group-
chmod 600 /etc/group-
chown root:root /etc/gshadow-
chmod 600 /etc/gshadow-

#Updating lightdm folder with fixed config files
echo -e "\e[0;36mUpdating lightdm folder with fixed config files\e[0m"
mv /etc/lightdm/users.conf /home/$username/SecureATux/Backups/
cp /home/$username/SecureATux/users.conf /etc/lightdm/



read -rsp $'\e[1;31mHow does the sudoers file look? Check include directory so that it is only the sudoers file. Press space to continue...\e[0m\n' -n1 key











function 14 {
    echo -e "\e[0;36mDisabling guest account\e[0m"
    sed '$ a allow-guest=false' /etc/lightdm/lightdm.conf
    echo -e "\e[0;36mRESTART VM ONCE COMPLETE\e[0m"
    read -rsp $'\e[0;36mDouble check the /etc/lightdm/lightdm.conf so that this worked [SPACE]\e[0m\n' -n1 key
    clear

    #AIDE initilization (Page 49)
    
    #apt-get install aide
    #aideinit

    #Apparmor install
    apt-get -y install apparmor
    apt-get -y install apparmor-utils
    aa-enforce /etc/apparmor.d/*
    apparmor_status

    #Ensure permissions on /etc/issue are configured (1.7.1.5)
    chown root:root /etc/issue
    chmod 644 /etc/issue
    stat /etc/issue

    #Ensure permissions on /etc/issue.net are configured (1.7.1.5)
    chown root:root /etc/issue.net
    chmod 644 /etc/issue.net
    stat /etc/issue.net

    #Services disabling
    echo -e "\e[0;36mServices disabling\e[0m"
    #Ensure that this command runs nothing (chargen service)
    echo -e "\e[1;32mEnsure that this command runs nothing for checking the chargen service\e[0m"
    grep -R "^chargen" /etc/inetd.*
    read -rsp $'\e[1;31mDoes this command have nothing? If not, remove chargen services by checking /etc/xinetd.conf and /etc/xinetd.d/* and verifying all chargen services have disable = yes set. Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs nothing (daytime service)
    echo -e "\e[1;32mEnsure that this command runs nothing for checking the daytime service\e[0m"
    grep -R "^daytime" /etc/inetd.*
    read -rsp $'\e[1;31mDoes this command have nothing? If not, remove daytime services by checking /etc/xinetd.conf and /etc/xinetd.d/* and verifying all daytime services have disable = yes set. Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs nothing (discard)
    echo -e "\e[1;32mEnsure that this command runs nothing for checking the discard service\e[0m"
    grep -R "^discard" /etc/inetd.*
    read -rsp $'\e[1;31mDoes this command have nothing? If not, remove discard services by checking /etc/xinetd.conf and /etc/xinetd.d/* and verifying all discard services have disable = yes set. Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs nothing (echo)
    echo -e "\e[1;32mEnsure that this command runs nothing for checking the echo service\e[0m"
    grep -R "^echo" /etc/inetd.*
    read -rsp $'\e[1;31mDoes this command have nothing? If not, remove echo services by checking /etc/xinetd.conf and /etc/xinetd.d/* and verifying all echo services have disable = yes set. Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs nothing (time)
    echo -e "\e[1;32mEnsure that this command runs nothing for checking the time service\e[0m"
    grep -R "^time" /etc/inetd.*
    read -rsp $'\e[1;31mDoes this command have nothing? If not, remove time services by checking /etc/xinetd.conf and /etc/xinetd.d/* and verifying all time services have disable = yes set. Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs nothing (rsh)
    echo -e "\e[1;32mEnsure that this command runs nothing for checking the rsh service\e[0m"
    grep -R "^shell" /etc/inetd.* 
    grep -R "^login" /etc/inetd.* 
    grep -R "^exec" /etc/inetd.*
    read -rsp $'\e[1;31mDoes this command have nothing? If not, remove rsh, rlogin, and rexec services by checking /etc/xinetd.conf and /etc/xinetd.d/* and verifying all rsh, rlogin, and rexec services have disable = yes set. Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs nothing (talk)
    echo -e "\e[1;32mEnsure that this command runs nothing for checking the talk service\e[0m"
    grep -R "^talk" /etc/inetd.* 
    grep -R "^ntalk" /etc/inetd.*
    read -rsp $'\e[1;31mDoes this command have nothing? If not, remove talk services by checking /etc/xinetd.conf and /etc/xinetd.d/* and verifying all talk services have disable = yes set. Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs nothing (telnet)
    echo -e "\e[1;32mEnsure that this command runs nothing for checking the telnet service\e[0m"
    grep -R "^telnet" /etc/inetd.*
    read -rsp $'\e[1;31mDoes this command have nothing? If not, remove telnet services by checking /etc/xinetd.conf and /etc/xinetd.d/* and verifying all telnet services have disable = yes set. Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs nothing (tftp)
    echo -e "\e[1;32mEnsure that this command runs nothing for checking the tftp service\e[0m"
    grep -R "^tftp" /etc/inetd.*
    read -rsp $'\e[1;31mDoes this command have nothing? If not, remove tftp services by checking /etc/xinetd.conf and /etc/xinetd.d/* and verifying all tftp services have disable = yes set. Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs xinetd (xinetd)
    echo -e "\e[1;32mEnsure that this command runs 'xinetd' for checking the xinetd service\e[0m"
    initctl show-config xinetd
    read -rsp $'\e[1;31mDoes this command have xinetd? If not, remove or comment out start lines in /etc/init/xinetd.conf: #start on runlevel [2345] . Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs avahi-daemon (avahi-daemon)
    echo -e "\e[1;32mEnsure that this command runs 'avahi-daemon' for checking the avahi-daemon service\e[0m"
    initctl show-config avahi-daemon
    read -rsp $'\e[1;31mDoes this command have avahi-daemon? If not, remove or comment out start lines in /etc/init/avahi-daemon.conf: #start on runlevel [2345] . Space to continue... \e[0m\n' -n1 key

    echo -e "\e[0;36mImportant services ahead, be very careful!\e[0m"

    #Ensure that this command runs cups (cups). DO NOT REMOVE IF YOU NEED A PRINTER
    echo -e "\e[1;32mEnsure that this command runs 'cups' for checking the cups service. DO NOT REMOVE IF YOU NEED A PRINTER\e[0m"
    initctl show-config cups
    read -rsp $'\e[1;31mDoes this command have cups? If not, remove or comment out start lines in /etc/init/cups.conf: #start on runlevel [2345] . Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs isc-dhcp-server / isc-dhcp-server6 (DHCP). DO NOT REMOVE IF YOU NEED DHCP
    echo -e "\e[1;32mEnsure that this command runs 'isc-dhcp-server / isc-dhcp-server6' for checking the DHCP service. DO NOT REMOVE IF YOU NEED DHCP\e[0m"
    initctl show-config isc-dhcp-server
    initctl show-config isc-dhcp-server6
    read -rsp $'\e[1;31mDoes this command have isc-dhcp-server / isc-dhcp-server6? If not, remove or comment out start lines in /etc/init/isc-dhcp-server.conf and /etc/init/isc-dhcp-server6.conf: #start on runlevel [2345] . Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs nothing (LDAP). DO NOT REMOVE IF YOU NEED LDAP
    echo -e "\e[1;32mEnsure that this command runs nothing. DO NOT REMOVE IF YOU NEED LDAP\e[0m"
    ls /etc/rc*.d/S*slapd  
    read -rsp $'\e[1;31mDoes this command have nothing? If not, run "sudo update-rc.d slapd disable" . Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs nothing (nfs-kernel-server). DO NOT REMOVE IF YOU NEED NFS
    echo -e "\e[1;32mEnsure that this command runs nothing. DO NOT REMOVE IF YOU NEED NFS\e[0m"
    ls /etc/rc*.d/S*nfs-kernel-server
    read -rsp $'\e[1;31mDoes this command have nothing? If not, run "sudo update-rc.d nfs-kernel-server disable" . Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs rpcbind (RPC). DO NOT REMOVE IF YOU NEED RPC
    echo -e "\e[1;32mEnsure that this command runs 'rpcbind' for checking the RPC service. DO NOT REMOVE IF YOU NEED RPC\e[0m"
    initctl show-config rpcbind
    read -rsp $'\e[1;31mDoes this command have rpcbind? If not, remove or comment out start lines in /etc/init/rpcbind.conf: #start on start-rpcbind . Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs nothing (bind9). DO NOT REMOVE IF YOU NEED DNS
    echo -e "\e[1;32mEnsure that this command runs nothing. DO NOT REMOVE IF YOU NEED DNS\e[0m"
    ls /etc/rc*.d/S*bind9
    read -rsp $'\e[1;31mDoes this command have nothing? If not, run "sudo update-rc.d bind9 disable" . Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs vsftpd (ftp). DO NOT REMOVE IF YOU NEED FTP
    echo -e "\e[1;32mEnsure that this command runs 'vsftpd' for checking the vsftpd service. DO NOT REMOVE IF YOU NEED FTP\e[0m"
    initctl show-config vsftpd
    read -rsp $'\e[1;31mDoes this command have vsftpd? If not, remove or comment out start lines in /etc/init/vsftpd.conf: #start on runlevel [2345] or net-device-up IFACE!=lo . Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs nothing (apache2). DO NOT REMOVE IF YOU NEED HTTP
    echo -e "\e[1;32mEnsure that this command runs nothing. DO NOT REMOVE IF YOU NEED HTTP\e[0m"
    ls /etc/rc*.d/S*apache2
    read -rsp $'\e[1;31mDoes this command have nothing? If not, run "sudo update-rc.d apache2 disable" . Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs dovecot (IMAP/POP3). DO NOT REMOVE IF YOU NEED IMAP/POP3
    echo -e "\e[1;32mEnsure that this command runs 'dovecot' for checking the dovecot service. DO NOT REMOVE IF YOU NEED IMAP/POP3\e[0m"
    initctl show-config dovecot
    read -rsp $'\e[1;31mDoes this command have dovecot? If not, remove or comment out start lines in /etc/init/dovecot.conf: #start on runlevel [2345] . Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs smbd (Samba). DO NOT REMOVE IF YOU NEED Samba
    echo -e "\e[1;32mEnsure that this command runs 'smbd' SAMBA for checking the smbd SAMBA service. DO NOT REMOVE IF YOU NEED Samba\e[0m"
    initctl show-config smbd
    read -rsp $'\e[1;31mDoes this command have smbd? If not, remove or comment out start lines in /etc/init/smbd.conf: start on (local-filesystems and net-device-up) . Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs squid3 (HTTP Proxy). DO NOT REMOVE IF YOU NEED HTTP Proxy
    echo -e "\e[1;32mEnsure that this command runs 'squid3' for checking the HTTP Proxy service. DO NOT REMOVE IF YOU NEED HTTP Proxy\e[0m"
    initctl show-config squid3
    read -rsp $'\e[1;31mDoes this command have squid3? If not, remove or comment out start lines in /etc/init/squid3.conf: #start on runlevel [2345] . Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs nothing (snmpd). DO NOT REMOVE IF YOU NEED SNMP
    echo -e "\e[1;32mEnsure that this command runs nothing. DO NOT REMOVE IF YOU NEED SNMP\e[0m"
    ls /etc/rc*.d/S*snmpd
    read -rsp $'\e[1;31mDoes this command have nothing? If not, run "sudo update-rc.d snmpd disable" . Space to continue... \e[0m\n' -n1 key

    read -p "If you are running snmpd (postfix), then say Y. If not, say N: " -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
          read -rsp $'\e[1;31mEdit /etc/postfix/main.cf and add the following line to the RECEIVING MAIL section. "inet_interfaces = localhost" Then, run "service postfix restart" . Space to continue... \e[0m\n' -n1 key 
    fi

    #Ensure that this command runs rsyncd (rsync). DO NOT REMOVE IF YOU NEED rsync
    echo -e "\e[1;32mEnsure that this command runs 'RSYNC_ENABLE=false' for checking the rsync service. DO NOT REMOVE IF YOU NEED rsync\e[0m"
    grep ^RSYNC_ENABLE /etc/default/rsync
    read -rsp $'\e[1;31mDoes this command have RSYNC_ENABLE=false? If not, edit the /etc/default/rsync file and set RSYNC_ENABLE to false: RSYNC_ENABLE=false . Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs ypserv (NIS / Yellow Pages). DO NOT REMOVE IF YOU NEED NIS / Yellow Pages / ypserv
    echo -e "\e[1;32mEnsure that this command runs 'ypserv' for checking the NIS / Yellow Pages / ypserv service. DO NOT REMOVE IF YOU NEED NIS / Yellow Pages / ypserv\e[0m"
    initctl show-config ypserv
    read -rsp $'\e[1;31mDoes this command have ypserv? If not, remove or comment out start lines in /etc/init/ypserv.conf: #start on (started portmap ON_BOOT= # or (started portmap ON_BOOT=y # and ((filesystem and static-network-up) or failsafe-boot))) . Space to continue... \e[0m\n' -n1 key

    echo -e "\e[0;36mNow, it's time for ensuring clients arent installed unless they need to be\e[0m"

    #Ensure that after running this command, nis is not installed, unless you need a NIS client.
    echo -e "\e[1;32mEnsure that after running this command, nis is not installed, unless you need a NIS client.\e[0m"
    dpkg -s nis
    read -rsp $'\e[1;31mIs this not installed? If it is, run "sudo apt-get remove nis" . Space to continue... \e[0m\n' -n1 key

    #Ensure that after running this command, rsh is not installed, unless you need a rsh client.
    echo -e "\e[1;32mEnsure that after running this command, rsh is not installed, unless you need a rsh client.\e[0m"
    dpkg -s rsh-client 
    dpkg -s rsh-redone-client
    read -rsp $'\e[1;31mIs this not installed? If it is, run "sudo apt-get remove rsh-client rsh-redone-client" . Space to continue... \e[0m\n' -n1 key

    #Ensure that after running this command, talk is not installed, unless you need a talk client.
    echo -e "\e[1;32mEnsure that after running this command, talk is not installed, unless you need a talk client.\e[0m"
    dpkg -s talk
    read -rsp $'\e[1;31mIs this not installed? If it is, run "sudo apt-get remove talk" . Space to continue... \e[0m\n' -n1 key

    #Ensure that after running this command, telnet is not installed, unless you need a telnet client.
    echo -e "\e[1;32mEnsure that after running this command, telnet is not installed, unless you need a telnet client.\e[0m"
    dpkg -s telnet
    read -rsp $'\e[1;31mIs this not installed? If it is, run "sudo apt-get remove telnet" . Space to continue... \e[0m\n' -n1 key

    #Ensure that after running this command, ldap-utils is not installed, unless you need a LDAP client.
    echo -e "\e[1;32mEnsure that after running this command, ldap-utils is not installed, unless you need a LDAP client.\e[0m"
    dpkg -s ldap-utils
    read -rsp $'\e[1;31mIs this not installed? If it is, run "sudo apt-get remove ldap-utils" . Space to continue... \e[0m\n' -n1 key

    echo -e "\e[0;36mNow, it's time for setting important network parameters\e[0m"
    mv /etc/security/limits.conf /etc/security/limits_conf.bkup
    cp /home/$username/SecureATux/14/limits.conf /etc/security
    mv /etc/sysctl.conf /etc/sysctl_conf.bkup
    cp /home/$username/SecureATux/14/sysctl.conf /etc/
    sysctl -w net.ipv4.ip_forward=0
    sysctl -w net.ipv4.conf.all.accept_source_route=0
    sysctl -w net.ipv4.conf.default.accept_source_route=0
    sysctl -w net.ipv4.conf.all.accept_redirects=0
    sysctl -w net.ipv4.conf.default.accept_redirects=0
    sysctl -w net.ipv4.conf.all.secure_redirects=0
    sysctl -w net.ipv4.conf.default.secure_redirects=0
    sysctl -w net.ipv4.conf.all.log_martians=1
    sysctl -w net.ipv4.conf.default.log_martians=1
    sysctl -w net.ipv4.icmp_echo_ignore_broadcasts=1
    sysctl -w net.ipv4.icmp_ignore_bogus_error_responses=1
    sysctl -w net.ipv4.conf.all.rp_filter=1
    sysctl -w net.ipv4.conf.default.rp_filter=1
    sysctl -w net.ipv4.tcp_syncookies=1
    sysctl -w fs.suid_dumpable=0
    sysctl -w kernel.randomize_va_space=2

    sysctl -w net.ipv4.route.flush=1

    apt-get -y install auditd 
    update-rc.d auditd enable
    clear
    echo -e "\e[1;32mAdd this line to /etc/default/grub to disable IPv6 'GRUB_CMDLINE_LINUX=\"ipv6.disable=1\"\e[0m"
    echo -e "\e[1;32mAdd this line to /etc/default/grub to disable IPv6 'GRUB_CMDLINE_LINUX=\"audit=1\"\e[0m"
    read -rsp $'\e[1;31mPress space once complete\e[0m\n' -n1 key
    update-grub
    chown root:root /boot/grub/grub.cfg
    chmod og-rwx /boot/grub/grub.cfg

    #Ensure that your end machine has TCP Wrappers installed
    echo -e "\e[1;32mEnsure that your end machine has TCP Wrappers installed\e[0m"
    dpkg -s tcpd
    echo -e "\e[1;32mIf it is not installed, run 'sudo apt-get install tcpd' \e[0m"
    read -rsp $'\e[1;31mSpace to continue... \e[0m\n' -n1 key
    clear

    #Ensure that your end machine has iptables installed
    echo -e "\e[1;32mEnsure that your end machine has iptables installed\e[0m"
    dpkg -s iptables
    echo -e "\e[1;32mIf it is not installed, run 'sudo apt-get install iptables' \e[0m"
    read -rsp $'\e[1;31mSpace to continue... \e[0m\n' -n1 key
    clear    

    echo -e "\e[1;32mConfiguring default deny firewall policy\e[0m"
    iptables -P INPUT DROP
    iptables -P OUTPUT DROP
    iptables -P FORWARD DROP

    echo -e "\e[1;32mSecuring loopback\e[0m"
    iptables -A INPUT -i lo -j ACCEPT
    iptables -A OUTPUT -o lo -j ACCEPT
    iptables -A INPUT -s 127.0.0.0/8 -j DROP
    clear

    echo -e "\e[0;36mNow printing all services\e[0m"
    service --status-all
    read -rsp $'\e[1;31mHow do the services look? Press space to continue...\e[0m\n' -n1 key
    clear
    read -rsp $'\e[1;31mRun software updater in GUI and Remember to enact password policy. Press space to continue...\e[0m\n' -n1 key
}

function 16 {
    echo -e "\e[0;36mDisabling guest account\e[0m"
    mkdir /etc/lightdm/lightdm.conf.d
    sh -c 'printf "[SeatDefaults]\nallow-guest=false\n" > /etc/lightdm/lightdm.conf.d/50-no-guest.conf'
    read -rsp $'\e[0;36mDouble check the /etc/lightdm/lightdm.conf.d/50-no-guest.conf so that this worked [SPACE]\e[0m\n' -n1 key
    clear

    #Apparmor install
    apt-get -y install apparmor
    apt-get -y install apparmor-utils
    aa-enforce /etc/apparmor.d/*
    apparmor_status
   
    #Services disabling
    echo -e "\e[1;32mEnsure that this command runs nothing for checking the chargen service\e[0m"
    grep -R "^chargen" /etc/inetd.*
    read -rsp $'\e[1;31mDoes this command have nothing? If not, remove chargen services by checking /etc/xinetd.conf and /etc/xinetd.d/* and verifying all chargen services have disable = yes set. Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs nothing (daytime service)
    echo -e "\e[1;32mEnsure that this command runs nothing for checking the daytime service\e[0m"
    grep -R "^daytime" /etc/inetd.*
    read -rsp $'\e[1;31mDoes this command have nothing? If not, remove daytime services by checking /etc/xinetd.conf and /etc/xinetd.d/* and verifying all daytime services have disable = yes set. Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs nothing (discard)
    echo -e "\e[1;32mEnsure that this command runs nothing for checking the discard service\e[0m"
    grep -R "^discard" /etc/inetd.*
    read -rsp $'\e[1;31mDoes this command have nothing? If not, remove discard services by checking /etc/xinetd.conf and /etc/xinetd.d/* and verifying all discard services have disable = yes set. Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs nothing (echo)
    echo -e "\e[1;32mEnsure that this command runs nothing for checking the echo service\e[0m"
    grep -R "^echo" /etc/inetd.*
    read -rsp $'\e[1;31mDoes this command have nothing? If not, remove echo services by checking /etc/xinetd.conf and /etc/xinetd.d/* and verifying all echo services have disable = yes set. Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs nothing (time)
    echo -e "\e[1;32mEnsure that this command runs nothing for checking the time service\e[0m"
    grep -R "^time" /etc/inetd.*
    read -rsp $'\e[1;31mDoes this command have nothing? If not, remove time services by checking /etc/xinetd.conf and /etc/xinetd.d/* and verifying all time services have disable = yes set. Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs nothing (rsh)
    echo -e "\e[1;32mEnsure that this command runs nothing for checking the rsh service\e[0m"
    grep -R "^shell" /etc/inetd.* 
    grep -R "^login" /etc/inetd.* 
    grep -R "^exec" /etc/inetd.*
    read -rsp $'\e[1;31mDoes this command have nothing? If not, remove rsh, rlogin, and rexec services by checking /etc/xinetd.conf and /etc/xinetd.d/* and verifying all rsh, rlogin, and rexec services have disable = yes set. Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs nothing (talk)
    echo -e "\e[1;32mEnsure that this command runs nothing for checking the talk service\e[0m"
    grep -R "^talk" /etc/inetd.* 
    grep -R "^ntalk" /etc/inetd.*
    read -rsp $'\e[1;31mDoes this command have nothing? If not, remove talk services by checking /etc/xinetd.conf and /etc/xinetd.d/* and verifying all talk services have disable = yes set. Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs nothing (telnet)
    echo -e "\e[1;32mEnsure that this command runs nothing for checking the telnet service\e[0m"
    grep -R "^telnet" /etc/inetd.*
    read -rsp $'\e[1;31mDoes this command have nothing? If not, remove telnet services by checking /etc/xinetd.conf and /etc/xinetd.d/* and verifying all telnet services have disable = yes set. Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs nothing (tftp)
    echo -e "\e[1;32mEnsure that this command runs nothing for checking the tftp service\e[0m"
    grep -R "^tftp" /etc/inetd.*
    read -rsp $'\e[1;31mDoes this command have nothing? If not, remove tftp services by checking /etc/xinetd.conf and /etc/xinetd.d/* and verifying all tftp services have disable = yes set. Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs xinetd (xinetd)
    echo -e "\e[1;32mEnsure that this command runs 'xinetd' for checking the xinetd service\e[0m"
    initctl show-config xinetd
    read -rsp $'\e[1;31mDoes this command have xinetd? If not, remove or comment out start lines in /etc/init/xinetd.conf: #start on runlevel [2345] . Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs xinetd (xinetd)
    echo -e "\e[1;32mEnsure that this command runs 'xinetd' for checking the xinetd service\e[0m"
    initctl show-config xinetd
    read -rsp $'\e[1;31mDoes this command have xinetd? If not, run systemctl disable xinetd . Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs avahi-daemon (avahi-daemon)
    echo -e "\e[1;32mEnsure that this command runs 'disabled' for checking the avahi-daemon service\e[0m"
    systemctl is-enabled avahi-daemon
    read -rsp $'\e[1;31mDoes this command run disabled? If not, run systemctl disable avahi-daemon . Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs disabled (cups). DO NOT REMOVE IF YOU NEED A PRINTER
    echo -e "\e[1;32mEnsure that this command runs 'disabled' for checking the cups service. DO NOT REMOVE IF YOU NEED A PRINTER\e[0m"
    systemctl is-enabled cups
    read -rsp $'\e[1;31mDoes this command run disabled? If not, run systemctl disable cups . Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs isc-dhcp-server / isc-dhcp-server6 (DHCP). DO NOT REMOVE IF YOU NEED DHCP
    echo -e "\e[1;32mEnsure that this command runs 'disabled' twice for checking the DHCP service. DO NOT REMOVE IF YOU NEED DHCP\e[0m"
    systemctl is-enabled isc-dhcp-server
    systemctl is-enabled isc-dhcp-server6
    read -rsp $'\e[1;31mDoes this command runs disabled twice? If not, run systemctl disable isc-dhcp-server and systemctl disable isc-dhcp-server6 . Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs disabled (LDAP). DO NOT REMOVE IF YOU NEED LDAP
    echo -e "\e[1;32mEnsure that this command runs disabled. DO NOT REMOVE IF YOU NEED LDAP\e[0m"
    systemctl is-enabled slapd  
    read -rsp $'\e[1;31mDoes this command run disabled? If not, run "systemctl disable slapd" . Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs disabled (nfs-kernel-server). DO NOT REMOVE IF YOU NEED NFS
    echo -e "\e[1;32mEnsure that this command runs disabled. DO NOT REMOVE IF YOU NEED NFS\e[0m"
    systemctl is-enabled nfs-kernel-server
    read -rsp $'\e[1;31mDoes this command run disabled? If not, run "systemctl disable nfs-kernel-server" . Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs disabled (RPC). DO NOT REMOVE IF YOU NEED RPC
    echo -e "\e[1;32mEnsure that this command runs disabled for checking the RPC service. DO NOT REMOVE IF YOU NEED RPC\e[0m"
    systemctl is-enabled rpcbind
    read -rsp $'\e[1;31mDoes this command run disabled? If not, run "systemctl disable rpcbind" . Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs disabled (bind9). DO NOT REMOVE IF YOU NEED DNS
    echo -e "\e[1;32mEnsure that this command runs disabled. DO NOT REMOVE IF YOU NEED DNS\e[0m"
    systemctl is-enabled bind9
    read -rsp $'\e[1;31mDoes this command run disabled? If not, run "systemctl disable bind9" . Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs disabled (ftp). DO NOT REMOVE IF YOU NEED FTP
    echo -e "\e[1;32mEnsure that this command runs 'disabled' for checking the vsftpd service. DO NOT REMOVE IF YOU NEED FTP\e[0m"
    systemctl is-enabled vsftpd
    read -rsp $'\e[1;31mDoes this command have vsftpd? If not, run "systemctl disable vsftpd" . Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs disabled (apache2). DO NOT REMOVE IF YOU NEED HTTP
    echo -e "\e[1;32mEnsure that this command runs disabled. DO NOT REMOVE IF YOU NEED HTTP\e[0m"
    systemctl is-enabled apache2
    read -rsp $'\e[1;31mDoes this command runs disabled? If not, run "systemctl disable apache2" . Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs disabled (IMAP/POP3). DO NOT REMOVE IF YOU NEED IMAP/POP3
    echo -e "\e[1;32mEnsure that this command runs 'disabled' for checking the dovecot service. DO NOT REMOVE IF YOU NEED IMAP/POP3\e[0m"
    systemctl is-enabled dovecot
    read -rsp $'\e[1;31mDoes this command runs disabled? If not, run "systemctl disable dovecot" . Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs disabled (Samba). DO NOT REMOVE IF YOU NEED Samba
    echo -e "\e[1;32mEnsure that this command runs 'disabled' for checking the smbd service. DO NOT REMOVE IF YOU NEED Samba\e[0m"
    systemctl is-enabled smbd
    read -rsp $'\e[1;31mDoes this command runs disabled? If not, run "systemctl disable smbd" . Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs disabled (HTTP Proxy). DO NOT REMOVE IF YOU NEED HTTP Proxy
    echo -e "\e[1;32mEnsure that this command runs 'disabled' for checking the HTTP Proxy service. DO NOT REMOVE IF YOU NEED HTTP Proxy\e[0m"
    systemctl is-enabled squid
    read -rsp $'\e[1;31mDoes this command run disabled? If not, run "systemctl disable squid" . Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs disabled (snmpd). DO NOT REMOVE IF YOU NEED SNMP
    echo -e "\e[1;32mEnsure that this command runs disabled. DO NOT REMOVE IF YOU NEED SNMP\e[0m"
    systemctl is-enabled snmpd
    read -rsp $'\e[1;31mDoes this command run disabled? If not, run "systemctl disable snmpd" . Space to continue... \e[0m\n' -n1 key

    read -p "If you are running snmpd (postfix), then say Y. If not, say N: " -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
          read -rsp $'\e[1;31mEdit /etc/postfix/main.cf and add the following line to the RECEIVING MAIL section. "inet_interfaces = localhost" Then, run "service postfix restart" . Space to continue... \e[0m\n' -n1 key 
    fi

    #Ensure that this command runs disabled (rsync). DO NOT REMOVE IF YOU NEED rsync
    echo -e "\e[1;32mEnsure that this command runs 'disabled' for checking the rsync service. DO NOT REMOVE IF YOU NEED rsync\e[0m"
    systemctl is-enabled rsync
    read -rsp $'\e[1;31mDoes this command run disabled? If not, run "systemctl disable rsync" . Space to continue... \e[0m\n' -n1 key

    #Ensure that this command runs ypserv (NIS / Yellow Pages). DO NOT REMOVE IF YOU NEED NIS / Yellow Pages / ypserv
    echo -e "\e[1;32mEnsure that this command runs 'disabled' for checking the NIS / Yellow Pages / ypserv service. DO NOT REMOVE IF YOU NEED NIS / Yellow Pages / ypserv\e[0m"
    initctl show-config ypserv
    read -rsp $'\e[1;31mDoes this command run disabled? If not, run "systemctl disable nis" . Space to continue... \e[0m\n' -n1 key

    echo -e "\e[0;36mNow, it's time for ensuring clients arent installed unless they need to be\e[0m"

    #Ensure that after running this command, nis is not installed, unless you need a NIS client.
    echo -e "\e[1;32mEnsure that after running this command, nis is not installed, unless you need a NIS client.\e[0m"
    dpkg -s nis
    read -rsp $'\e[1;31mIs this not installed? If it is, run "sudo apt-get remove nis" . Space to continue... \e[0m\n' -n1 key

    #Ensure that after running this command, rsh is not installed, unless you need a rsh client.
    echo -e "\e[1;32mEnsure that after running this command, rsh is not installed, unless you need a rsh client.\e[0m"
    dpkg -s rsh-client 
    dpkg -s rsh-redone-client
    read -rsp $'\e[1;31mIs this not installed? If it is, run "sudo apt-get remove rsh-client rsh-redone-client" . Space to continue... \e[0m\n' -n1 key

    #Ensure that after running this command, talk is not installed, unless you need a talk client.
    echo -e "\e[1;32mEnsure that after running this command, talk is not installed, unless you need a talk client.\e[0m"
    dpkg -s talk
    read -rsp $'\e[1;31mIs this not installed? If it is, run "sudo apt-get remove talk" . Space to continue... \e[0m\n' -n1 key

    #Ensure that after running this command, telnet is not installed, unless you need a telnet client.
    echo -e "\e[1;32mEnsure that after running this command, telnet is not installed, unless you need a telnet client.\e[0m"
    dpkg -s telnet
    read -rsp $'\e[1;31mIs this not installed? If it is, run "sudo apt-get remove telnet" . Space to continue... \e[0m\n' -n1 key

    #Ensure that after running this command, ldap-utils is not installed, unless you need a LDAP client.
    echo -e "\e[1;32mEnsure that after running this command, ldap-utils is not installed, unless you need a LDAP client.\e[0m"
    dpkg -s ldap-utils
    read -rsp $'\e[1;31mIs this not installed? If it is, run "sudo apt-get remove ldap-utils" . Space to continue... \e[0m\n' -n1 key

    echo -e "\e[0;36mNow, it's time for setting important network parameters\e[0m"

    sysctl -w fs.suid_dumpable=0
    sysctl -w kernel.randomize_va_space=2
    sysctl -w net.ipv4.ip_forward=0
    sysctl -w net.ipv4.conf.all.send_redirects=0
    sysctl -w net.ipv4.conf.default.send_redirects=0
    sysctl -w net.ipv4.conf.all.accept_source_route=0
    sysctl -w net.ipv4.conf.default.accept_source_route=0
    sysctl -w net.ipv4.conf.all.accept_redirects=0
    sysctl -w net.ipv4.conf.default.accept_redirects=0
    sysctl -w net.ipv4.conf.all.secure_redirects=0
    sysctl -w net.ipv4.conf.default.secure_redirects=0
    sysctl -w net.ipv4.conf.all.log_martians=1
    sysctl -w net.ipv4.conf.default.log_martians=1
    sysctl -w net.ipv4.icmp_echo_ignore_broadcasts=1
    sysctl -w net.ipv4.icmp_ignore_bogus_error_responses=1
    sysctl -w net.ipv4.conf.all.rp_filter=1
    sysctl -w net.ipv4.conf.default.rp_filter=1
    sysctl -w net.ipv4.tcp_syncookies=1

    sysctl -w net.ipv4.route.flush=1

    apt-get -y install auditd 
    systemctl enable auditd
    echo -e "\e[1;32mAdd this line to /etc/default/grub to disable IPv6 'GRUB_CMDLINE_LINUX=\"ipv6.disable=1\"\e[0m"
    echo -e "\e[1;32mAdd this line to /etc/default/grub to disable IPv6 'GRUB_CMDLINE_LINUX=\"audit=1\"\e[0m"
    read -rsp $'\e[1;31mPress space once complete\e[0m\n' -n1 key
    update-grub
    chown root:root /boot/grub/grub.cfg
    chmod og-rwx /boot/grub/grub.cfg

     #Ensure that your end machine has TCP Wrappers installed
    echo -e "\e[1;32mEnsure that your end machine has TCP Wrappers installed\e[0m"
    dpkg -s tcpd
    echo -e "\e[1;32mIf it is not installed, run 'sudo apt-get install tcpd' \e[0m"
    read -rsp $'\e[1;31mSpace to continue... \e[0m\n' -n1 key
    clear

    echo -e "\e[1;32mEnsure that your end machine has iptables installed\e[0m"
    dpkg -s iptables
    echo -e "\e[1;32mIf it is not installed, run 'sudo apt-get install iptables' \e[0m"
    read -rsp $'\e[1;31mSpace to continue... \e[0m\n' -n1 key
    clear

    echo -e "\e[1;32mConfiguring default deny firewall policy\e[0m"
    iptables -P INPUT DROP
    iptables -P OUTPUT DROP
    iptables -P FORWARD DROP

    echo -e "\e[1;32mSecuring loopback\e[0m"
    iptables -A INPUT -i lo -j ACCEPT
    iptables -A OUTPUT -o lo -j ACCEPT
    iptables -A INPUT -s 127.0.0.0/8 -j DROP

    apt-get -y install auditd 
    systemctl enable auditd

    #Ensure that this command runs disabled (ftp). DO NOT REMOVE IF YOU NEED FTP
    echo -e "\e[1;32mEnsure that this command runs 'ENABLED' for checking the cron service.\e[0m"
    systemctl is-enabled crond
    read -rsp $'\e[1;31mDoes this command run enabled? If not, run "systemctl enable crond" . Space to continue... \e[0m\n' -n1 key

    #Ensure that the GID of the root account is 0
    echo -e "\e[1;32mEnsure that the GID of the root account is 0\e[0m"
    grep "^root:" /etc/passwd | cut -f4 -d:
    echo -e "\e[1;32mIf it is not 00, run usermod -g 0 root\e[0m"
    read -rsp $'\e[1;31mSpace to continue... \e[0m\n' -n1 key
    clear

    echo -e "\e[0;36mNow printing all services\e[0m"
    service --status-all
    read -rsp $'\e[1;31mHow do the services look? Press space to continue...\e[0m\n' -n1 key


    read -rsp $'\e[1;31mRun software updater in GUI and Remember to enact password policy. Press space to continue...\e[0m\n' -n1 key
}

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=2
BACKTITLE="Backtitle here"
TITLE="Secure-A-Tux"
MENU="Choose one of the following options:"

OPTIONS=(1 "Ubuntu 14"
         2 "Ubuntu 16")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
        1)
            echo "You chose Ubuntu 14"
            14
            ;;
        2)
            echo "You chose Ubuntu 16"
            16
            ;;
esac

exit
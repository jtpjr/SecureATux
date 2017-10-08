#!/bin/bash
if [ ! $(whoami) = "root" ] ; then
	echo -e "Get out and RUN THIS WITH ROOT PERMISSIONS! NOW!"
	exit 1
fi

RED='\e[0;31m'
NC='\e[0m' # This means NO COLOR.
GREEN='\e[1;32m'

function secure_ufw {
	echo -e "${RED}Securing Firewall...${NC}"
	echo "" &> /dev/null
	ufw enable
	ufw logging high
	mv /etc/hosts.allow /etc/hosts.allow.backup
	mv /etc/hosts.deny /etc/hosts.deny.backup
	cp ./perfect_files/hosts/hosts.deny /etc/
	cp ./perfect_files/hosts/hosts.allow /etc/
	chmod 644 /etc/hosts.allow
	chmod 644 /etc/hosts.deny
	chown root:root /etc/hosts.deny
	chown root:root /etc/hosts.allow
	echo -e "${GREEN}UFW Secured!${NC}"
}

function secure_ssh {
read -p $"Is there an SSH server that you want secured? [y/n]" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo -e "${RED}Backing up SSHD Config/Importing Perfect Config${NC}"
	mv /etc/ssh/sshd_config /etc/ssh/sshd_config.backup
	cp ./perfect_files/sshd_config /etc/ssh/
	chown root:root /etc/ssh/sshd_config
	chmod og-rwx /etc/ssh/sshd_config
fi

echo -e "${GREEN}SSH Secured!${NC}"
}

function password_policy {
	echo -e "${RED}Doing Password Policy Stuffs...${NC}"
	apt-get install libpam-cracklib --yes
	cp -r /etc/pam.d/ /etc/pam.d.backup
	rm /etc/pam.d/common-auth
	rm /etc/pam.d/common-password
	cp ./perfect_files/pam.d/common-auth /etc/pam.d/
	cp ./perfect_files/pam.d/common-password /etc/pam.d/
	chown root:root /etc/pam.d/common-auth
	chown root:root /etc/pam.d/common-password
	chmod 644 /etc/pam.d/common-auth
	chmod 644 /etc/pam.d/common-password
	cp /etc/login.defs /etc/login.defs.backup
	cp ./perfect_files/login.defs /etc/
	chown root:root /etc/login.defs
	echo -e "${RED}Locking Root Account...${NC}"
	passwd -l root
	usermod -g 0 root
	echo -e "${GREEN}Password Policies Done!${NC}"
}

function secure_updates {
	echo -e "${RED}Securing Update Sources...${NC}"
	mv /etc/apt /etc/apt.backup
	cp -r ./perfect_files/apt /etc/apt
	chmod 755 /etc/apt/
	chmod 755 /etc/apt/*
	chmod 644 /etc/apt/sources.list
	chmod 600 /etc/apt/trustdb.gpg
	chmod 644 /etc/apt/trusted.gpg
	chown -R root:root /etc/apt/
	echo -e "${RED}Now Updating System...${NC}"
	apt-get update
	apt-get upgrade
	sudo apt-get install unattended-upgrades
	sudo dpkg-reconfigure -plow unattended-upgrades  # Enables automatic updates
	echo -e "${GREEN}Updates Secured!${NC}"
}

#function unwanted_software {
#	echo -e "${RED}Removing Common Hacking Tools...${NC}"
#	apt-get -y purge john*
#	echo -e "${GREEN}Common Hacking Tools Removed!${NC}"
#}

function secure_lightdm {
	echo -e "${RED}Securing LightDM...${NC}"
	mv /etc/lightdm/lightdm.conf /etc/lightdm/lightdm.conf.backup
	mv /etc/lightdm/users.conf /etc/lightdm/users.conf.backup
	cp ./perfect_files/lightdm/lightdm.conf /etc/lightdm/
	cp ./perfect_files/lightdm/users.conf /etc/lightdm/
	echo -e "${GREEN}LightDM Secured!${NC}"
}

function network_protection {
	echo -e "${RED}Securing Sysctl.conf...${NC}"
	mv /etc/sysctl.conf /etc/sysctl.conf.backup
	cp ./perfect_files/sysctl.conf /etc/
	sysctl -p
	echo -e "${GREEN}Sysctl.conf Secured!${NC}"
}

function file_permissions {
	echo -e "${RED}Doing File Permission Stuff...${NC}"
	chown root:root /etc/passwd
	chmod 644 /etc/passwd
	chown root:root /etc/passwd-
	chmod 600 /etc/passwd-
	chown root:shadow /etc/shadow
	chmod o-rwx,g-wx /etc/shadow
	chown root:root /etc/shadow-
	chmod 600 /etc/shadow-
	chown root:root /etc/group
	chmod 644 /etc/group
	chown root:root /etc/group-
	chmod 600 /etc/group-
	chown root:root /etc/securetty
	chmod 0600 /etc/securetty
	echo -e "${RED}Securing commonly used commands...${NC}"
	chmod 100 /bin/tar
	chmod 100 /bin/ping
	chmod 100 /bin/mount
	chmod 100 /bin/umount
	chmod 100 /usr/bin/who
	chmod 100 /usr/bin/lastb
	chmod 100 /usr/bin/last
	chmod 100 /usr/bin/lastlog
}

function secure_vsftpd {
read -p $"Is there a vsftpd server that you want secured? [y/n]" -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo -e "${RED}Backing up vsftpd Config/Importing Perfect Config${NC}"
	mv /etc/vsftpd.conf /etc/vsftpd.conf.backup
	cp ./perfect_files/vsftpd.conf /etc/
fi

	echo -e "${GREEN}VSFTPD Secured!${NC}"
}

function system_security {
	echo -e "${RED}Securing system defaults...${NC}"
	sed -i "/exec/ c\exec false" /etc/init/control-alt-delete.conf
	sed -i '/ENABLED/ c\ENABLED="0"' /etc/default/irqbalance
	echo -e "${GREEN}System Defaults secured!${NC}"
}

function final_notes {
	echo "${GREEN}Make sure /etc/rc.local is empty!${NC}"
	echo "${GREEN}Remember to check for permissions of files around the system!${NC}"
	echo "${GREEN}Remember to look at the /etc/sudoers.d/ and /etc/sudoers${NC}"
	echo "${GREEN}Remember to look at all the /etc/cron.*/ files.${NC}"
	echo "${GREEN}Remember to look at all the /etc/rc?.d/ files.${NC}"
}

secure_ssh
secure_vsftpd
secure_lightdm
network_protection
file_permissions
system_security
secure_ufw
password_policy
secure_updates
final_notes

echo -e "${GREEN}Thanks for using Ubuntu.sh!${NC}"


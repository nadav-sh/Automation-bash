#!/bin/bash
#########################
#create by: N@dav		#
#Version: 2.0.0			#
#Script to install pkg	#
#########################

echo "what is your username to enter this computer ? "
read user
user=$user


if [[ $EUID -ne 0 ]]; then
   	echo "This script must be run as root" 
   	exit 1
else
	#Update and Upgrade
	echo "Updating and Upgrading"
	apt-get update && sudo apt-get upgrade -y

	sudo apt-get install dialog
	cmd=(dialog --separate-output --checklist "Please Select Software you want to install:" 22 76 16)
	options=(1 "Curl" on    # any option can be set to default to "on"
	         2 "jq" off
	         3 "Wget" off
	         4 "vim" on
	         5  "Git" on
			 6 	"Zip" on
			 7	"Snap" on
			 8	"AWS-cli" off
			 9	"AWS-cli-Debian" on
	         10 "Docker.io" on
             11 "Docker-Compose" on
	         12 "slack" off
			 13	"Ansible" off
	         14 "Python" off
	         15 "Python3-pip" off
             16 "Openvpn-Gui" off
			 17 "openSSH-server" off
			 18 "LAMP stack" off)
		choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
		clear
		for choice in $choices
		do
		    case $choice in
	        1)
	            #Install Curl
				echo "Installing Sublime Text"
				apt update
				apt install curl -y
				;;
			2)
			    #Install jq
				echo "Installing jq"
				apt install jq -y
				;;
    		3)	
                #Wget
				echo "Installing Wget"
				apt-get install wget -y
				;;              
			4)
                #Vim
                echo "Installing Vim"
                apt-get install vim -y
                ;;
            5)
				#Install Git
				echo "Installing Git"
				apt-get install git -y 
				;;
			6)
				#Install Zip
				echo "Installing Zip"
				apt-get install zip -y
				;;
			7)
				#Install Snap"
				echo "Installing Snap"
				sudo apt install snapd
				;;
			8)
				#Install
				echo "Installing AWS-cli"
				curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
				unzip awscliv2.zip
				./aws/install
				aws --version
				;;
			9)
				#
				echo "Installing AWS-cli-Debian"
				apt-get install awscli -y
				aws --version
				;;
			10)
				#Install Docker.io
				echo "Installing Docker.io"
				apt install docker.io -y
				;;
			11)
                #Install Docker Comprse
                echo "Installing Docker-comprse"
                sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
                sudo chmod +x /usr/local/bin/docker-compose
                ;;
            12)
				#Install Slack
				echo "Installing Slack"
				sudo snap install slack --classic
				;;
			13)
				#Install Ansible
				echo "Ansible"
				apt update
				apt-get install ansible -y
				;;
			14)
                #Install Python
				echo "Python"
				apt update
				apt-get install python -y
				;;
			15)
                #Install Python3-pip
				echo "Installing Python3-pip"	
				apt install Python3-pip -y
				;;
            16)
				#openvpn-Gui
                echo "openvpn Gui"
				apt update
				apt-get install network-manager-OpenVPN-gnome -y
				;;
			17)
				#openssh-server
				apt-get install openssh-server
				systemctl enable ssh
				systemctl start ssh
				;;
			18)
				#Install LAMP stack
				echo "Installing Apache"
				apt install apache2 -y
	            
    			echo "Installing Mysql Server"
	 			apt install mysql-server -y

        		echo "Installing PHP"
				apt install php libapache2-mod-php php-mcrypt php-mysql -y
	            
        		echo "Installing Phpmyadmin"
				apt install phpmyadmin -y

				echo "Cofiguring apache to run Phpmyadmin"
				echo "Include /etc/phpmyadmin/apache.conf" >> /etc/apache2/apache2.conf
				
				echo "Enabling module rewrite"
				sudo a2enmod rewrite
				echo "Restarting Apache Server"
				service apache2 restart
				;;
	    esac
	done
fi

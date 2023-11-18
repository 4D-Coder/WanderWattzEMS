#!/bin/bash

# Exit immediately if a command exits with a non-zero status
# set -e

# Adding PostgreSQL repository and signing key
if dpkg --get-selections | grep -q "^postgresql[[:space:]]*install$" >/dev/null; then
	echo "PostgreSQL is already installed. Skipping installation steps."
else
	# echo "Adding PostgreSQL repository..."
	# sudo sh -c 'echo "deb https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
	# wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

	# Updating packages and installing PostgreSQL
	echo "Updating packages and installing PostgreSQL..."
	sudo apt-get update
	sudo apt-get -y install postgresql

	# Starting and enabling PostgreSQL service
	echo "Starting PostgreSQL server and enabling it at startup..."
	sudo systemctl start postgresql
	sudo systemctl enable postgresql

	# Checking PostgreSQL service status
	echo "Checking PostgreSQL service status..."
	# Ensures we proceed only if the PostgreSQL service is running
	if sudo systemctl status postgresql; then
		while true; do
			# Creating a new PostgreSQL user and initial database
			echo "Connecting to the PostgreSQL shell to create a database USER..."
			read -p "Please enter your desired username: " pguser
			echo ""
			read -sp "Please enter your desired password: " password
			echo ""
			read -sp "Please confirm your desired password: " password_conf
			echo ""
			read -p "Please enter a name for the initial database: " dbname
			echo ""
			if [ "$password" == "$password_conf" ]; then
				if su - postgres -c "psql -c \"
					BEGIN;
					CREATE USER $pguser WITH PASSWORD '$password';
					CREATE DATABASE $dbname;
					GRANT ALL PRIVILEGES ON DATABASE $dbname to $pguser;
					COMMIT;
				\""; then
					echo "User $pguser created successfully."
					echo "Database $dbname created successfully."
					echo "User $pguser granted all privileges to $dbname."
					echo ""
					echo "Exiting PostgreSQL Shell.."
					break
				else
					echo "An error occurred while creating the user or database. Please check your credentials."
					read -p "Would you like to try again? (yes/no) " reattempt
						if [ "$reattempt" == "no" ]; then
							echo "Exiting installation.."
							break
						fi
				fi
			else	
				echo "Passwords entered do not match, please try again."	
			fi
		done
	else 
		echo "PostgreSQL service could not be started successfully, please check your PostgreSQL installation and try again."
	fi
fi
#Installing pgAdmin4 (Optional)
read -p "Would you like to install pgAdmin4 as well? (yes/no) " selection
case $selection in 
	no)
		echo "Skipping pgAdmin4 installation."
		echo "Installation Complete!"
		exit 0
		;;
	yes)
		echo "Executing pgAdmin4 installation.."
		echo "Installing prerequisites for pgAdmin4..."
		sudo apt-get install curl gnupg2 -y
		echo "Adding pgAdmin4 repository signing key..."
		sudo curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo apt-key add
		
		# Dynamically observe the current distribution
		distro_codename=$(lsb_release -cs)
		
		# Append the pgAdmin4 repository if not already added: https://gist.github.com/4D-Coder/5e01d3d36ff7e5e8d606055eb347fccb
		echo "Checking for existing pgAdmin4 repository..."
		pgadmin_repo="deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/${distro_codename} pgadmin4 main"
		list_file="/etc/apt/sources.list.d/pgadmin4.list"
		if ! grep -rL "$pgadmin_repo" /etc/apt/sources.list*; then
        		echo "Appending pgAdmin4 repository..."
        		echo "$pgadmin_repo" | sudo tee $list_file
    		fi
    		sudo apt-get update
    		sudo apt-get install pgadmin4 -y
		;;
	*)
		echo "Invalid input, please enter 'yes' or 'no' (response is case-sensitive)."
		;;
esac 
read "Installation complete! Happy Querying! (Press any key to exit...)" exit


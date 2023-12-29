#!/bin/bash

# Comprehensive Startup Script for Bastion Host sreterminal running on CentOS Image

# The startup script performs the following functions
# A. Install SRE Terminal Tools
# B. Clone the following respos in /home/repos folder
# https://github.com/jaichenchlani/utilities.git
# https://github.com/jaichenchlani/terraform_modules.git
# https://github.com/jaichenchlani/gce_bootcamp.git


echo "START" | systemd-cat -t startup_script -p 4
echo "https://everythingcloudplatform.com/" | systemd-cat -t startup_script -p 4

# Initialize the counter
count=0

echo "************************" | systemd-cat -t startup_script -p 4
echo "INSTALL DEVOPS/SRE TOOLS" | systemd-cat -t startup_script -p 4
echo "************************" | systemd-cat -t startup_script -p 4

let "count++" # Install wget
echo "$count) Install wget..."  | systemd-cat -t startup_script -p 5
sudo apt-get install wget -y
if [ $? -ne 0 ]; then
    echo "Failed." | systemd-cat -t startup_script -p 3
else
	echo "Completed successfully." | systemd-cat -t startup_script -p 6
fi

let "count++" # Install GIT
echo "$count) Install git..." | systemd-cat -t startup_script -p 5
sudo apt-get install git -y
if [ $? -ne 0 ]; then
    echo "Failed." | systemd-cat -t startup_script -p 3
else
	echo "Completed successfully." | systemd-cat -t startup_script -p 6
fi

let "count++" # Install kubectl
echo "$count) Install kubectl..." | systemd-cat -t startup_script -p 5
sudo apt-get install kubectl -y
if [ $? -ne 0 ]; then
    echo "Failed." | systemd-cat -t startup_script -p 3
else
	echo "Completed successfully." | systemd-cat -t startup_script -p 6
fi

let "count++" # Install gke-gcloud-auth-plugin - needed for kubectl commands to work
echo "$count) Install gke-gcloud-auth-plugin..." | systemd-cat -t startup_script -p 5
sudo apt-get install -y google-cloud-sdk-gke-gcloud-auth-plugin
if [ $? -ne 0 ]; then
    echo "Failed." | systemd-cat -t startup_script -p 3
else
	echo "Completed successfully." | systemd-cat -t startup_script -p 6
fi

# Instructions:
# https://www.hashicorp.com/official-packaging-guide?ajs_aid=41c5ec51-aafb-4662-b31a-2c4de08ed185&product_intent=terraform
let "count++" # Install gpg
echo "$count) GPG is required for the package signing key..." | systemd-cat -t startup_script -p 5
sudo apt update && sudo apt install gpg
if [ $? -ne 0 ]; then
    echo "Failed." | systemd-cat -t startup_script -p 3
else
	echo "Completed successfully." | systemd-cat -t startup_script -p 6
fi

let "count++" # Download the signing key to a new keyring
echo "$count) Download the signing key to a new keyring..." | systemd-cat -t startup_script -p 5
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
if [ $? -ne 0 ]; then
    echo "Failed." | systemd-cat -t startup_script -p 3
else
	echo "Completed successfully." | systemd-cat -t startup_script -p 6
fi

let "count++" # Verify the key's fingerprint
echo "$count) Verify the key's fingerprint..." | systemd-cat -t startup_script -p 5
gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint
if [ $? -ne 0 ]; then
    echo "Failed." | systemd-cat -t startup_script -p 3
else
	echo "Completed successfully." | systemd-cat -t startup_script -p 6
fi

let "count++" # Add the HashiCorp repo
echo "$count) Add the HashiCorp repo..." | systemd-cat -t startup_script -p 5
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
if [ $? -ne 0 ]; then
    echo "Failed." | systemd-cat -t startup_script -p 3
else
	echo "Completed successfully." | systemd-cat -t startup_script -p 6
fi

let "count++" # apt update
echo "$count) apt update..." | systemd-cat -t startup_script -p 5
sudo apt update
if [ $? -ne 0 ]; then
    echo "Failed." | systemd-cat -t startup_script -p 3
else
	echo "Completed successfully." | systemd-cat -t startup_script -p 6
fi

let "count++" # Install terraform
echo "$count) Install terraform..." | systemd-cat -t startup_script -p 5
sudo apt install terraform -y
if [ $? -ne 0 ]; then
    echo "Failed." | systemd-cat -t startup_script -p 3
else
	echo "Completed successfully." | systemd-cat -t startup_script -p 6
fi

let "count++" # Install packer
echo "$count) Install packer..." | systemd-cat -t startup_script -p 5
sudo apt-get -y install packer
if [ $? -ne 0 ]; then
    echo "Failed." | systemd-cat -t startup_script -p 3
else
	echo "Completed successfully." | systemd-cat -t startup_script -p 6
fi

let "count++" # Install docker
echo "$count) Install docker..." | systemd-cat -t startup_script -p 5
sudo apt-get -y install docker
if [ $? -ne 0 ]; then
    echo "Failed." | systemd-cat -t startup_script -p 3
else
	echo "Completed successfully." | systemd-cat -t startup_script -p 6
fi

echo "********************************************" | systemd-cat -t startup_script -p 4
echo "CLONE EVERYTHINGCLOUDPLATFORM's PUBLIC REPOS" | systemd-cat -t startup_script -p 4
echo "********************************************" | systemd-cat -t startup_script -p 4

let "count++" # Navigate to /home
echo "$count) Navigate to /home and create repos folder..." | systemd-cat -t startup_script -p 5
# cd $HOME
cd home
mkdir repos
cd repos
pwd

let "count++" # Clone utilities repo
echo "$count) Cloning utilities repo..." | systemd-cat -t startup_script -p 5
git clone https://github.com/jaichenchlani/utilities.git
if [ $? -ne 0 ]; then
    echo "Failed." | systemd-cat -t startup_script -p 3
else
	echo "Completed successfully." | systemd-cat -t startup_script -p 6
fi

let "count++" # Clone Terraform Modules
echo "$count) Cloning Terraform Modules..." | systemd-cat -t startup_script -p 5
git clone https://github.com/jaichenchlani/terraform_modules.git
if [ $? -ne 0 ]; then
    echo "Failed." | systemd-cat -t startup_script -p 3
else
	echo "Completed successfully." | systemd-cat -t startup_script -p 6
fi

let "count++" # Clone GCE Bootcamp Udemy Course Demo code
# https://www.udemy.com/course/google-cloud-gce-reliability-engineering-using-terraform
echo "$count) Clone GCE Bootcamp Udemy Course Demo code..." | systemd-cat -t startup_script -p 5
git clone https://github.com/jaichenchlani/gce_bootcamp.git
if [ $? -ne 0 ]; then
    echo "Failed." | systemd-cat -t startup_script -p 3
else
	echo "Completed successfully." | systemd-cat -t startup_script -p 6
fi

echo "run 'cat /home/repos/utilities/aliases.md >> .bashrc' to add aliases to your bash profile." | systemd-cat -t startup_script -p 4
echo "run 'source .bashrc' manually to have the aliases take effect." | systemd-cat -t startup_script -p 4

echo "https://everythingcloudplatform.com/" | systemd-cat -t startup_script -p 4
echo "END" | systemd-cat -t startup_script -p 4
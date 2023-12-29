#!/bin/bash

# Source Bash Config and Utilities
source /home/repos/utilities/load_bash_config_and_utilities.sh

echo "***** Create SRETERMINAL START *****"

# Initialize the counter
count=0

let "count++" # Load Config File
echo "$count) Load Config File..."
. config_file

let "count++" # Create sreterminal Bastion Host on Debian
vm_name=$vm_name
image=$debian_image
disk_size=20
startup_script=$sreterminal_startup_script
echo "$count) Creating webserver $vm_name with Image $image..."
gcloud compute instances create $vm_name \
    --project=$project_id \
    --zone=$zone \
    --machine-type=$machine_type \
    --network-interface=$network_interface \
    --tags=web-server \
    --maintenance-policy=MIGRATE \
    --provisioning-model=STANDARD \
    --scopes=$scopes \
    --create-disk=auto-delete=yes,boot=yes,device-name=$vm_name,image=$image,mode=rw,size=$disk_size,type=projects/$project_id/zones/$zone/diskTypes/pd-balanced \
    --no-shielded-secure-boot \
    --shielded-vtpm \
    --shielded-integrity-monitoring \
    --labels=provisioned_by=gcloud,name=$vm_name \
    --reservation-affinity=any \
    --metadata-from-file startup-script="$startup_script"

echo "***** Create SRETERMINAL END *****"
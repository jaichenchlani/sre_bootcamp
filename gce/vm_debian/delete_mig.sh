#!/bin/bash

# Source Bash Config and Utilities
source /home/repos/utilities/load_bash_config_and_utilities.sh

echo "***** Create MIG START *****"

# Initialize the counter
count=0

let "count++" # Load Config File
echo "$count) Load Config File..."
. config_file

let "count++" # Delete MIG
mig_name=$mig_debian
echo "$count) Deleting MIG $mig_name..."
gcloud beta compute instance-groups managed delete $mig_name --region $region

let "count++" # Delete Health Check Apache
health_check_name=$health_check_apache
echo "$count) Deleting healthcheck $health_check_name..."
gcloud beta compute health-checks delete $health_check_name

echo "***** Create MIG END *****"
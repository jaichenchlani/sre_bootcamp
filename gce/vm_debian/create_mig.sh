#!/bin/bash

# Source Bash Config and Utilities
source /home/repos/utilities/load_bash_config_and_utilities.sh

echo "***** Create MIG START *****"

# Initialize the counter
count=0

let "count++" # Load Config File
echo "$count) Load Config File..."
. config_file

let "count++" # Create Health Check Apache
health_check_name=$health_check_apache
port=$port_apache
description=$description_apache
check_interval=$check_interval_apache
timeout=$timeout_apache
unhealthy_threshold=$unhealthy_threshold_apache
healthy_threshold=$healthy_threshold_apache
echo "$count) Creating healthcheck $health_check_name..."

gcloud beta compute health-checks create tcp $health_check_name \
    --project=$project_id \
    --port=$port \
    --proxy-header=NONE \
    --no-enable-logging \
    --description="$description" \
    --check-interval=$check_interval \
    --timeout=$timeout \
    --unhealthy-threshold=$unhealthy_threshold \
    --healthy-threshold=$healthy_threshold

let "count++" # Create MIG
mig_name=$mig_debian
health_check=$mig_debian_health_check
size=$mig_debian_size
template=$mig_debian_template
echo "$count) Creating MIG $mig_name..."
gcloud beta compute instance-groups managed create $mig_name \
    --project=$project_id \
    --base-instance-name=$mig_name \
    --size=$size \
    --template=$template \
    --zones=us-east1-b,us-east1-c,us-east1-d \
    --target-distribution-shape=EVEN \
    --instance-redistribution-type=PROACTIVE \
    --list-managed-instances-results=PAGELESS \
    --health-check=$health_check \
    --initial-delay=300 \
    --no-force-update-on-repair \
    --default-action-on-vm-failure=repair \
    --standby-policy-mode=manual

let "count++" # Create Autoscaling Policy
echo "$count) Setting autoscaling policy for MIG $mig_name..."
gcloud beta compute instance-groups managed set-autoscaling $mig_name \
    --project=$project_id \
    --region=$region \
    --cool-down-period=120 \
    --max-num-replicas=3 \
    --min-num-replicas=2 \
    --mode=on \
    --target-cpu-utilization=0.6

echo "***** Create MIG END *****"
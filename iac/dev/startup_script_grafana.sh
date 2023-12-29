#!/bin/bash

# Startup Script for Grafana App Server running on Debian Image

echo "START" | systemd-cat -t startup_script -p 4

# Initialize the counter
count=0

echo "*******************" | systemd-cat -t startup_script -p 4
echo "GOOGLE MONITORING OPS AGENT INSTALLATION" | systemd-cat -t startup_script -p 4
echo "*******************" | systemd-cat -t startup_script -p 4

let "count++" # Increment the counter
echo "$count) Installing the Monitoring Ops Agent..."  | systemd-cat -t startup_script -p 5
echo "Instructions from https://cloud.google.com/stackdriver/docs/solutions/agents/ops-agent"
echo "Instructions from https://cloud.google.com/stackdriver/docs/solutions/agents/ops-agent/installation#agent-version-debian-ubuntu"
echo "Refer Apache configuration file /etc/apache2/apache2.conf for LogFormat..."
sudo curl -sSO https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.sh
sudo bash add-google-cloud-ops-agent-repo.sh --also-install
if [ $? -ne 0 ]; then
    echo "Failed." | systemd-cat -t startup_script -p 3
else
	echo "Completed successfully." | systemd-cat -t startup_script -p 6
fi

let "count++" # Increment the counter
echo "$count) Configure Monitoring Ops Agent to receive Apache access and error logs..."  | systemd-cat -t startup_script -p 5
sudo tee /etc/google-cloud-ops-agent/config.yaml > /dev/null << EOF
metrics:
  receivers:
    apache:
      type: apache
  service:
    pipelines:
      apache:
        receivers:
          - apache
logging:
  receivers:
    apache_access:
      type: apache_access
    apache_error:
      type: apache_error
  service:
    pipelines:
      apache:
        receivers:
          - apache_access
          - apache_error
EOF
if [ $? -ne 0 ]; then
    echo "Failed." | systemd-cat -t startup_script -p 3
else
	echo "Completed successfully." | systemd-cat -t startup_script -p 6
fi

let "count++" # Increment the counter
echo "$count) Restart Monitoring Ops Agent..."  | systemd-cat -t startup_script -p 5
sudo systemctl restart google-cloud-ops-agent
if [ $? -ne 0 ]; then
    echo "Failed." | systemd-cat -t startup_script -p 3
else
	echo "Completed successfully." | systemd-cat -t startup_script -p 6
fi

echo "*******************" | systemd-cat -t startup_script -p 4
echo "GRAFANA INSTALLATION" | systemd-cat -t startup_script -p 4
echo "*******************" | systemd-cat -t startup_script -p 4
# https://grafana.com/docs/grafana/latest/setup-grafana/installation/debian/

let "count++" # Increment the counter
echo "$count) Install the prerequisite packages..."  | systemd-cat -t startup_script -p 5
sudo apt-get install -y apt-transport-https software-properties-common wget
if [ $? -ne 0 ]; then
    echo "Failed." | systemd-cat -t startup_script -p 3
else
	echo "Completed successfully." | systemd-cat -t startup_script -p 6
fi

let "count++" # Increment the counter
echo "$count) Import the GPG Key(A)..."  | systemd-cat -t startup_script -p 5
sudo mkdir -p /etc/apt/keyrings/
if [ $? -ne 0 ]; then
    echo "Failed." | systemd-cat -t startup_script -p 3
else
	echo "Completed successfully." | systemd-cat -t startup_script -p 6
fi

let "count++" # Increment the counter
echo "$count) Import the GPG Key(A)..."  | systemd-cat -t startup_script -p 5
wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null
if [ $? -ne 0 ]; then
    echo "Failed." | systemd-cat -t startup_script -p 3
else
	echo "Completed successfully." | systemd-cat -t startup_script -p 6
fi

let "count++" # Increment the counter
echo "$count) Add a repository for STABLE releases..."  | systemd-cat -t startup_script -p 5
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
if [ $? -ne 0 ]; then
    echo "Failed." | systemd-cat -t startup_script -p 3
else
	echo "Completed successfully." | systemd-cat -t startup_script -p 6
fi

let "count++" # Increment the counter
echo "$count) Add a repository for BETA releases..."  | systemd-cat -t startup_script -p 5
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com beta main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
if [ $? -ne 0 ]; then
    echo "Failed." | systemd-cat -t startup_script -p 3
else
	echo "Completed successfully." | systemd-cat -t startup_script -p 6
fi

# THIS STEP SHOWS UP AS FAILED IN JOURNALCTL.. NO IMPACT THOUGH.. FIGURE OUT...
let "count++" # Increment the counter
echo "$count) Update the list of available packages..."  | systemd-cat -t startup_script -p 5
sudo apt-get update
if [ $? -ne 0 ]; then
    echo "Failed." | systemd-cat -t startup_script -p 3
else
	echo "Completed successfully." | systemd-cat -t startup_script -p 6
fi

let "count++" # Increment the counter
echo "$count) Install Grafana OSS..."  | systemd-cat -t startup_script -p 5
sudo apt-get install grafana -y
if [ $? -ne 0 ]; then
    echo "Failed." | systemd-cat -t startup_script -p 3
else
	echo "Completed successfully." | systemd-cat -t startup_script -p 6
fi

let "count++" # Increment the counter
echo "$count) Start Grafana service(A)..."  | systemd-cat -t startup_script -p 5
sudo systemctl daemon-reload
if [ $? -ne 0 ]; then
    echo "Failed." | systemd-cat -t startup_script -p 3
else
	echo "Completed successfully." | systemd-cat -t startup_script -p 6
fi

let "count++" # Increment the counter
echo "$count) Start Grafana service(B)..."  | systemd-cat -t startup_script -p 5
sudo systemctl start grafana-server
if [ $? -ne 0 ]; then
    echo "Failed." | systemd-cat -t startup_script -p 3
else
	echo "Completed successfully." | systemd-cat -t startup_script -p 6
fi

let "count++" # Increment the counter
echo "$count) Check status of Grafana service..."  | systemd-cat -t startup_script -p 5
sudo systemctl status grafana-server
if [ $? -ne 0 ]; then
    echo "Failed." | systemd-cat -t startup_script -p 3
else
	echo "Completed successfully." | systemd-cat -t startup_script -p 6
fi

let "count++" # Increment the counter
echo "$count) Configure the Grafana server to start at boot using systemd..."  | systemd-cat -t startup_script -p 5
sudo systemctl enable grafana-server.service
if [ $? -ne 0 ]; then
    echo "Failed." | systemd-cat -t startup_script -p 3
else
	echo "Completed successfully." | systemd-cat -t startup_script -p 6
fi

echo "END" | systemd-cat -t startup_script -p 4
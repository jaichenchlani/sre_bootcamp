#!/bin/bash

# Modify index.html to replace the following with actual values from the server
# hostname, ip_address, os_information and host_uptime

echo "Modifying index.html..."
echo "Replacing \'hostname\' with $(hostname)..."
sudo sed -i[bak] "s/hostname/$(hostname)/g" index.html
echo "Replacing \'ip_address\' with $(hostname -I)..."
sudo sed -i[bak] "s/ip_address/$(hostname -I)/g" index.html
echo "Replacing \'os_information\' with $(uname -a)..."
sudo sed -i[bak] "s/os_information/$(uname -s)/g" index.html
echo "Replacing \'host_uptime\' with $(uptime -s)..."
sudo sed -i[bak] "s/host_uptime/$(uptime -s)/g" index.html
echo "index.html updated successfully."
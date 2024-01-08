#!/bin/bash

# Source Bash Config and Utilities
source /Users/jai/mydata/technical/repos_public/utilities/load_bash_config_and_utilities.sh

echo "***** Deploy everythingcloudplatform resources START *****"

kubectl apply -f yamls/ns.yaml
if [ $? -ne 0 ]; then
    echo "Namespace creation failed."
else
	echo "Namespace created successfully."
fi

kubectl apply -f yamls/mathfunctions_v1.yaml
if [ $? -ne 0 ]; then
    echo "mathfunctions app deployment failed."
else
	echo "mathfunctions app deployment completed successfully."
fi

kubectl apply -f yamls/numberwiki_v1.yaml
if [ $? -ne 0 ]; then
    echo "mathfunctions app deployment failed."
else
	echo "mathfunctions app deployment completed successfully."
fi

echo "***** Deploy everythingcloudplatform resources END *****"
#! /usr/bin/sh

ResourceGroup="rg-nb15-supervised"
Workspace="mlw-nb15-supervised"
Location="uksouth"
ComputeNamePrefix="cpu"

# Create workspace
echo "Creating resource group: " $ResourceGroup
az group create --name ${ResourceGroup} --location ${Location}

echo "Create an Azure Machine Learning workspace: " $Workspace
az ml workspace create --name ${Workspace} -g ${ResourceGroup}

#set the workspace, resource groups as default
az config set defaults.group=${ResourceGroup}
az config set defaults.workspace=${Workspace}

# Create compute instance with random id
guid=$(cat /proc/sys/kernel/random/uuid)
suffix=${guid//[-]/}
suffix=${suffix:0:18}

ComputeName="${ComputeNamePrefix}-${suffix}"

echo "Creating a compute instance with name: " $ComputeName
az ml compute create --name ${ComputeName} --size STANDARD_DS11_V2 \
 --type ComputeInstance -w ${Workspace} -g ${ResourceGroup}

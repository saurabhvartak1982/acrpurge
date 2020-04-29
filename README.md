# acrpurge
Shell script to purge old images (retain recent N images) in Azure Container Registry (ACR)

## Pre-requisites
Need az-cli installed on the machine on which the script **acrpurge.sh** is to be run - https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest

## Working
For the script to run, an Azure Active Directory service principal needs to be created -- https://docs.microsoft.com/en-us/cli/azure/ad/sp?view=azure-cli-latest#az-ad-sp-create-for-rbac .

The default command for the same is: <br />
az ad sp create-for-rbac -n "<sp_name>" <br />

The above command gives the below output: <br />
{ "appId": "", "displayName": "<sp_name>", "name": "http://<sp_name>", "password": "<sp_password>", "tenant": "<tenant_id>" } <br />

Now enter the above values in the shell script **acrpurge.sh** along with the registry name, repository name and the number of images which are to be retained and then run the script.

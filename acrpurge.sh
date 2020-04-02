#! /bin/bash

SP_USERNAME="<>"
SP_PASSWORD="<>"
SP_TENANT="<>"
REGISTRYNAME="<>"
REPOSITORYNAME="<>"
RETAINEDTAGS_CNT=<>

#Login using Service Principal
spdata=$(az login --service-principal --username $SP_USERNAME --password $SP_PASSWORD --tenant $SP_TENANT)


#List all the Tags in the Repository 
repositories=$(az acr repository show-tags -n $REGISTRYNAME --repository $REPOSITORYNAME --orderby time_desc --output tsv)

echo "Available Tags for the Registry $REGISTRYNAME and the Repository: $REPOSITORYNAME are:" 
echo $repositories

repoArray=($repositories)

#Retain the desired number of Tags and purge the rest
totalTags=${#repoArray[@]}
echo $totalTags

if [ $totalTags -gt $RETAINEDTAGS_CNT ]; then
	for (( tagctr=($RETAINEDTAGS_CNT); tagctr<$totalTags ; tagctr++ ))
	do
		imageName="$REPOSITORYNAME:${repoArray[$tagctr]}"
		echo "Deleting image: $imageName"
		az acr repository delete -n $REGISTRYNAME -t $imageName -y
	done
else
	echo "No images found to be purged"
fi

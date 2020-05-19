!/bin/bash

## Script to migrate from one Satellite 6 to another Satellite 6
## chsimon@redhat.com

## Make an API call to the Satellite with the curren hosts details
## Save the variables that we need
o=$(curl --request GET --insecure --user admin:changeme123 https://sat67.local.chrissimon.net/api/hosts/$(hostname) | python -m json.tool)
hg=$(echo $o |tr '"' '\n' | grep -v -e ^$ -e ^: | awk 'c&&!--c; /^hostgroup_name/{c=1}')
ak=$(echo $o |tr '"' '\n' | grep -v -e ^$ -e ^: | awk 'c&&!--c; /^activation_keys/{c=3}')


## Download the bootstrap from the Satellite Server
wget https://sat67.local.chrissimon.net/pub/bootstrap.py

## Make it executable
chmod +x bootstrap.py

## Run the bootstrap with the variables
./bootstrap.py --server sat67.local.chrissimon.net --organization="DDD" --location="DDD"  --hostgroup="$hg" --activationkey="$ak" --login admin --force --password=changeme123
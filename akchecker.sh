## Activation Key Checker
## This script will check the activation key used by the host and compare what products are enabled on each Red Hat Satellite 6

## Check what activation key was used by host
o=$(curl --request GET --insecure --user admin:changeme123 https://sat67.local.chrissimon.net/api/hosts/$(hostname) | python -m json.tool)
ak=$(echo $o |tr '"' '\n' | grep -v -e ^$ -e ^: | awk 'c&&!--c; /^activation_keys/{c=3}')

## Get Activation Key ID from new Satellite
akd=$(curl --request GET --insecure --user admin:changeme123 https://sat67.local.chrissimon.net/katello/api/environments/2/activation_keys | python -m json.tool | grep -B 3 "$ak" |tr '"' '\n' | awk 'c&&!--c; /^id/{c=1}' | grep -Eo '[0-9]{1,4}')


## Get the Activation Key ID from old Satellite
akdo=$(curl --request GET --insecure --user admin:changeme123 https://sat63.local.chrissimon.net/katello/api/environments/2/activation_keys | python -m json.tool | grep -B 3 "$ak" |tr '"' '\n' | awk 'c&&!--c; /^id/{c=1}' | grep -Eo '[0-9]{1,4}')


## Output what is enabled on activation key on new satellite
curl --request GET --insecure --user admin:changeme123 https://sat67.local.chrissimon.net/katello/api/activation_keys/"$akd"/product_content | python -m json.tool | grep -B 6 true  | grep label > key1.txt


## Output what is enabled on activation key on old satellite
curl --request GET --insecure --user admin:changeme123 https://sat63.local.chrissimon.net/katello/api/activation_keys/"$akdo"/product_content | python -m json.tool | grep -B 6 true  | grep label > key2.txt

diff  -y <(sort key1.txt) <(sort key2.txt)

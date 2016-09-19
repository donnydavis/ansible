%post
# Put this into your kickstart to register your machine with tower
# The first command gets your token and puts it in a file called auth
curl --silent -k -H 'Content-Type: application/json' -XPOST --data '{"username":"INSERTYOURUSERNAMEHERE","password":"INSERTYOURPASSWORDHERE"}' https://INSERTTOWERURLHERE/api/v1/authtoken/ --stderr - | cut -d"\"" -f4 > auth
# This registers your token as a variable for use later in registraion
AUTHTOKEN=$(cat auth)
# This will use your interface IP address (This will only work if there is one interface)
NAME=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/')
# Now we combine the token, and the IP address to send to tower
curl -vk -H "Authorization: Token $AUTHTOKEN" -H 'Content-Type: application/json' -X POST --data '{"name":"'"$NAME"'","inventory":"INSERTINVENTORY ID # such as 4"}' https://INSERTTOWERURLHERE/api/v1/inventories/INVENTORYNUMBER/hosts/

# To check which inventory this host belongs in, please use the API Browser in Ansible Tower 
%end

# The below example is going to use the admin user and Tower located at https://tower.fortnebula.com, with an inventory ID of 4

curl --silent -k -H 'Content-Type: application/json' -XPOST --data '{"username":"admin","password":"supersecret"}' https://tower.fortnebula.com/api/v1/authtoken/ --stderr - | cut -d"\"" -f4 > auth
AUTHTOKEN=$(cat auth)
NAME=$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/')
curl -vk -H "Authorization: Token $AUTHTOKEN" -H 'Content-Type: application/json' -X POST --data '{"name":"'"$NAME"'","inventory":"4"}' https://tower.fortnebula.com/api/v1/inventories/4/hosts/





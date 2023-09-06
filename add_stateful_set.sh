#!/bin/bash

# Ask the user for the replica set number
read -p "Enter the replica set number: " replica_set_number

# Construct the pod name
pod_name=mongo-0

# Construct the rs.add() command with the user input
add_command="kubectl exec -it mongo-0 -- mongosh --eval \"rs.add('mongo-$replica_set_number.mongo:27017')\""

# Execute the rs.add() command
eval $add_command
#!/bin/bash

###############
# Create new tag 
# elyhamza/nginx-codeday-v1-blue:latest
# elyhamza/nginx-codeday-v2-green:latest
###############

docker tag nginx-codeday-v1-blue:latest elyhamza/nginx-codeday-v1-blue:latest
docker tag nginx-codeday-v2-green:latest elyhamza/nginx-codeday-v2-green:latest

# Check created tags
docker images | grep -e elyhamza/nginx-codeday-v1-blue:latest -e elyhamza/nginx-codeday-v2-green:latest

# Push the created tags
docker push elyhamza/nginx-codeday-v1-blue:latest
docker push elyhamza/nginx-codeday-v2-green:latest

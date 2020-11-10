#### 
# - 0 -  Docker compose - build docker images
#### 
$> cd Demo_CodeWorks/blue_green/app
$> docker-compose build

# Create tags
$> cd scripts
$> ./docker.sh

#### 
# - 1 - Create a new NameSpace 
#### 
kubectl create ns codeday

#### 
# - 2 - Change the current default namespace 
#### 

# To codeday
kubectl config set-context --current --namespace=codeday

# To default
kubectl config set-context --current --namespace=default

#### 
# - 3 - Codeday v1 / v2 Services 
#### 

$> cd Demo_CodeWorks/blue_green/k8s

# Codeday V1 Blue Service
$> kubectl create -f nginx-codeday-blue.service.yml -n codeday --save-config --record

# Codeday V1 Green Service
$> kubectl create -f nginx-codeday-green.service.yml -n codeday --save-config --record

#### 
# - 4 - Define environment variables for codeday-v2-blue 
#### 

export DCK_IMAGE_SUFFIX=codeday-v1-blue

#### 
# - 5 - NGINX CodeDay v1 Deployment 
#### 
cat nginx-codeday.deployment.yml | sh config.sh | kubectl create -n codeday --save-config --record -f -

#### 
# - 6 - NGINX Codeday v1 / v2 Public Service 
#### 
cat nginx-codeday-public.service.yml | sh config.sh | kubectl create -n codeday --save-config --record -f -

#### 
# - 7 - Check Codeday Website Version 
#### 
$> cd scripts
$> ./curl_codeday_public_service.sh

# #############################################################
# ############ SWITCH TO GREEN AFTER CHECKS PASS ############ # 
# #############################################################

#### 
# - 8 - Update DCK_IMAGE_SUFFIX env variable to codeday-v2-green 
#### 

export DCK_IMAGE_SUFFIX=codeday-v2-green

#### 
# - 9 - Update NGINX Codeday Deployment 
#### 
cat nginx-codeday.deployment.yml | sh config.sh | kubectl apply -n codeday --record -f -

#### 
# - 10 - Update NGINX Codeday v1/v2 Public Service 
#### 
cat nginx-codeday-public.service.yml | sh config.sh | kubectl apply -n codeday --record -f -

# ###### #
# FINISH #
# ###### #
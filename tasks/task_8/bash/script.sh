#!/bin/bash


os=$(uname)

if [ "$os" = "Linux" ]; then

    echo "This is a Linux machine"

    if [[ -f /etc/redhat-release ]]; then
        echo redhat
        sudo yum install -y unzip
        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
        unzip awscliv2.zip
        sudo ./aws/install
    elif [ -f /etc/amazon-linux-release ]; then
        echo redhat
        sudo apt update
        sudo apt install -y unzip
        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
        unzip awscliv2.zip
        sudo ./aws/install
  elif [[ -f /etc/debian_version ]]; then
        echo ubuntu
        sudo apt update
        sudo apt install -y unzip
        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
        unzip awscliv2.zip
        sudo ./aws/install
  fi

elif [ "$os" = "Darwin" ]; then
    echo "This is a Mac Machine" 
    curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
elif [ "$os" = "Darwin" ]; then
    echo "This is a Mac Machine" 
    curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
else
    powershell -Command "Invoke-WebRequest -Uri https://www.python.org/ftp/python/3.10.0/python-3.10.0-amd64.exe -OutFile python-installer.exe"
    python-installer.exe /quiet InstallAllUsers=1 PrependPath=1
    python --version
    pip --version
    pip install awscli
fi

rm -r awscliv2.zip
rm -r aws

read -p "AWS_ACCESS_KEY_ID: " aws_access_key_id
read -p "AWS_SECRET_ACCESS_KEY: " aws_secret_access_key
read -p "REGION: " aws_region
read -p "PROFILE NAME: " aws_profile

aws_profile=${aws_profile:-default}
    
aws configure set aws_access_key_id "$aws_access_key_id" --profile "$aws_profile"
aws configure set aws_secret_access_key "$aws_secret_access_key" --profile "$aws_profile"
aws configure set region "$aws_region" --profile "$aws_profile"

echo "Profile $aws_profile was sucsesfully made!"
sleep 10000

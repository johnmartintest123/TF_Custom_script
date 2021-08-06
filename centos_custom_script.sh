#!/bin/bash

# this script does the following:
# Creates a user
# Gives the user admin privileges
# Removes the user's Password
# Enables SSH via PEM file authentication

username=$1
public_key=$2

sudo adduser $username

sudo usermod -aG wheel $username

sudo mkdir /home/$username/.ssh

sudo setfacl -Rm u:rootuser:rwx /home/$username

sudo echo $public_key > /home/$username/.ssh/authorized_keys

sudo chmod 700 /home/$username/.ssh

sudo chmod 600 /home/$username/.ssh/authorized_keys

sudo chown -R $username:$username /home/$username

sudo setfacl -Rb /home/$username

sudo passwd -d $username

username=user60

printf "/c/Users/admin/Desktop/testkeys/$username" | ssh-keygen -P ""
cp /c/Users/admin/Desktop/testkeys/$username.pub /c/Users/admin/Desktop/authorized_keys

ssh -tt -i /c/Users/admin/Desktop/keys/azureCentOS rootuser@40.69.187.36 "sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config ; sudo systemctl restart sshd ; sudo adduser $username ; sudo mkdir /home/$username/.ssh ; sudo setfacl -Rm u:rootuser:rwx /home/$username"

scp -i /c/Users/admin/Desktop/keys/azureCentOS /c/Users/admin/Desktop/authorized_keys rootuser@40.69.187.36:/home/$username/.ssh/

rm /c/Users/admin/Desktop/authorized_keys

ssh -i /c/Users/admin/Desktop/keys/azureCentOS rootuser@40.69.187.36 "sudo chmod 700 /home/$username/.ssh; sudo chmod 600 /home/$username/.ssh/authorized_keys; sudo chown -R $username:$username /home/$username/.ssh ; sudo setfacl -m u:rootuser:rw /etc/sudoers ; sudo echo '$username ALL=(ALL:ALL) ALL' >> /etc/sudoers ; sudo setfacl -b /etc/sudoers ; sudo passwd -d $username"

#!/bin/bash

# Create the user if it doesn't exist
if ! id "ansible" &>/dev/null; then
    useradd -m -s /bin/bash ansible
    usermod -aG sudo ansible
    
    # Allow sudo without password
    echo "ansible ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ansible
fi

# Add SSH key
mkdir -p /home/ansible/.ssh
chmod 700 /home/ansible/.ssh

echo "${ssh_key}" > /home/ansible/.ssh/authorized_keys
chmod 600 /home/ansible/.ssh/authorized_keys
chown -R ansible:ansible /home/ansible/.ssh
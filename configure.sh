#!/bin/bash

# Function to check if ansible is installed
check_ansible_installed() {
    if command -v ansible &>/dev/null; then
        echo "Ansible is already installed."
    else
        echo "Ansible is not installed. Installing Ansible..."
        install_ansible
    fi
}

# Function to install Ansible
install_ansible() {
    # Check the OS type and install Ansible accordingly
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # For Debian/Ubuntu
        if [ -f /etc/debian_version ]; then
            sudo apt update
            sudo apt install -y software-properties-common
            sudo add-apt-repository ppa:ansible/ansible
            sudo apt update
            sudo apt install -y ansible
        # For CentOS/RHEL
        elif [ -f /etc/redhat-release ]; then
            sudo yum install -y epel-release
            sudo yum install -y ansible
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # For macOS
        brew install ansible
    else
        echo "Unsupported OS. Please install Ansible manually."
        exit 1
    fi
}

# Function to run the Ansible playbook
run_ansible_playbook() {
    if [ -f configure.yml ]; then
        ansible-playbook configure.yml
    else
        echo "Error: configure.yml playbook file not found!"
        exit 1
    fi
}

# Main script execution
check_ansible_installed
run_ansible_playbook

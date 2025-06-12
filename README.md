# Fully Automated Minecraft Aerver on AWS Asing Terraform and Ansible

## Project Overview

This project automates the deployment of a Minecraft Java Edition server on AWS using Terraform for infrastructure provisioning and Ansible for server configuration. The end result is a fully functional, persistent Minecraft server running on an EC2 instance.

## Requirments

Before using the code in this repository you must:

- Install Terraform v1.5.0+ [Installation Guide](https://developer.hashicorp.com/terraform/install)
- Install Ansible v2.14+ [Installation Guide](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- Install AWS CLI v2.0+ [Installation Guide](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- Install Python Pip3 v22 [Installation Guide](https://pip.pypa.io/en/stable/installation/)
- Have access to an AWS account and IAM user with EC2 and VPC permissions
- Configure AWS CLI with your credentials
    ```
    aws configure
    ```
    - Region: ```us-west-2```
- Create a SSH key pair located in ~/.ssh/ named "minecraft-key"
    - You can use an existing key pair or create a new one
    ```
    ssh-keygen -t rsa -b 4096 -f ~/.ssh/minecraft-key
    ```

## Pipleline Overview

This project consists of two main stages:

Infrastructure provisioning using Terraform:

- VPC with public subnet
- Security Group with port 25565 (Minecraft) and SSH
- EC2 instance (Amazon Linux)

Configuration using Ansible:

- Installs Java
- Downloads Minecraft server jar
- Accepts EULA
- Creates a systemd service to auto-start Minecraft

## Tutorial

Follow these steps to ully automate a Minecraft server on AWS using Terraform and Ansible

1. Clone the repository
    ```
    git clone https://github.com/RhineMaiden/Minecraft_Part2
    ```
2. Navigate to the terraform folder
    ```
    cd Minecraft_Part2/terraform
3. Provision the infrastructure using Terraform
    ```
    terraform init
    terraform plan
    terraform apply -auto-approve
4. Save the public IP address
    - At the end of the last step, Terraform will output your Minecraft server's public IP. Save this, you will need it later
    - Example
    ```
    Outputs:
    instance_public_ip = "XX.XXX.XXX.XX"

5. Navigate to Ansible folder
    ```
    cd ../ansible
6. Run the Ansible Playbook
    - Replace your Ip address in the line below. Type yes to confirm the action

    ```
    ansible-playbook -i < IP address >, playbook.yaml --private-key ~/.ssh/minecraft-key --user ubuntu
    ```
    - Type yes when prompted to trust the host
7. Connect to Your Server
    - Option 1: Minecraft Java Edition Client
        - Open Minecraft
        - Go to Multiplayer → Add Server
        - Server Name: Automated Minecraft Server
        - Server Address: Your server's public IP
        - Click Join
    - Option 2: Verify with nmap
    ```
    nmap -sV -Pn -p T:25565 54.202.128.15
    ```
    - You should see port 25565 listed as open

## Sources

- [Minecraft Java Server Downloads](https://www.minecraft.net/en-us/download/server)
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Ansible Docs](https://docs.ansible.com/)
- [Systemd Service Configuration](https://www.freedesktop.org/software/systemd/man/systemd.service.html)
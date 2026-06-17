![GCP](https://img.shields.io/badge/-Google%20Cloud-4285F4?style=flat&logo=googlecloud&logoColor=white)
![Terraform](https://img.shields.io/badge/-Terraform-7B42BC?style=flat&logo=terraform&logoColor=white)
![Ansible](https://img.shields.io/badge/-Ansible-EE0000?style=flat&logo=ansible&logoColor=white)

# Cloud-Infra:
Cloud & DevOps learning repository focused on Infrastructure as Code (Terraform), configuration management (Ansible), cloud platforms (GCP), CI/CD pipelines, and automation. Includes real-world examples, and projects to build modern Cloud & DevOps skills.

## Overview:

in this repo i will implement a simple infrastructure on GCP using Terraform and Ansible. The infrastructure will consist of a VPC with subnets, firewall rules, and a few virtual machines (VMs) running on Google Compute Engine. The VMs will be configured using Ansible to install necessary software and set up the environment.

## Architecture:

<div align="center">
  <img src="./docs/img/archi.svg" alt="Architecture Diagram" width="600">
</div>


## Structure:
```
Cloud-Infra/
├── modules/
│   ├── network/
│   │   ├── main.tf
│   │   ├── var.tf
│   │   └── output.tf
│   ├── vms/
│   │   ├── main.tf
│   │   ├── var.tf
│   │   └── output.tf
│   └── storage/
│       ├── main.tf
│       ├── var.tf
│       └── output.tf
├── ansible/
│   └── ...
├── main.tf
├── variables.tf
├── outputs.tf
└── README.md
```

## Terraform Modules:
- **Network Module**: This module will create a VPC, subnets, and firewall rules. It will allow for the creation of both public and private subnets based on the provided variables.
- **VMs Module**: This module will create virtual machines in the specified subnets. It will also allow for the option to assign public IP addresses to the VMs based on the provided
- **Storage Module**: This module will create a Cloud Storage bucket , SQL databases , cache instances and other storage resources as needed.


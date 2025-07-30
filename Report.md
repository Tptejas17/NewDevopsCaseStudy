# DevOps Case Study: CI/CD Pipeline for Node.js App on AWS

## Project Overview
This project demonstrates a complete DevOps pipeline using:
- Git & GitHub
- Jenkins CI/CD
- Docker & DockerHub
- Terraform (AWS EC2 provisioning)
- Ansible (remote configuration)
- A Node.js application

---

##Architecture Diagram
GitHub → Jenkins → Docker Build → Push to DockerHub
↓
Terraform → Provision EC2
↓
Ansible → Configure EC2
↓
Node.js App Running in Docker on AWS EC2 (Accessible via browser)

---

## 🌿 Branching Strategy

- **Main branch** is used for all pipeline runs and code updates
- Feature branches can be used for development, then merged into `main` to trigger Jenkins

---

## ☁️ Terraform Resource Summary

### Resources:
- `aws_instance` → EC2 instance for app deployment
- `aws_security_group` → Allows inbound SSH (22) and HTTP (80) access
- `data "aws_vpc"` → Fetches the default VPC
- `output "public_ip"` → Outputs EC2 IP for pipeline use

### Key Configs:
- Region: `ap-south-1`
- Instance type: `t2.micro`
- AMI: `ami-03bb6d83c60fc5f7c`
- Key pair: `devops-server-keypair`

---

###Jenkins Pipeline Overview

### Jenkinsfile stages:
1. **Checkout Code** – Pulls code from GitHub
2. **Build Docker Image** – Builds & pushes to DockerHub (`tejasparab17/casestudy-node-app`)
3. **Provision EC2** – Uses Terraform to create instance & security group
4. **Configure EC2** – Uses Ansible to SSH & run Docker container with the app
5. **Post Steps** – Logs success/failure

---

## Public IP for App (Demo)

After deployment, the app can be accessed via:
http://<your-latest-EC2-IP> (e.g. http://13.235.90.139)

---

## Maintainer

**Tejas Parab**  
GitHub: [@Tptejas17](https://github.com/Tptejas17)  


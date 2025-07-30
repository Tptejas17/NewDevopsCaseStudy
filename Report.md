

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

<img width="1394" height="819" alt="image" src="https://github.com/user-attachments/assets/f09134ac-e0a7-47b3-a60b-ce59b42aa2a5" />


## pipeline logs
Started by user Tejas parab
Obtained Jenkinsfile from git https://github.com/Tptejas17/NewDevopsCaseStudy.git
[Pipeline] Start of Pipeline
[Pipeline] node
Running on Jenkins in /var/lib/jenkins/workspace/NewDevopsCaseStudy
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Declarative: Checkout SCM)
[Pipeline] checkout
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential GitHubToken
 > git rev-parse --resolve-git-dir /var/lib/jenkins/workspace/NewDevopsCaseStudy/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/Tptejas17/NewDevopsCaseStudy.git # timeout=10
Fetching upstream changes from https://github.com/Tptejas17/NewDevopsCaseStudy.git
 > git --version # timeout=10
 > git --version # 'git version 2.43.0'
using GIT_ASKPASS to set credentials 
 > git fetch --tags --force --progress -- https://github.com/Tptejas17/NewDevopsCaseStudy.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/main^{commit} # timeout=10
Checking out Revision eee774667c1783edf2bf2938918f468cec307a2f (refs/remotes/origin/main)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f eee774667c1783edf2bf2938918f468cec307a2f # timeout=10
Commit message: "Added HTTP (port 80) rule to security group for browser access"
 > git rev-list --no-walk f29f4d39f17ffe13f9fc06819def1e34efb685fa # timeout=10
[Pipeline] }
[Pipeline] // stage
[Pipeline] withEnv
[Pipeline] {
[Pipeline] withEnv
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Checkout Code)
[Pipeline] git
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
using credential GitHubToken
 > git rev-parse --resolve-git-dir /var/lib/jenkins/workspace/NewDevopsCaseStudy/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/Tptejas17/NewDevopsCaseStudy.git # timeout=10
Fetching upstream changes from https://github.com/Tptejas17/NewDevopsCaseStudy.git
 > git --version # timeout=10
 > git --version # 'git version 2.43.0'
using GIT_ASKPASS to set credentials 
 > git fetch --tags --force --progress -- https://github.com/Tptejas17/NewDevopsCaseStudy.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/main^{commit} # timeout=10
Checking out Revision eee774667c1783edf2bf2938918f468cec307a2f (refs/remotes/origin/main)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f eee774667c1783edf2bf2938918f468cec307a2f # timeout=10
 > git branch -a -v --no-abbrev # timeout=10
 > git branch -D main # timeout=10
 > git checkout -b main eee774667c1783edf2bf2938918f468cec307a2f # timeout=10
Commit message: "Added HTTP (port 80) rule to security group for browser access"
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Build Docker Image)
[Pipeline] sh
+ chmod +x scripts/build_and_push.sh
[Pipeline] withCredentials
Masking supported pattern matches of $DOCKER_PASS
[Pipeline] {
[Pipeline] sh
+ ./scripts/build_and_push.sh
[INFO] Building Docker image: tejasparab17/casestudy-node-app:latest
#0 building with "default" instance using docker driver

#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile: 352B 0.0s done
#1 DONE 0.0s

#2 [internal] load metadata for docker.io/library/node:18
#2 ...

#3 [auth] library/node:pull token for registry-1.docker.io
#3 DONE 0.0s

#2 [internal] load metadata for docker.io/library/node:18
#2 DONE 1.7s

#4 [internal] load .dockerignore
#4 transferring context: 2B done
#4 DONE 0.0s

#5 [internal] load build context
#5 transferring context: 90B done
#5 DONE 0.0s

#6 [1/5] FROM docker.io/library/node:18@sha256:c6ae79e38498325db67193d391e6ec1d224d96c693a8a4d943498556716d3783
#6 resolve docker.io/library/node:18@sha256:c6ae79e38498325db67193d391e6ec1d224d96c693a8a4d943498556716d3783 0.0s done
#6 DONE 0.0s

#7 [4/5] RUN npm install
#7 CACHED

#8 [2/5] WORKDIR /app
#8 CACHED

#9 [3/5] COPY src/package*.json ./
#9 CACHED

#10 [5/5] COPY src/ .
#10 CACHED

#11 exporting to image
#11 exporting layers 0.0s done
#11 exporting manifest sha256:929200bc9b8e7d40dd8aa74ed93d8394ecdfb88c9d21aefef4c473aa40e66f0d done
#11 exporting config sha256:b01cffd59e9af8c0e74acb1415d82d399eefd0facecd28e5b3649ab18ab79d4d
#11 exporting config sha256:b01cffd59e9af8c0e74acb1415d82d399eefd0facecd28e5b3649ab18ab79d4d done
#11 exporting attestation manifest sha256:9a5376298ca334a6137a2c85b0012fffa603c5199d3fe3726d5982d7e6b8a833 0.0s done
#11 exporting manifest list sha256:7c96549ae71dda4139e375ac25e618c770b9fd08e80492308606b6ccb84b2d00 0.0s done
#11 naming to docker.io/tejasparab17/casestudy-node-app:latest done
#11 unpacking to docker.io/tejasparab17/casestudy-node-app:latest 0.0s done
#11 DONE 0.1s
[INFO] Logging into DockerHub...
WARNING! Your password will be stored unencrypted in /var/lib/jenkins/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credential-stores

Login Succeeded
[INFO] Pushing image to DockerHub...
The push refers to repository [docker.io/tejasparab17/casestudy-node-app]
c6b30c3f1696: Waiting
3e6b9d1a9511: Waiting
3697be50c98b: Waiting
d87644ddbafc: Waiting
d50ef97b5ee1: Waiting
1536895c0587: Waiting
fa97ea2b32c6: Waiting
79b2f47ad444: Waiting
e4496cae4634: Waiting
e23f099911d6: Waiting
cda7f44f2bdd: Waiting
461077a72fb7: Waiting
37927ed901b1: Waiting
d87644ddbafc: Waiting
d50ef97b5ee1: Waiting
1536895c0587: Waiting
c6b30c3f1696: Waiting
3e6b9d1a9511: Waiting
3697be50c98b: Waiting
e23f099911d6: Waiting
cda7f44f2bdd: Waiting
461077a72fb7: Waiting
37927ed901b1: Waiting
fa97ea2b32c6: Waiting
79b2f47ad444: Waiting
e4496cae4634: Waiting
cda7f44f2bdd: Waiting
461077a72fb7: Waiting
37927ed901b1: Waiting
fa97ea2b32c6: Waiting
79b2f47ad444: Waiting
e4496cae4634: Waiting
e23f099911d6: Waiting
d87644ddbafc: Waiting
d50ef97b5ee1: Waiting
1536895c0587: Waiting
c6b30c3f1696: Waiting
3e6b9d1a9511: Waiting
3697be50c98b: Waiting
37927ed901b1: Waiting
fa97ea2b32c6: Waiting
79b2f47ad444: Waiting
e4496cae4634: Waiting
e23f099911d6: Waiting
cda7f44f2bdd: Waiting
461077a72fb7: Waiting
1536895c0587: Waiting
c6b30c3f1696: Waiting
3e6b9d1a9511: Waiting
3697be50c98b: Waiting
d87644ddbafc: Waiting
d50ef97b5ee1: Waiting
e23f099911d6: Waiting
cda7f44f2bdd: Waiting
461077a72fb7: Waiting
37927ed901b1: Waiting
fa97ea2b32c6: Waiting
79b2f47ad444: Waiting
e4496cae4634: Waiting
d87644ddbafc: Waiting
d50ef97b5ee1: Waiting
1536895c0587: Waiting
c6b30c3f1696: Waiting
3e6b9d1a9511: Waiting
3697be50c98b: Waiting
3697be50c98b: Waiting
d87644ddbafc: Waiting
d50ef97b5ee1: Waiting
1536895c0587: Waiting
c6b30c3f1696: Waiting
3e6b9d1a9511: Waiting
e4496cae4634: Waiting
e23f099911d6: Waiting
cda7f44f2bdd: Waiting
461077a72fb7: Waiting
37927ed901b1: Waiting
fa97ea2b32c6: Waiting
79b2f47ad444: Waiting
d87644ddbafc: Waiting
d50ef97b5ee1: Waiting
1536895c0587: Waiting
c6b30c3f1696: Waiting
3e6b9d1a9511: Waiting
3697be50c98b: Waiting
cda7f44f2bdd: Waiting
461077a72fb7: Waiting
37927ed901b1: Waiting
fa97ea2b32c6: Waiting
79b2f47ad444: Waiting
e4496cae4634: Waiting
e23f099911d6: Waiting
d50ef97b5ee1: Waiting
1536895c0587: Waiting
c6b30c3f1696: Waiting
3e6b9d1a9511: Waiting
3697be50c98b: Waiting
d87644ddbafc: Waiting
461077a72fb7: Waiting
37927ed901b1: Waiting
fa97ea2b32c6: Waiting
79b2f47ad444: Waiting
e4496cae4634: Waiting
e23f099911d6: Waiting
cda7f44f2bdd: Waiting
d87644ddbafc: Waiting
d50ef97b5ee1: Waiting
1536895c0587: Waiting
c6b30c3f1696: Waiting
3e6b9d1a9511: Waiting
3697be50c98b: Waiting
cda7f44f2bdd: Waiting
461077a72fb7: Waiting
37927ed901b1: Waiting
fa97ea2b32c6: Waiting
79b2f47ad444: Waiting
e4496cae4634: Waiting
e23f099911d6: Waiting
79b2f47ad444: Waiting
e4496cae4634: Waiting
e23f099911d6: Waiting
cda7f44f2bdd: Waiting
461077a72fb7: Waiting
37927ed901b1: Waiting
fa97ea2b32c6: Waiting
3e6b9d1a9511: Waiting
3697be50c98b: Waiting
d87644ddbafc: Waiting
d50ef97b5ee1: Waiting
1536895c0587: Waiting
c6b30c3f1696: Waiting
cda7f44f2bdd: Waiting
461077a72fb7: Waiting
37927ed901b1: Waiting
fa97ea2b32c6: Waiting
79b2f47ad444: Waiting
e4496cae4634: Waiting
e23f099911d6: Waiting
d87644ddbafc: Waiting
d50ef97b5ee1: Waiting
1536895c0587: Waiting
c6b30c3f1696: Waiting
3e6b9d1a9511: Waiting
3697be50c98b: Waiting
fa97ea2b32c6: Waiting
79b2f47ad444: Waiting
e4496cae4634: Waiting
e23f099911d6: Waiting
cda7f44f2bdd: Waiting
461077a72fb7: Waiting
37927ed901b1: Waiting
c6b30c3f1696: Waiting
3e6b9d1a9511: Waiting
3697be50c98b: Waiting
d87644ddbafc: Waiting
d50ef97b5ee1: Waiting
1536895c0587: Waiting
e4496cae4634: Waiting
e23f099911d6: Waiting
cda7f44f2bdd: Waiting
461077a72fb7: Waiting
37927ed901b1: Waiting
fa97ea2b32c6: Waiting
79b2f47ad444: Waiting
3697be50c98b: Waiting
d87644ddbafc: Waiting
d50ef97b5ee1: Waiting
1536895c0587: Waiting
c6b30c3f1696: Waiting
3e6b9d1a9511: Waiting
37927ed901b1: Waiting
fa97ea2b32c6: Waiting
79b2f47ad444: Waiting
e4496cae4634: Waiting
e23f099911d6: Waiting
cda7f44f2bdd: Waiting
461077a72fb7: Waiting
1536895c0587: Waiting
c6b30c3f1696: Waiting
3e6b9d1a9511: Waiting
3697be50c98b: Waiting
d87644ddbafc: Waiting
d50ef97b5ee1: Waiting
461077a72fb7: Waiting
37927ed901b1: Waiting
fa97ea2b32c6: Waiting
79b2f47ad444: Waiting
e4496cae4634: Waiting
e23f099911d6: Waiting
cda7f44f2bdd: Waiting
d50ef97b5ee1: Waiting
1536895c0587: Waiting
c6b30c3f1696: Waiting
3e6b9d1a9511: Waiting
3697be50c98b: Waiting
d87644ddbafc: Waiting
d87644ddbafc: Waiting
d50ef97b5ee1: Waiting
1536895c0587: Waiting
c6b30c3f1696: Waiting
3e6b9d1a9511: Waiting
3697be50c98b: Waiting
cda7f44f2bdd: Waiting
461077a72fb7: Waiting
37927ed901b1: Waiting
fa97ea2b32c6: Waiting
79b2f47ad444: Waiting
e4496cae4634: Waiting
e23f099911d6: Waiting
79b2f47ad444: Waiting
e4496cae4634: Waiting
e23f099911d6: Waiting
cda7f44f2bdd: Waiting
461077a72fb7: Waiting
37927ed901b1: Waiting
fa97ea2b32c6: Waiting
3e6b9d1a9511: Waiting
3697be50c98b: Waiting
d87644ddbafc: Waiting
d50ef97b5ee1: Waiting
1536895c0587: Waiting
c6b30c3f1696: Waiting
e23f099911d6: Waiting
cda7f44f2bdd: Waiting
461077a72fb7: Waiting
37927ed901b1: Waiting
fa97ea2b32c6: Waiting
79b2f47ad444: Waiting
e4496cae4634: Waiting
d87644ddbafc: Waiting
d50ef97b5ee1: Waiting
1536895c0587: Waiting
c6b30c3f1696: Waiting
3e6b9d1a9511: Waiting
3697be50c98b: Waiting
3697be50c98b: Waiting
d87644ddbafc: Waiting
d50ef97b5ee1: Waiting
1536895c0587: Waiting
c6b30c3f1696: Waiting
3e6b9d1a9511: Waiting
e4496cae4634: Waiting
e23f099911d6: Waiting
cda7f44f2bdd: Waiting
461077a72fb7: Waiting
37927ed901b1: Waiting
fa97ea2b32c6: Waiting
79b2f47ad444: Waiting
d87644ddbafc: Waiting
d50ef97b5ee1: Waiting
1536895c0587: Waiting
c6b30c3f1696: Waiting
3e6b9d1a9511: Waiting
3697be50c98b: Layer already exists
cda7f44f2bdd: Waiting
461077a72fb7: Waiting
37927ed901b1: Waiting
fa97ea2b32c6: Waiting
79b2f47ad444: Waiting
e4496cae4634: Waiting
e23f099911d6: Waiting
d50ef97b5ee1: Waiting
1536895c0587: Waiting
c6b30c3f1696: Waiting
3e6b9d1a9511: Waiting
d87644ddbafc: Waiting
461077a72fb7: Waiting
37927ed901b1: Waiting
fa97ea2b32c6: Waiting
79b2f47ad444: Waiting
e4496cae4634: Waiting
e23f099911d6: Waiting
cda7f44f2bdd: Waiting
79b2f47ad444: Waiting
e4496cae4634: Waiting
e23f099911d6: Waiting
cda7f44f2bdd: Waiting
461077a72fb7: Waiting
37927ed901b1: Waiting
fa97ea2b32c6: Waiting
3e6b9d1a9511: Waiting
d87644ddbafc: Waiting
d50ef97b5ee1: Layer already exists
1536895c0587: Waiting
c6b30c3f1696: Waiting
461077a72fb7: Waiting
37927ed901b1: Waiting
fa97ea2b32c6: Waiting
79b2f47ad444: Waiting
e4496cae4634: Waiting
e23f099911d6: Waiting
cda7f44f2bdd: Waiting
1536895c0587: Waiting
c6b30c3f1696: Waiting
3e6b9d1a9511: Waiting
d87644ddbafc: Waiting
79b2f47ad444: Layer already exists
e4496cae4634: Layer already exists
e23f099911d6: Layer already exists
cda7f44f2bdd: Layer already exists
461077a72fb7: Waiting
37927ed901b1: Waiting
fa97ea2b32c6: Layer already exists
3e6b9d1a9511: Layer already exists
1536895c0587: Layer already exists
c6b30c3f1696: Waiting
461077a72fb7: Waiting
37927ed901b1: Waiting
c6b30c3f1696: Waiting
c6b30c3f1696: Waiting
37927ed901b1: Layer already exists
461077a72fb7: Layer already exists
c6b30c3f1696: Layer already exists
d87644ddbafc: Pushed
latest: digest: sha256:7c96549ae71dda4139e375ac25e618c770b9fd08e80492308606b6ccb84b2d00 size: 856
[Pipeline] }
[Pipeline] // withCredentials
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Provision EC2 with Terraform)
[Pipeline] dir
Running in /var/lib/jenkins/workspace/NewDevopsCaseStudy/infra
[Pipeline] {
[Pipeline] withCredentials
Masking supported pattern matches of $AWS_ACCESS_KEY_ID or $AWS_SECRET_ACCESS_KEY
[Pipeline] {
[Pipeline] sh
+ terraform init
[0m[1mInitializing the backend...[0m
[0m[1mInitializing provider plugins...[0m
- Reusing previous version of hashicorp/aws from the dependency lock file
- Using previously-installed hashicorp/aws v6.6.0

[0m[1m[32mTerraform has been successfully initialized![0m[32m[0m
[0m[32m
You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.[0m
+ terraform destroy -auto-approve -var aws_access_key=**** -var aws_secret_key=****

[0m[1m[32mNo changes.[0m[1m No objects need to be destroyed.[0m

[0mEither you have not created any objects yet or the existing objects were
already deleted outside of Terraform.
[0m[1m[32m
Destroy complete! Resources: 0 destroyed.
[0m+ terraform apply -auto-approve -var aws_access_key=**** -var aws_secret_key=****
[0m[1mdata.aws_vpc.default: Reading...[0m[0m
[0m[1mdata.aws_vpc.default: Read complete after 1s [id=vpc-06c233182721e338c][0m

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  [32m+[0m create[0m

Terraform will perform the following actions:

[1m  # aws_instance.app_server[0m will be created
[0m  [32m+[0m[0m resource "aws_instance" "app_server" {
      [32m+[0m[0m ami                                  = "ami-03bb6d83c60fc5f7c"
      [32m+[0m[0m arn                                  = (known after apply)
      [32m+[0m[0m associate_public_ip_address          = (known after apply)
      [32m+[0m[0m availability_zone                    = (known after apply)
      [32m+[0m[0m disable_api_stop                     = (known after apply)
      [32m+[0m[0m disable_api_termination              = (known after apply)
      [32m+[0m[0m ebs_optimized                        = (known after apply)
      [32m+[0m[0m enable_primary_ipv6                  = (known after apply)
      [32m+[0m[0m get_password_data                    = false
      [32m+[0m[0m host_id                              = (known after apply)
      [32m+[0m[0m host_resource_group_arn              = (known after apply)
      [32m+[0m[0m iam_instance_profile                 = (known after apply)
      [32m+[0m[0m id                                   = (known after apply)
      [32m+[0m[0m instance_initiated_shutdown_behavior = (known after apply)
      [32m+[0m[0m instance_lifecycle                   = (known after apply)
      [32m+[0m[0m instance_state                       = (known after apply)
      [32m+[0m[0m instance_type                        = "t2.micro"
      [32m+[0m[0m ipv6_address_count                   = (known after apply)
      [32m+[0m[0m ipv6_addresses                       = (known after apply)
      [32m+[0m[0m key_name                             = "devops-server-keypair"
      [32m+[0m[0m monitoring                           = (known after apply)
      [32m+[0m[0m outpost_arn                          = (known after apply)
      [32m+[0m[0m password_data                        = (known after apply)
      [32m+[0m[0m placement_group                      = (known after apply)
      [32m+[0m[0m placement_partition_number           = (known after apply)
      [32m+[0m[0m primary_network_interface_id         = (known after apply)
      [32m+[0m[0m private_dns                          = (known after apply)
      [32m+[0m[0m private_ip                           = (known after apply)
      [32m+[0m[0m public_dns                           = (known after apply)
      [32m+[0m[0m public_ip                            = (known after apply)
      [32m+[0m[0m region                               = "ap-south-1"
      [32m+[0m[0m secondary_private_ips                = (known after apply)
      [32m+[0m[0m security_groups                      = (known after apply)
      [32m+[0m[0m source_dest_check                    = true
      [32m+[0m[0m spot_instance_request_id             = (known after apply)
      [32m+[0m[0m subnet_id                            = (known after apply)
      [32m+[0m[0m tags                                 = {
          [32m+[0m[0m "Name" = "CaseStudyAppInstance"
        }
      [32m+[0m[0m tags_all                             = {
          [32m+[0m[0m "Name" = "CaseStudyAppInstance"
        }
      [32m+[0m[0m tenancy                              = (known after apply)
      [32m+[0m[0m user_data_base64                     = (known after apply)
      [32m+[0m[0m user_data_replace_on_change          = false
      [32m+[0m[0m vpc_security_group_ids               = (known after apply)

      [32m+[0m[0m capacity_reservation_specification (known after apply)

      [32m+[0m[0m cpu_options (known after apply)

      [32m+[0m[0m ebs_block_device (known after apply)

      [32m+[0m[0m enclave_options (known after apply)

      [32m+[0m[0m ephemeral_block_device (known after apply)

      [32m+[0m[0m instance_market_options (known after apply)

      [32m+[0m[0m maintenance_options (known after apply)

      [32m+[0m[0m metadata_options (known after apply)

      [32m+[0m[0m network_interface (known after apply)

      [32m+[0m[0m private_dns_name_options (known after apply)

      [32m+[0m[0m root_block_device (known after apply)
    }

[1m  # aws_security_group.ssh_access[0m will be created
[0m  [32m+[0m[0m resource "aws_security_group" "ssh_access" {
      [32m+[0m[0m arn                    = (known after apply)
      [32m+[0m[0m description            = "Allow SSH access from anywhere"
      [32m+[0m[0m egress                 = [
          [32m+[0m[0m {
              [32m+[0m[0m cidr_blocks      = [
                  [32m+[0m[0m "0.0.0.0/0",
                ]
              [32m+[0m[0m from_port        = 0
              [32m+[0m[0m ipv6_cidr_blocks = []
              [32m+[0m[0m prefix_list_ids  = []
              [32m+[0m[0m protocol         = "-1"
              [32m+[0m[0m security_groups  = []
              [32m+[0m[0m self             = false
              [32m+[0m[0m to_port          = 0
                [90m# (1 unchanged attribute hidden)[0m[0m
            },
        ]
      [32m+[0m[0m id                     = (known after apply)
      [32m+[0m[0m ingress                = [
          [32m+[0m[0m {
              [32m+[0m[0m cidr_blocks      = [
                  [32m+[0m[0m "0.0.0.0/0",
                ]
              [32m+[0m[0m description      = "Allow HTTP"
              [32m+[0m[0m from_port        = 80
              [32m+[0m[0m ipv6_cidr_blocks = []
              [32m+[0m[0m prefix_list_ids  = []
              [32m+[0m[0m protocol         = "tcp"
              [32m+[0m[0m security_groups  = []
              [32m+[0m[0m self             = false
              [32m+[0m[0m to_port          = 80
            },
          [32m+[0m[0m {
              [32m+[0m[0m cidr_blocks      = [
                  [32m+[0m[0m "0.0.0.0/0",
                ]
              [32m+[0m[0m description      = "Allow SSH"
              [32m+[0m[0m from_port        = 22
              [32m+[0m[0m ipv6_cidr_blocks = []
              [32m+[0m[0m prefix_list_ids  = []
              [32m+[0m[0m protocol         = "tcp"
              [32m+[0m[0m security_groups  = []
              [32m+[0m[0m self             = false
              [32m+[0m[0m to_port          = 22
            },
        ]
      [32m+[0m[0m name                   = (known after apply)
      [32m+[0m[0m name_prefix            = "allow_ssh_jenkins_"
      [32m+[0m[0m owner_id               = (known after apply)
      [32m+[0m[0m region                 = "ap-south-1"
      [32m+[0m[0m revoke_rules_on_delete = false
      [32m+[0m[0m tags                   = {
          [32m+[0m[0m "Name" = "AllowSSHFromAnywhere"
        }
      [32m+[0m[0m tags_all               = {
          [32m+[0m[0m "Name" = "AllowSSHFromAnywhere"
        }
      [32m+[0m[0m vpc_id                 = "vpc-06c233182721e338c"
    }

[1mPlan:[0m 2 to add, 0 to change, 0 to destroy.
[0m
Changes to Outputs:
  [32m+[0m[0m public_ip = (known after apply)
[0m[1maws_security_group.ssh_access: Creating...[0m[0m
[0m[1maws_security_group.ssh_access: Creation complete after 3s [id=sg-08ba0d769b7d82720][0m
[0m[1maws_instance.app_server: Creating...[0m[0m
[0m[1maws_instance.app_server: Still creating... [00m10s elapsed][0m[0m
[0m[1maws_instance.app_server: Still creating... [00m20s elapsed][0m[0m
[0m[1maws_instance.app_server: Creation complete after 21s [id=i-03a768de6818028c0][0m
[0m[1m[32m
Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
[0m[0m[1m[32m
Outputs:

[0mpublic_ip = "13.235.90.139"
[Pipeline] }
[Pipeline] // withCredentials
[Pipeline] }
[Pipeline] // dir
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Configure EC2 with Ansible)
[Pipeline] dir
Running in /var/lib/jenkins/workspace/NewDevopsCaseStudy/ansible
[Pipeline] {
[Pipeline] withCredentials
Masking supported pattern matches of $SSH_KEY or $AWS_ACCESS_KEY_ID or $AWS_SECRET_ACCESS_KEY
[Pipeline] {
[Pipeline] script
[Pipeline] {
[Pipeline] sh
+ /usr/local/bin/aws ec2 describe-instances --filters Name=tag:Name,Values=CaseStudyAppInstance --query Reservations[*].Instances[*].PublicIpAddress --output text --region ap-south-1
[Pipeline] writeFile
Warning: A secret was passed to "writeFile" using Groovy String interpolation, which is insecure.
		 Affected argument(s) used the following variable(s): [SSH_KEY]
		 See https://jenkins.io/redirect/groovy-string-interpolation for details.
[Pipeline] }
[Pipeline] // script
[Pipeline] sh
+ echo ✅ Waiting for EC2 instance to be ready...
✅ Waiting for EC2 instance to be ready...
+ /usr/local/bin/aws ec2 describe-instances --filters Name=tag:Name,Values=CaseStudyAppInstance --query Reservations[*].Instances[*].InstanceId --output text --region ap-south-1
+ INSTANCE_ID=i-01d77e628b9f1f11b
i-0da98ab4cb2534a19
i-0d3f1c9b47a7757b4
i-03a768de6818028c0
+ /usr/local/bin/aws ec2 wait instance-status-ok --instance-ids i-01d77e628b9f1f11b i-0da98ab4cb2534a19 i-0d3f1c9b47a7757b4 i-03a768de6818028c0 --region ap-south-1
+ chmod 400 ****
+ ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts.ini deploy.yml --private-key ****

PLAY [Deploy Node.js App with Docker] ******************************************

TASK [Gathering Facts] *********************************************************
ok: [13.235.90.139]

TASK [Install Docker on Ubuntu] ************************************************
changed: [13.235.90.139]

TASK [Start Docker Service] ****************************************************
ok: [13.235.90.139]

TASK [Pull Node.js App Image from DockerHub] ***********************************
changed: [13.235.90.139]

TASK [Run Node.js Container] ***************************************************
changed: [13.235.90.139]

PLAY RECAP *********************************************************************
13.235.90.139              : ok=5    changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

[Pipeline] }
[Pipeline] // withCredentials
[Pipeline] }
[Pipeline] // dir
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Declarative: Post Actions)
[Pipeline] echo
✅ Pipeline completed successfully.
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
Finished: SUCCESS

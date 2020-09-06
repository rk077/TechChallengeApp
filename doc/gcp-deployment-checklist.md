# GCP Deployment Checklist
## Prerequisites
- [x] Google Cloud SDK (https://cloud.google.com/sdk/install)
- [x] Terraform (https://www.terraform.io/downloads.html)
- [x] A new GCP project with Project Owner Role of the GCP Project
- [x] Use the same values for secrets as stored in Github secrets configured for automatated CI-CD (DB credentials etc)
- [x] Create a new instance for cloud run and container registry
- [x] Connect to gcloud for the Project and run the following
```bash
git clone  git@github.com:rk077/TechChallengeApp.git
cd TechChallengeApp/deployment/terraform/
```


### Step 1 - Service Accounts:
- [x] Terraform deployer: `./credentials/deployment-sa.json`
  + Project Editor
  + Kubernetes Engine Admin
  + Cloud SQL Admin
  + No User/Account Roles
  + Create JSON Key for Service Account save to above location
- [x] Cloud SQL Admin: `./credentials/cloud-sql-sa.json`
  + Cloud SQL Admin
  + No User/Account Roles
  + Create JSON Key for Service Account save to above location


### Step 2 - Create Cloud SQL Database
- [x] Create Cloud SQL Instance
  + Type: PostegreSQL
  + Instance ID: `${ANY}`
  + Default User Password: `${SQL_DEFAULT_USER_PASSWORD}`
  + Region & Zone: `${CLIENT_REGION_AND_ZONE}`
  + Default Configuration Options
- [x] Create Database Schema
  + Name: `app`
- [x] Create a new username and password which goes into the configuration file
- [x] Create toml File `./credentials/db-conf.toml`

```toml
"DbUser" = "postgres"
"DbPassword" = "docker"
"DbName" = "app"
"DbPort" = "5432"
"DbHost" = "db"
"ListenHost" = "0.0.0.0"
"ListenPort" = "3000"
```


### Step 4 - Enable Cloud Services
- [x] This script enables the following services
  + Container Registry Service
  + Cloud SQL API Service
  + Kubernetes Engine API Service

```bash
gcloud config set project ${GCP_PROJECT_ID}
gcloud services enable containerregistry.googleapis.com
gcloud services enable sqladmin.googleapis.com
gcloud services enable container.googleapis.com
```


### Step 5 - Reserve Static IP address for Frontend User access
- [x] Reserve a Static IP address
  + Name: `${NAME_OF_STATIC_GLOBAL_IP}`
  + Network Service Tier: `Premium`
  + IP version: `IPv4`
  + Type: `Global`
- [x] Create a DNS entry pointing to this Static IP

### Step 6 - Terraform
- [x] Update `variables.tf` file to represent the correct settings for:
  + [x] Cloud project settings
  + [x] Local credential file names
  + [x] Docker image names

- [x] Run the following commands from gcloud shell

```bash
terraform init
terraform plan # double check everything is correct
terraform apply --auto-approve # don't worry about errors here
terraform apply --auto-approve # needs to run twice due to no sequencing of modules
```


### Step 7 - Setup Firewall Rules
- [x] Name: `allow-http`
  + Leave all as default except for these changes
  + Target tags: `http-server`
  + Source IP ranges: `${CLIENT_NETWORK}`
  + Specified protocols and ports:
    + tcp: `80`

Completion status : To Test

Potential improvements: 
Automate CloudSQL and VPC with Terraform
Managed SSL for Https connection
HPA with Terraform
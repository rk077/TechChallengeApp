# Steps to build Kubernetes cluster and deploy TechChallengeApp project to GKEs using Terraform

Modify the variables.tf file in the root directory for changing the values related to cluster and deployments.
main.tf is the main terraform configuration file where gke cluster, app deployment modules are invoked.
This script will deploy the application in create a GKE cluster which has one Node pools  n1-standard-4 


## Note:

- Add the GCP service-account secret file and other four secret files namely  conf.toml,  cloud-sql-sa.json in credentials directory. Make sure their names are consistant with the variable names specified.
- Make necessary changes to the values in variables.tf file according to project specification.

## Steps to Run:

Initialize the terraform config file.
```bash
$terraform init
```

Review the cloud infrastruction which is to be provisioned.
```bash
$terraform plan
```

Run the terraform execution to provision the infrastructure.
```bash
$terraform apply
```

## Verification using kubectl command:

Check the namespace
 $kubectl get namespace

Check the services
 $kubectl get service --namespace=<namespace_name>

Check the secrets
 $kubectl get secret --namespace=<namespace_name>

Check the deployments
 $kubectl get deployments --namespace=<namespace_name>

Check the status of pods running after deployment
 $kubectl get pods --all-namespaces

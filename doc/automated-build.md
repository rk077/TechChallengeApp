## Git Action

For the CICD workflow to work, it depends on few environment variables.
These evironment variables contain sensitive information such as GCP Project, Service account keys, database credentials etc
These environment variables needs to stored as Secrets in the GitHub repo

| Secret Name	| Description |
|---------------|-------------|
| GKE_PROJECT	| Google Cloud Project Name with cloud services enabled |
| GKE_SA_KEY	| A JSON service account key | 


Note: Service Account used for CI-CD deployment should be granted following previleges
 Cloud Build Admin
 Cloud Run Admin

Dependency:
  Cloud Run needs to be configured for the GCP Project

Completion status : To Do

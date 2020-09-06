###############################################################
# Variables
# Note: Edit the values according to the project specifications
###############################################################

variable "username" {
  default = "admin"
}
variable "password" {
  default = "woIn43HhJJk0zXXy"    //Random 16character password to connect to clusters
}
variable "project" {
  default = "servian-todo"
}
variable "cluster" {
  default = "app"
}
variable "region" {
  default = "australia-southeast1"
}
variable "zone" {
  default = "australia-southeast1-a"
}
variable "namespace" {
  default = "dev"
}
variable "min_replica"{
  default = 1
}
variable "max_replica"{
  default = 1
}
variable "default_target_cpu_utilization" {
  default = 80
}
variable "cloud_sql_instance_name" {
  default = "servian-todo:australia-southeast1:app-database"
}


##################################################################
# Service Accounts & Credential Files
##################################################################

variable "sa-deployment" {
  default = "./credentials/deployment-sa.json"
}
variable "sa-cloud-sql" {
  default = "./credentials/cloud-sql-sa.json"
}
variable "app-config" {
  default = "./credentials/db-conf.toml"
}


##################################################################
# app
##################################################################

variable "app_image" {
 default = "asia.gcr.io/servian-todo/app:app-master"
}
variable "app_pool" {
  default = "app-pool"
}
variable "app-listen-port" {
  default = "80"
}
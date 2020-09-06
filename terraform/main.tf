#####################################################################
# Modules
#####################################################################
module "gke" {
  source                = "./gke"
  project               = "${var.project}"
  username              = "${var.username}"
  password              = "${var.password}"
  cluster               = "${var.cluster}"
  sa-deployment         = "${var.sa-deployment}"
  region                = "${var.region}"
  zone                  = "${var.zone}"
  app_pool              = "${var.app_pool}"
}

module "app" {
  source                          = "./app"
  host                            = "${module.gke.host}"
  username                        = "${var.username}"
  password                        = "${var.password}"
  namespace                       = "${var.namespace}"
  app_pool                        = "${var.app_pool}"
  min_replica                     = "${var.min_replica}"
  max_replica                     = "${var.max_replica}"
  app_image                       = "${var.app_image}"
  client_certificate              = "${module.gke.client_certificate}"
  client_key                      = "${module.gke.client_key}"
  cluster_ca_certificate          = "${module.gke.cluster_ca_certificate}"
  default_target_cpu_utilization  = "${var.default_target_cpu_utilization}"
  cloud_sql_instance_name         = "${var.cloud_sql_instance_name}"
  sa-deployment                   = "${var.sa-deployment}"
  sa-cloud-sql                    = "${var.sa-cloud-sql}"
  sequelize-data                  = "${var.sequelize-data}"
  app-config                      = "${var.app-config}"
}

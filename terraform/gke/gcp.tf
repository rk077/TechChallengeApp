provider "google" {
 credentials = "${file(var.sa-deployment)}"
 project     = "${var.project}"
 region      = "${var.region}"
 zone        = "${var.zone}"
}

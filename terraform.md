# terraform

Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently. Configuration files describe to Terraform the components needed to run a single application or your entire datacenter

Features:
 - Infrastructure as code
 - Execution Plans
 - Resource Graph: builds a graph of all your resources, and parallelizes the creation and modification of any non-dependent resources.
 - Change Automation

**Install**

```bash
wget https://releases.hashicorp.com/terraform/0.11.3/terraform_0.11.3_linux_amd64.zip
unzip terraform_0.11.3_linux_amd64.zip
cd /usr/bin
sudo ln -s $PWD/terraform
```

or

```bash
curl -sL https://goo.gl/yZS5XU | bash  
source ${HOME}/.bashrc
```

and create state file:

```bash
BUCKET=${GOOGLE_PROJECT}-terraform
gsutil mb gs://${BUCKET}
PREFIX=tf-es-custom-machine/state

cat > backend.tf <<EOF
terraform {
  backend "gcs" {
    bucket     = "${BUCKET}"
    prefix     = "${PREFIX}"
  }
}
EOF
```

**Initialize**

```
terraform init
```


## Terraform configuration
Terraform uses text files (that end in .tf) to describe infrastructure and to set variables.

Use `terraform show` to inspect the current state
Use `terraform plan` to review the execution plan.
Run `terraform apply` to apply changes.

**Create Google Cloud VM**

```
resource "google_compute_instance" "default" {
  project      = "<PROJECT_ID>"
  name         = "<NAME>"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-9-stretch-v20170816"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }
}
```

**Variables**

```
variable "region" {
  default = "us-central1"
}

variable "zone" {
  description = "GCP Zone"
  default = "us-central1-b"
}
```

## Google Config

**Machine type**
A machine Type specifies a particular collection of virtualized hardware resources available to a virtual machine (VM) instance, including the memory size, virtual CPU count, and maximum persistent disk capability.

There are Predefined machine types (`gcloud compute machine-types list`) and Custom machine types.

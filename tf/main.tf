terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

provider "kubernetes" {}

module "pseudo_service" {
  source = "./modules/pseudo-service"

  release_tag = var.release_tag
}

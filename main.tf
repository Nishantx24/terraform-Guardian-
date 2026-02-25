terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

provider "local" {}

resource "local_file" "test" {
  content  = "Jenkins + Terraform Working!"
  filename = "output.txt"
}

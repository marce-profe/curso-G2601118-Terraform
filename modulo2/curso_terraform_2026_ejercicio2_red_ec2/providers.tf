terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

locals {
  floci = "http://localhost:4566"
}

# Un único provider para las dos opciones:
#   - AWS (usar_floci = false): usa las credenciales de "aws configure".
#   - Floci (usar_floci = true): credenciales de prueba y endpoints locales.
provider "aws" {
  region = var.region

  access_key                  = var.usar_floci ? "test" : null
  secret_key                  = var.usar_floci ? "test" : null
  skip_credentials_validation = var.usar_floci
  skip_requesting_account_id  = var.usar_floci
  skip_metadata_api_check     = var.usar_floci

  endpoints {
    ec2 = var.usar_floci ? local.floci : null
    sts = var.usar_floci ? local.floci : null
    iam = var.usar_floci ? local.floci : null
  }

  # Etiquetas que se añaden a todos los recursos
  default_tags {
    tags = {
      Curso  = "G2601118"
      Modulo = "2"
      Owner  = var.prefijo
    }
  }
}

terraform {
  required_version = "~> 1.12.0"
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.39.0"
    }
  }
}

# Authentication is supplied through CLOUDFLARE_API_TOKEN.
provider "cloudflare" {}

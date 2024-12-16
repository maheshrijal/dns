terraform {
  required_version = "~> 1.9"
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.48.0"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

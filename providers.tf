

terraform {
  required_version = "1.8.5"
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.36.0"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

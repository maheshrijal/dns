terraform {
  backend "s3" {
    bucket                      = "tfstate"
    key                         = "dns/maheshrijal.com.tfstate"
    region                      = "auto"
    endpoints                   = { s3 = "https://5be63f1c67d62926a407c12960d8a087.r2.cloudflarestorage.com" }
    use_lockfile                = true
    use_path_style              = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}

// These records allow cloudflare page rules to work
//
// Redirect all traffic from www.maheshrijal.com to maheshrijal.com

resource "cloudflare_record" "pagerules_ipv4" {
  comment = "www entry to enforce page rule ipv4"
  name    = "www"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = "192.0.2.1"
  zone_id = var.zone_id
}

resource "cloudflare_record" "pagerules_ipv6" {
  comment = "www entry to enforce page rule ipv6"
  name    = "www"
  proxied = true
  ttl     = 1
  type    = "AAAA"
  value   = "100::"
  zone_id = var.zone_id
}

// This record allows me to serve R2 bucket content from my domain
//
// https://developers.cloudflare.com/r2/buckets/public-buckets/#custom-domains

resource "cloudflare_record" "storage_r2bucket" {
  name    = "assets"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = "public.r2.dev"
  zone_id = var.zone_id
}

resource "cloudflare_record" "website_links" {
  name    = "links"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = "maheshrjl-me.pages.dev"
  zone_id = var.zone_id
}

resource "cloudflare_record" "subdomain_pages" {
  name    = "maheshrijal.com"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = "maheshrijal.pages.dev"
  zone_id = var.zone_id
}

resource "cloudflare_record" "subdomain_notes" {
  name    = "notes"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = "notes-90u.pages.dev"
  zone_id = var.zone_id
}

resource "cloudflare_record" "subdomain_offset" {
  name    = "offset"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = "port-offset-calculator.pages.dev"
  zone_id = var.zone_id
}

resource "cloudflare_record" "subdomain_status" {
  comment = "Betteruptime status page"
  name    = "status"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "statuspage.betteruptime.com"
  zone_id = var.zone_id
}

// ZohoMail DNS records
//
// ZohoMail Docs: https://www.zoho.com/mail/help/adminconsole/cloudflare.html

resource "cloudflare_record" "mail_zoho1" {
  name     = "maheshrijal.com"
  priority = 50
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = "mx3.zoho.in"
  zone_id  = var.zone_id
}

resource "cloudflare_record" "mail_zoho2" {
  name     = "maheshrijal.com"
  priority = 20
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = "mx2.zoho.in"
  zone_id  = var.zone_id
}

resource "cloudflare_record" "mail_zoho3" {
  name     = "maheshrijal.com"
  priority = 10
  proxied  = false
  ttl      = 1
  type     = "MX"
  value    = "mx.zoho.in"
  zone_id  = var.zone_id
}

resource "cloudflare_record" "mail_dmarc" {
  name    = "_dmarc"
  proxied = false
  ttl     = 1
  type    = "TXT"
  value   = "v=DMARC1; p=none; rua=mailto:8d1bb48ea66c42e0b40ca19755644ad0@dmarc-reports.cloudflare.net; ruf=mailto:8d1bb48ea66c42e0b40ca19755644ad0@dmarc-reports.cloudflare.net; sp=none; adkim=r; aspf=r; pct=100"
  zone_id = var.zone_id
}

resource "cloudflare_record" "verification_spf" {
  comment = "SPF for Zoho"
  name    = "maheshrijal.com"
  proxied = false
  ttl     = 1
  type    = "TXT"
  value   = "v=spf1 include:zoho.in ~all"
  zone_id = var.zone_id
}

resource "cloudflare_record" "verification_dkim" {
  comment = "DKIM for Zoho"
  name    = "zmail._domainkey"
  proxied = false
  ttl     = 1
  type    = "TXT"
  value   = "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCkzTcB30wYAkbx4bdb4T4yXlXSxPERykGXJegNpq2KlkuRmLCi90E0xR/nclAsxZdwRez/XiGFmH3NmCAZinpqBNYNtyC9/CL7GlZHLld1uvylk89+xmmf1Jk4HPTaGFWdurUMOB2r63KdCRMUJDAXeaQfOEA93yjn63VM9p/kMwIDAQAB"
  zone_id = var.zone_id
}

// TXT verification records
//
// These are used to prove that I own the site.

resource "cloudflare_record" "verification_githubpages" {
  comment = "github pages domain verification"
  name    = "_github-pages-challenge-maheshrijal"
  proxied = false
  ttl     = 1
  type    = "TXT"
  value   = "21a2950b136be73fc6e790f2cc5f3a"
  zone_id = var.zone_id
}

resource "cloudflare_record" "verification_zoho" {
  comment = "zoho domain verification"
  name    = "maheshrijal.com"
  proxied = false
  ttl     = 1
  type    = "TXT"
  value   = "zoho-verification=zb96135528.zmverify.zoho.in"
  zone_id = var.zone_id
}

resource "cloudflare_record" "verification_keybase" {
  comment = "keybase proof"
  name    = "maheshrijal.com"
  proxied = false
  ttl     = 1
  type    = "TXT"
  value   = "keybase-site-verification=mj0GohFjNK5FVmz_yyogO7fAMR_HD1NjvzTNSdibiNQ"
  zone_id = var.zone_id
}

resource "cloudflare_record" "verification_googleconsole" {
  comment = "google search console verification"
  name    = "maheshrijal.com"
  proxied = false
  ttl     = 1
  type    = "TXT"
  value   = "google-site-verification=_6l2UIXO8ulq1jAyvMnbNmAUZNGZtaqk3yA2GbS4PeA"
  zone_id = var.zone_id
}

resource "cloudflare_record" "verification_ahrefs" {
  comment = "ahrefs domain verification"
  name    = "maheshrijal.com"
  proxied = false
  ttl     = 1
  type    = "TXT"
  value   = "ahrefs-site-verification_a1f89ffb3f52da275864a2fa7e442b845082cde2416923c58e6f0e98a2975870"
  zone_id = var.zone_id
}

// CNAME verification records

resource "cloudflare_record" "verification_bing" {
  comment = "bing webmaster verification"
  name    = "705776e69317e67338d46bc8bbfa2563"
  proxied = false
  ttl     = 1
  type    = "CNAME"
  value   = "verify.bing.com"
  zone_id = var.zone_id
}

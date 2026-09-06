# Baseline: live Cloudflare DNS exported 2026-09-06.

resource "cloudflare_record" "apex_cname" {
  zone_id = "b484917a93d845cf80e79fa5c8235d49"
  name    = "mrjl.dev"
  type    = "CNAME"
  content = "mrjl-dev.pages.dev"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "note_cname" {
  zone_id = "b484917a93d845cf80e79fa5c8235d49"
  name    = "note.mrjl.dev"
  type    = "CNAME"
  content = "eab105bd6844b7e6.vercel-dns-017.com"
  ttl     = 1
  proxied = false
}

resource "cloudflare_record" "rebill_cname" {
  zone_id = "b484917a93d845cf80e79fa5c8235d49"
  name    = "rebill.mrjl.dev"
  type    = "CNAME"
  content = "rebill.pages.dev"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "www_cname" {
  zone_id = "b484917a93d845cf80e79fa5c8235d49"
  name    = "www.mrjl.dev"
  type    = "CNAME"
  content = "mrjl-dev.pages.dev"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "apex_mx_10" {
  zone_id  = "b484917a93d845cf80e79fa5c8235d49"
  name     = "mrjl.dev"
  type     = "MX"
  content  = "mx.zoho.in"
  ttl      = 300
  proxied  = false
  priority = 10
  comment  = "Zoho Mail India primary MX"
}

resource "cloudflare_record" "apex_mx_20" {
  zone_id  = "b484917a93d845cf80e79fa5c8235d49"
  name     = "mrjl.dev"
  type     = "MX"
  content  = "mx2.zoho.in"
  ttl      = 300
  proxied  = false
  priority = 20
  comment  = "Zoho Mail India secondary MX"
}

resource "cloudflare_record" "apex_mx_50" {
  zone_id  = "b484917a93d845cf80e79fa5c8235d49"
  name     = "mrjl.dev"
  type     = "MX"
  content  = "mx3.zoho.in"
  ttl      = 300
  proxied  = false
  priority = 50
  comment  = "Zoho Mail India tertiary MX"
}

resource "cloudflare_record" "_aws_securityagent_challenge_txt_aws_security_agent" {
  zone_id = "b484917a93d845cf80e79fa5c8235d49"
  name    = "_aws_securityagent-challenge.mrjl.dev"
  type    = "TXT"
  content = "\"aws-securityagent-domain-verification=Pb-8Vs7l429XIa8HUfxceA\""
  ttl     = 1
  proxied = false
  comment = "AWS Security Agent"
}

resource "cloudflare_record" "_dmarc_txt_v" {
  zone_id = "b484917a93d845cf80e79fa5c8235d49"
  name    = "_dmarc.mrjl.dev"
  type    = "TXT"
  content = "\"v=DMARC1; p=none; rua=mailto:c2d24838eada439ea29bb4dfd448744c@dmarc-reports.cloudflare.net\""
  ttl     = 1
  proxied = false
}

resource "cloudflare_record" "_github_pages_challenge_maheshrijal_txt_github_pages_verification" {
  zone_id = "b484917a93d845cf80e79fa5c8235d49"
  name    = "_github-pages-challenge-maheshrijal.mrjl.dev"
  type    = "TXT"
  content = "\"40a2f4e66a582e16649679e5d575e8\""
  ttl     = 1
  proxied = false
  comment = "GitHub Pages Verification"
}

resource "cloudflare_record" "apex_txt_ahrefs_site_verification_d93fa01f3a41b7e18ab520d57ffe495e2be7d81fc55ef4c0a0ab0f67493a4d4b" {
  zone_id = "b484917a93d845cf80e79fa5c8235d49"
  name    = "mrjl.dev"
  type    = "TXT"
  content = "\"ahrefs-site-verification_d93fa01f3a41b7e18ab520d57ffe495e2be7d81fc55ef4c0a0ab0f67493a4d4b\""
  ttl     = 1
  proxied = false
}

resource "cloudflare_record" "apex_txt_zoho_domain_ownership_verification" {
  zone_id = "b484917a93d845cf80e79fa5c8235d49"
  name    = "mrjl.dev"
  type    = "TXT"
  content = "\"zoho-verification=zb93979214.zmverify.zoho.in\""
  ttl     = 1
  proxied = false
  comment = "Zoho domain ownership verification"
}

resource "cloudflare_record" "apex_txt_zoho_mail_spf" {
  zone_id = "b484917a93d845cf80e79fa5c8235d49"
  name    = "mrjl.dev"
  type    = "TXT"
  content = "v=spf1 include:zohomail.in ~all"
  ttl     = 300
  proxied = false
  comment = "Zoho Mail SPF"
}

resource "cloudflare_record" "zoho20260724__domainkey_txt_zoho_mail_dkim_selector_rotated_2026_07_24" {
  zone_id = "b484917a93d845cf80e79fa5c8235d49"
  name    = "zoho20260724._domainkey.mrjl.dev"
  type    = "TXT"
  content = "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAsG8/SgQX2DP2LqMIz992fkc+so7ig0Qr8KquH44UsdJGYgWYpv/QIhzWXn6LwenzVNiC6JX1ege1gY2HuRw2cCco2EUdNfIIwT0Ay2rc0UzcWDF3zBttGo1tPUB8CxSP4rwVciOpK5qZKHZuCCANcO0/Kvg55ysBOZcIjwcJVAwNxhfmsSWmegsOHjhym3HynJCOC5SS44aYUExuudhFUgwJiDwA/MEBh3+Wil6VnImWIIRmq1i7AbgKAyLBgkUZlX9Mr/clXzmH4Y5R362JTjetxpOIMvZyMSHWVxWRQcrojcq4MGGHapSSTtJHebB9JvQJL21ovaHZu7zha5CbewIDAQAB"
  ttl     = 300
  proxied = false
  comment = "Zoho Mail DKIM selector rotated 2026-07-24"
}

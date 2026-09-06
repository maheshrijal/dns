# Baseline: live Cloudflare DNS exported 2026-09-06.

resource "cloudflare_record" "pagerules_ipv4" {
  zone_id = "03f37a2522994f16b230c5f6c3f5f95c"
  name    = "www.maheshrijal.com"
  type    = "A"
  content = "192.0.2.1"
  ttl     = 1
  proxied = true
  comment = "www entry to enforce page rule ipv4"
}

resource "cloudflare_record" "pagerules_ipv6" {
  zone_id = "03f37a2522994f16b230c5f6c3f5f95c"
  name    = "www.maheshrijal.com"
  type    = "AAAA"
  content = "100::"
  ttl     = 1
  proxied = true
  comment = "www entry to enforce page rule ipv6"
}

resource "cloudflare_record" "verification_bing" {
  zone_id = "03f37a2522994f16b230c5f6c3f5f95c"
  name    = "705776e69317e67338d46bc8bbfa2563.maheshrijal.com"
  type    = "CNAME"
  content = "verify.bing.com"
  ttl     = 1
  proxied = false
  comment = "bing webmaster verification"
}

resource "cloudflare_record" "links_cname" {
  zone_id = "03f37a2522994f16b230c5f6c3f5f95c"
  name    = "links.maheshrijal.com"
  type    = "CNAME"
  content = "maheshrijal-links.pages.dev"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "subdomain_pages" {
  zone_id = "03f37a2522994f16b230c5f6c3f5f95c"
  name    = "maheshrijal.com"
  type    = "CNAME"
  content = "maheshrijal.pages.dev"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "subdomain_notes" {
  zone_id = "03f37a2522994f16b230c5f6c3f5f95c"
  name    = "notes.maheshrijal.com"
  type    = "CNAME"
  content = "notes-90u.pages.dev"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "subdomain_status" {
  zone_id = "03f37a2522994f16b230c5f6c3f5f95c"
  name    = "status.maheshrijal.com"
  type    = "CNAME"
  content = "statuspage.betteruptime.com"
  ttl     = 1
  proxied = false
  comment = "Betteruptime status page"
}

resource "cloudflare_record" "tools_cname" {
  zone_id = "03f37a2522994f16b230c5f6c3f5f95c"
  name    = "tools.maheshrijal.com"
  type    = "CNAME"
  content = "tools-8ou.pages.dev"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "mail_zoho3" {
  zone_id  = "03f37a2522994f16b230c5f6c3f5f95c"
  name     = "maheshrijal.com"
  type     = "MX"
  content  = "mx.zoho.in"
  ttl      = 300
  proxied  = false
  priority = 10
  comment  = "Zoho Mail India primary MX"
}

resource "cloudflare_record" "mail_zoho2" {
  zone_id  = "03f37a2522994f16b230c5f6c3f5f95c"
  name     = "maheshrijal.com"
  type     = "MX"
  content  = "mx2.zoho.in"
  ttl      = 300
  proxied  = false
  priority = 20
  comment  = "Zoho Mail India secondary MX"
}

resource "cloudflare_record" "mail_zoho1" {
  zone_id  = "03f37a2522994f16b230c5f6c3f5f95c"
  name     = "maheshrijal.com"
  type     = "MX"
  content  = "mx3.zoho.in"
  ttl      = 300
  proxied  = false
  priority = 50
  comment  = "Zoho Mail India tertiary MX"
}

resource "cloudflare_record" "_atproto_txt_bluesky_username" {
  zone_id = "03f37a2522994f16b230c5f6c3f5f95c"
  name    = "_atproto.maheshrijal.com"
  type    = "TXT"
  content = "\"did=did:plc:bxkyh4wgcluwvuxxzzcuvrlx\""
  ttl     = 1
  proxied = false
  comment = "bluesky-username"
}

resource "cloudflare_record" "_aws_securityagent_challenge_txt_aws_security_agent" {
  zone_id = "03f37a2522994f16b230c5f6c3f5f95c"
  name    = "_aws_securityagent-challenge.maheshrijal.com"
  type    = "TXT"
  content = "\"aws-securityagent-domain-verification=NiInjrMXeg6Y0tpf4e55bw\""
  ttl     = 1
  proxied = false
  comment = "AWS Security Agent"
}

resource "cloudflare_record" "_discord_txt_discord_domain_verification" {
  zone_id = "03f37a2522994f16b230c5f6c3f5f95c"
  name    = "_discord.maheshrijal.com"
  type    = "TXT"
  content = "\"dh=a8f5926afb00a5dd3412632afd337b463ac85b30\""
  ttl     = 1
  proxied = false
  comment = "discord domain verification"
}

resource "cloudflare_record" "_dmarc_txt_v" {
  zone_id = "03f37a2522994f16b230c5f6c3f5f95c"
  name    = "_dmarc.maheshrijal.com"
  type    = "TXT"
  content = "\"v=DMARC1; p=none; rua=mailto:8d1bb48ea66c42e0b40ca19755644ad0@dmarc-reports.cloudflare.net\""
  ttl     = 1
  proxied = false
}

resource "cloudflare_record" "verification_githubpages" {
  zone_id = "03f37a2522994f16b230c5f6c3f5f95c"
  name    = "_github-pages-challenge-maheshrijal.maheshrijal.com"
  type    = "TXT"
  content = "\"21a2950b136be73fc6e790f2cc5f3a\""
  ttl     = 1
  proxied = false
  comment = "github pages domain verification"
}

resource "cloudflare_record" "links_txt_ahrefs_for_links_maheshrijal_com" {
  zone_id = "03f37a2522994f16b230c5f6c3f5f95c"
  name    = "links.maheshrijal.com"
  type    = "TXT"
  content = "\"ahrefs-site-verification_2221639f1fadfbc31a3bd9414cb631211aa496e3303505eab795975c9ca8078a\""
  ttl     = 1
  proxied = false
  comment = "AhRefs for links.maheshrijal.com"
}

resource "cloudflare_record" "verification_ahrefs" {
  zone_id = "03f37a2522994f16b230c5f6c3f5f95c"
  name    = "maheshrijal.com"
  type    = "TXT"
  content = "\"ahrefs-site-verification_a1f89ffb3f52da275864a2fa7e442b845082cde2416923c58e6f0e98a2975870\""
  ttl     = 1
  proxied = false
  comment = "ahrefs domain verification"
}

resource "cloudflare_record" "apex_txt_keyoxide_proof" {
  zone_id = "03f37a2522994f16b230c5f6c3f5f95c"
  name    = "maheshrijal.com"
  type    = "TXT"
  content = "\"aspe:keyoxide.org:5OZWXIVGVO5G7OAH2NIYLFDWCA\""
  ttl     = 1
  proxied = false
  comment = "KeyOxide Proof"
}

resource "cloudflare_record" "apex_txt_dub_partners_verification_record" {
  zone_id = "03f37a2522994f16b230c5f6c3f5f95c"
  name    = "maheshrijal.com"
  type    = "TXT"
  content = "\"dub-domain-verification=5cd683e6-761d-4b48-abd6-e44aae770ae9\""
  ttl     = 1
  proxied = false
  comment = "DUB Partners Verification Record"
}

resource "cloudflare_record" "verification_keybase" {
  zone_id = "03f37a2522994f16b230c5f6c3f5f95c"
  name    = "maheshrijal.com"
  type    = "TXT"
  content = "\"keybase-site-verification=mj0GohFjNK5FVmz_yyogO7fAMR_HD1NjvzTNSdibiNQ\""
  ttl     = 1
  proxied = false
  comment = "keybase proof"
}

resource "cloudflare_record" "verification_zoho" {
  zone_id = "03f37a2522994f16b230c5f6c3f5f95c"
  name    = "maheshrijal.com"
  type    = "TXT"
  content = "\"zoho-verification=zb96135528.zmverify.zoho.in\""
  ttl     = 1
  proxied = false
  comment = "zoho domain verification"
}

resource "cloudflare_record" "apex_txt_zoho_mail_spf" {
  zone_id = "03f37a2522994f16b230c5f6c3f5f95c"
  name    = "maheshrijal.com"
  type    = "TXT"
  content = "v=spf1 include:zohomail.in ~all"
  ttl     = 300
  proxied = false
  comment = "Zoho Mail SPF"
}

resource "cloudflare_record" "notes_txt_ahrefs_for_notes_maheshrijal_com" {
  zone_id = "03f37a2522994f16b230c5f6c3f5f95c"
  name    = "notes.maheshrijal.com"
  type    = "TXT"
  content = "\"ahrefs-site-verification_2221639f1fadfbc31a3bd9414cb631211aa496e3303505eab795975c9ca8078a\""
  ttl     = 1
  proxied = false
  comment = "Ahrefs for notes.maheshrijal.com"
}

resource "cloudflare_record" "zoho20260724__domainkey_txt_zoho_mail_dkim_selector_rotated_2026_07_24" {
  zone_id = "03f37a2522994f16b230c5f6c3f5f95c"
  name    = "zoho20260724._domainkey.maheshrijal.com"
  type    = "TXT"
  content = "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAu+8fmHxVNzpkx1cGXj8gk7sGeNTREuLZc13vqYLw6Gh7uR2MX8JT8ookaBmHduo0fKxfdBRI5Js/SMyGesqjViuawOWLYbUv8D1OdUTWcU3Pt44vhSi3F8kR6ZBpBoEOPKuMbOsJoEbe2jEXNzQKPkWstjXcfe3ZFRvoz9zT2Dw0MYHzVRGBwd+6ZlPFSnttIaG1XfoSvnj0bFHx/HsZAlcPDZM53BOY9Kd0Bos47JrHrFCSnogC8duS2WXXuKyiYBcz1ZU5KJWHAG8E8guwicUOBXXDhzDlUmmxU7IlEq8czqIDk1kGMEx1EsmUjSd/Ff06UMc5xV1l/VG6Vda5nwIDAQAB"
  ttl     = 300
  proxied = false
  comment = "Zoho Mail DKIM selector rotated 2026-07-24"
}

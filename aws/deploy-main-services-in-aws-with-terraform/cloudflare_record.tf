resource "cloudflare_record" "samplebucketone_enterprise_com" {
  # Cloudflare Zone ID
  zone_id = "xxxxxxxxxxxxxxxxxxxxxxxxxx"
  name    = "samplebucketone"
  value   = aws_s3_bucket.smaplebucketone_enterprise_com.bucket_domain_name
  type    = "CNAME"
  ttl     = 1
  proxied = "true"
}

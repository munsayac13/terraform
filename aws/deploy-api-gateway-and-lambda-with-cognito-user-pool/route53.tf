resource "aws_route53_record" "custom_domain_record" {
  name = "api" # The subdomain (api.cmenterprise.com)
  type = "CNAME"
  ttl = "300" # TTL in seconds

  records = ["${aws_api_gateway_rest_api.mylocalone_api.id}.execute-api.us-east-1.amazonaws.com"]

  zone_id = data.aws_route53_zone.mylocalone_domain.zone_id
}

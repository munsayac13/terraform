resource "aws_acm_certificate" "mylocalone_api_cert" {
  domain_name = "api.cmenterprise.com"
  provider = aws.aws_useast1
  subject_alternative_names = [ "api.cmenterprise.com" ]
  validation_method = "DNS"
}

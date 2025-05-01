# AWS Certificate Manager
module "acm_backend" {
  source      = "terraform-aws-modules/acm/aws"
  version     = "4.0.1"
  domain_name = "cmenterprise.com"
  subject_alternative_names = [
    "*.cmenterprise.com"
  ]
  zone_id = data.aws_route53_zone.mylocalone_domain.id
  validation_method = "DNS"
  wait_for_validation = true
  tags = {
    Name = "${local.project}-${local.env}-backend-validation"
  }
}

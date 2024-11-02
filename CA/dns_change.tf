provider "aws" {
  region = "us-east-1"

resource "aws_route53_zone" "my_zone" {
  name = "itay-noa.online"
}

# Fetch the existing load balancer
data "aws_lb" "my_load_balancer" {
  name = "alb-ingress-noa-itay-dev"  
}

resource "aws_route53_record" "cname_statuspage" {
  zone_id = aws_route53_zone.my_zone.zone_id
  name     = "statuspage.itay-noa.online"
  type     = "CNAME"
  ttl      = 300
  records  = [data.aws_lb.my_load_balancer.dns_name]  
}

resource "aws_route53_record" "cname_grafana" {
  zone_id = aws_route53_zone.my_zone.zone_id
  name     = "grafana.itay-noa.online"
  type     = "CNAME"
  ttl      = 300
  records  = [data.aws_lb.my_load_balancer.dns_name]  
}

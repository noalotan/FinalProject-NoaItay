provider "aws" {
  region = "us-east-1"  
}

resource "aws_route53_zone" "my_zone" {
  name = "itay-noa.online"
}

resource "aws_route53_record" "cname_statuspage" {
  zone_id = aws_route53_zone.my_zone.zone_id
  name     = "statuspage.itay-noa.online"
  type     = "CNAME"
  ttl      = 300
  records  = ["your-load-balancer-dns.amazonaws.com"]  # Replace with your load balancer DNS
}

resource "aws_route53_record" "cname_grafana" {
  zone_id = aws_route53_zone.my_zone.zone_id
  name     = "grafana.itay-noa.online"
  type     = "CNAME"
  ttl      = 300
  records  = ["your-grafana-load-balancer-dns.amazonaws.com"]  # Replace with your Grafana load balancer DNS
}

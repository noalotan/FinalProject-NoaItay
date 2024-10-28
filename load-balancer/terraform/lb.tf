provider "aws" {
  region = "us-west-1"
}

resource "aws_security_group" "lb_sg" {
  name        = "app-load-balancer-sg"
  description = "Security group for the application load balancer"
  vpc_id      = "vpc-01069a335615ca3e2"  # Your actual VPC ID

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all IPs for HTTP traffic
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "app_lb" {
  name               = "app-load-balancer"
  internal           = false
  load_balancer_type = "application"

  security_groups = [aws_security_group.lb_sg.id]
  subnets        = [
    "subnet-0843c8d7bd8f1f063",
    "subnet-0cb8ffdcc5ade255a",
    "subnet-015796b3041bd37e8"  # Your third subnet ID
  ]

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "nginx_tg" {
  name     = "nginx-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-01069a335615ca3e2"  # Your actual VPC ID

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold  = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group" "django_tg" {
  name     = "django-target-group"
  port     = 8000
  protocol = "HTTP"
  vpc_id   = "vpc-01069a335615ca3e2"  # Your actual VPC ID

  health_check {
    path                = "/health"  # Update according to your Django app
    interval            = 30
    timeout             = 5
    healthy_threshold  = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx_tg.arn
  }
}

resource "aws_lb_listener_rule" "django_rule" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100  # Adjust priority as needed

  conditions {
    field  = "path-pattern"
    values = ["/api/*"]  # Adjust path for your Django app
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.django_tg.arn
  }
}

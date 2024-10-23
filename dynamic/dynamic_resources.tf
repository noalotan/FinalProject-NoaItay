data "terraform_remote_state" "static" {
  backend = "local"
  config = {
    path = "/var/lib/jenkins/workspace/terraform-static-workspace/terraform.tfstate"
  }
}




resource "aws_some_resource" "example" {
  vpc_id = data.terraform_remote_state.static.outputs.vpc_id
  public_subnets = data.terraform_remote_state.static.outputs.public_subnets
  private_subnets = data.terraform_remote_state.static.outputs.private_subnets
}




resource "aws_some_other_resource" "example_db" {
  db_subnet_group_name = data.terraform_remote_state.static.outputs.db_subnet_group_name
  db_instance_identifier = data.terraform_remote_state.static.outputs.db_instance_identifier
  db_instance_endpoint = data.terraform_remote_state.static.outputs.db_instance_endpoint
  db_instance_arn = data.terraform_remote_state.static.outputs.db_instance_arn
}




resource "aws_security_group_rule" "elasticache_access" {
  security_group_id = data.terraform_remote_state.static.outputs.elasticache_security_group_id
  type              = "ingress"
  from_port        = 6379
  to_port          = 6379
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]  # Adjust as needed
}




resource "aws_security_group_rule" "rds_access" {
  security_group_id = data.terraform_remote_state.static.outputs.rds_security_group_id
  type              = "ingress"
  from_port        = 5432
  to_port          = 5432
  protocol         = "tcp"
  cidr_blocks      = ["0.0.0.0/0"]  # Adjust as needed
}

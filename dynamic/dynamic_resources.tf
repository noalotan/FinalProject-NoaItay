data "terraform_remote_state" "static" {
  backend = "local"
  config = {
    path = "/var/lib/jenkins/workspace/terraform-static-workspace/terraform.tfstate"
  }
}

resource "aws_some_resource" "example" {
  vpc_id = data.terraform_remote_state.static.outputs.vpc_id
}

resource "aws_db_subnet_group" "mydb_subnet_group" {
  name       = var.db_subnet_group_name
  subnet_ids = var.private_subnets
}

resource "aws_db_instance" "mydb" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "16.3"
  instance_class       = "db.t4g.micro"
  identifier           = var.db_name
  username             = var.db_user
  password             = var.db_password
  parameter_group_name = "default.postgres16"
  db_subnet_group_name = aws_db_subnet_group.mydb_subnet_group.name
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  tags                 = local.billing_tags
}

resource "null_resource" "init_statuspage_db" {
  depends_on = [aws_db_instance.mydb]

  provisioner "local-exec" {
    command = <<EOT
    PGPASSWORD=${var.db_password} psql -h ${aws_db_instance.mydb.address} -U ${var.db_user} -d postgres -c "CREATE DATABASE statuspage;"
    EOT
  }
}

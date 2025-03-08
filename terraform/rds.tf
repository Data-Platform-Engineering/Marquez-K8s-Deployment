resource "random_password" "password" {
  length = 24
  special = false
}


resource "aws_ssm_parameter" "marquez_db_password" {
  name = "/production/marquez/rds/password"
  type = "String"
  value = random_password.password.result
}


data "aws_ssm_parameter" "marquez_db_username" {
  name = "/production/marquez/rds/username"
}


resource "aws_db_instance" "marquez_db" {
  allocated_storage = 10
  identifier = "marquez-backend-metadata"
  db_name = "marquez"
  engine = "postgres"
  engine_version = "16"
  instance_class = "db.t3.micro"
  username = data.aws_ssm_parameter.marquez_db_username.value
  password = aws_ssm_parameter.marquez_db_password.value
  skip_final_snapshot = true
  publicly_accessible = true
}

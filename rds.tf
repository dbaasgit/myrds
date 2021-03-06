provider "aws" {
   region     = "us-east-2"
}

resource "aws_db_instance" "rds_create" {
  identifier = "mysql-test-jenkins"
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "admin"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql5.7"
  vpc_security_group_ids = ["sg-0e7dbd515403acadf"]
}
terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "terra-backend-bkt"
    key            = "global/s3/v3/terraform.tfstate"
    region         = "us-east-2"
    # Replace this with your DynamoDB table name!
    dynamodb_table = "terraform-lock-db-test"
    encrypt        = true
  }

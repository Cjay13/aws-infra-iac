module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "ecomdb"

  engine            = "mysql"
  engine_version    = "5.7"
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  db_name  = "ecomdb"
  username = "cjay"
  port     = "3306"
  password = var.dbPassowrd

  vpc_security_group_ids = [module.rds_sg.security_group_id]

  # Enhanced Monitoring - see example for details on how to create the role
  # by yourself, in case you don't want to create it automatically
  monitoring_interval    = "60"
  monitoring_role_name   = "MyRDSMonitoringRole"
  create_monitoring_role = true

  tags = {
    Project : "cjay-ecom"
  }

  # DB subnet group
  db_subnet_group_name = module.vpc.database_subnet_group
  multi_az             = false

  # DB parameter group
  family = "mysql5.7"

  # DB option group
  major_engine_version = "5.7"


  # Database Deletion Protection
  deletion_protection = false

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]

}
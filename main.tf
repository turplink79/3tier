# resource "aws_instance" "turplinkgroups_EC2" {
#  count          = 2
#   ami           = "ami-04e5276ebb8451442"
#   instance_type = "t2.micro"


# tags = {
# Name = "TurplinkServer"
#  }
# }

# # resource "aws_db_instance" "default" {
# #   allocated_storage    = 10
# #   db_name              = "turplinkgroup"
# #   engine               = "mysql"
# #   engine_version       = "5.7"
# #   instance_class       = "db.t3.micro"
# #   username             = "foo"
# #   password             = "foobarbaz"
# #   parameter_group_name = "default.mysql5.7"
# #   skip_final_snapshot  = true
# # }

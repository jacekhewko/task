# # DynamoDB table for locking teffarofm statefiles
# resource "aws_dynamodb_table" "terraform-state-lock" {
#   name = "terraform-state-lock-dynamo"
#   hash_key = "LockID"
#   read_capacity = 20
#   write_capacity = 20
 
#   attribute {
#     name = "LockID"
#     type = "S"
#   }
 
#   tags = {
#     Terraform = "true"
#     Name = "dynamodb-terraform-state-lock"
#     Project = "opencheckout"
#     Environment = "prod"
#   }
# }

# # S3 Bucket for statefiles
# resource "aws_s3_bucket" "state" {
#   bucket = "jacekh-ireland-statefiles"
#   acl    = "private"

#   tags = {
#     Name        = "jacekh-ireland-statefiles"
#   }
#   versioning {
#     enabled = true
#   }
# }
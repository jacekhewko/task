# IAM Roles and Policies
resource "aws_iam_role" "ecs" {
  name               = "ecs"
  assume_role_policy = "${file("${path.module}/iam/assume-role.json")}"
}

resource "aws_iam_instance_profile" "ecs" {
  name = "ecs_profile"
  role = "${aws_iam_role.ecs.name}"
}

resource "aws_iam_role_policy" "ecs" {
  name   = "ecs_instance_role"
  role   = "${aws_iam_role.ecs.id}"
  policy = "${file("${path.module}/iam/ec2-ecs-policy.json")}"
}

resource "aws_iam_policy_attachment" "ecs_service_role" {
  name       = "ecs_service_role"
  roles      = ["${aws_iam_role.ecs.name}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}

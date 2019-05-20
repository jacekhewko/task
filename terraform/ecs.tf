# ECR Repo
resource "aws_ecr_repository" "repo" {
  name = "sentry_ecr"
}

# ECS Cluster
resource "aws_ecs_cluster" "main" {
  name = "app"

tags {
    Name = "Test ECS"
  }
}

# Task definition json
data "template_file" "app" {
  template = "${file("templates/app.json")}"
  vars {
    repository_url = "${aws_ecr_repository.repo.repository_url}"
    app_version = "${var.app_version}"
  }
}

## Task definition
resource "aws_ecs_task_definition" "app" {
  family                   = "app-task"
#   execution_role_arn       = "${var.ecs_task_execution_role}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "1"
  memory                   = "1"
  container_definitions    = "${data.template_file.definition.rendered}"
}

# ECS Service
resource "aws_ecs_service" "app" {
  name            = "app"
  count           = "${var.ecs_service_count}"
  cluster         = "${aws_ecs_cluster.main.id}"
  task_definition = "${aws_ecs_task_definition.task_app_def.arn}"
  desired_count   = "1"
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = ["${aws_security_group.jenkins.id}"]
    subnets          = ["${aws_subnet.main.id}"]
    assign_public_ip = true
  }

#   load_balancer {
#     target_group_arn = "${aws_alb_target_group.tg_app.id}"
#     container_name   = "app"
#     container_port   = "${var.app_port}"
#   }
  
#  depends_on = [
#     "aws_alb_listener.https_alb_listener",

#   ]
}

# Logs
resource "aws_cloudwatch_log_group" "app_log_group" {
  name              = "/ecs/app"
  retention_in_days = 30

  tags {
    Name = "app-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "app_log_stream" {
  name           = "app-log-stream"
  log_group_name = "${aws_cloudwatch_log_group.app_log_group.name}"
}
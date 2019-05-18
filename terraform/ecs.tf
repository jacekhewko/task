# ECR Repo
resource "aws_ecr_repository" "repo" {
  name = "sentry_ecr"
}

# ECS Cluster
resource "aws_ecs_cluster" "main" {
  name = "ghost"

tags {
    Name = "Test ECS"
  }
}

# Task definition json
data "template_file" "definition" {
  template = "${file("templates/app.json")}"

}

## Task definition
resource "aws_ecs_task_definition" "task_ghost_def" {
  family                   = "ghost-task"
#   execution_role_arn       = "${var.ecs_task_execution_role}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "1"
  memory                   = "1"
  container_definitions    = "${data.template_file.definition.rendered}"
}

# ECS Service
resource "aws_ecs_service" "service_ghost" {
  name            = "ghost"
  cluster         = "${aws_ecs_cluster.main.id}"
  task_definition = "${aws_ecs_task_definition.task_ghost_def.arn}"
  desired_count   = "1"
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = ["${aws_security_group.jenkins.id}"]
    subnets          = ["${aws_subnet.main.id}"]
    assign_public_ip = true
  }

#   load_balancer {
#     target_group_arn = "${aws_alb_target_group.tg_ghost.id}"
#     container_name   = "ghost"
#     container_port   = "${var.ghost_port}"
#   }
  
#  depends_on = [
#     "aws_alb_listener.https_alb_listener",

#   ]
}

# Logs
resource "aws_cloudwatch_log_group" "ghost_log_group" {
  name              = "/ecs/ghost"
  retention_in_days = 30

  tags {
    Name = "ghost-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "ghost_log_stream" {
  name           = "ghost-log-stream"
  log_group_name = "${aws_cloudwatch_log_group.ghost_log_group.name}"
}
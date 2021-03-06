output "Jenkins Master address" {
  value = ["http://${aws_instance.jenkins_master.public_ip}:8080"]
}

output "Sentry App address after Jenkins job deployment" {
  value = ["http://${aws_instance.jenkins_slave.public_ip}:9000"]
}

output "Jenkins Slave General Builds IP" {
  value = ["${aws_instance.jenkins_slave.public_ip}"]
}

output "Jenkins Slave Specialized Builder IP" {
  value = ["${aws_instance.jenkins_slave2.public_ip}"]
}
# Defining AMIs created by Packer earlier on
data "aws_ami" "jenkins-master" {
  most_recent = true
  owners      = ["self"]
  filter {
    name   = "name"
    values = ["jenkins-master-ami"]
  }
}
data "aws_ami" "jenkins-slave" {
  most_recent = true
  owners      = ["self"]
  filter {
    name   = "name"
    values = ["jenkins-slave-ami"]
  }
}

# Defining key pair for EC2 instances
resource "aws_key_pair" "tooploox" {
  key_name   = "tooploox"
  public_key = "${file("${path.module}/keys/key.pub")}"
}

# Jenkins master node
resource "aws_instance" "jenkins_master" {
  ami                    = "${data.aws_ami.jenkins-master.id}"
  instance_type          = "${var.jenkins_master_instance_type}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.jenkins.id}"]
  subnet_id              = "${aws_subnet.main.id}"
  user_data = "${file("${path.module}/userdata/jenkins-master.tpl")}"
  associate_public_ip_address = true

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 30
    delete_on_termination = false
  }
  tags {
    Name   = "jenkins_master"
    Tool   = "Terraform"
  }
}

# Slave "general builds"
resource "aws_instance" "jenkins_slave" {
  ami                    = "${data.aws_ami.jenkins-slave.id}"
  instance_type          = "${var.jenkins_slave1_instance_type}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.jenkins.id}"]
  subnet_id              = "${aws_subnet.main.id}"
  user_data = "${data.template_file.user_data_slave.rendered}"
  associate_public_ip_address = true
  depends_on = ["aws_instance.jenkins_master"]

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 30
    delete_on_termination = false
  }
  tags {
    Name   = "Slave general builds"
    Tool   = "Terraform"
  }
}

data "template_file" "user_data_slave" {
  template = "${file("${path.module}/userdata/jenkins-slave.tpl")}"
  vars {
    jenkins_url = "${aws_instance.jenkins_master.private_ip}"
  }
}

# Slave "specialized builder"
resource "aws_instance" "jenkins_slave2" {
  ami                    = "${data.aws_ami.jenkins-slave.id}"
  instance_type          = "${var.jenkins_slave2_instance_type}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.jenkins.id}"]
  subnet_id              = "${aws_subnet.main.id}"
  user_data = "${data.template_file.user_data_slave2.rendered}"
  associate_public_ip_address = true
  depends_on = ["aws_instance.jenkins_slave"]

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 8
    delete_on_termination = false
  }
  tags {
    Name   = "Slave specialized builder"
    Tool   = "Terraform"
  }
}

data "template_file" "user_data_slave2" {
  template = "${file("${path.module}/userdata/jenkins-slave2.tpl")}"
  vars {
    jenkins_url = "${aws_instance.jenkins_master.private_ip}"
  }
}
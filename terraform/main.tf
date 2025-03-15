resource "aws_security_group" "ssh_sg" {
  name        = "ssh_allow_my_ip"
  description = "SSH access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_address]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "zookeeper_customer_sg" {
  name        = "zookeeper_allow_my_ip"
  description = "Zookeeper access"


  ingress {
    from_port   = 2181
    to_port     = 2181
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_address]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "kafka_customer_sg" {
  name        = "kafka_allow_my_ip"
  description = "Kafka access"


  ingress {
    from_port   = 9092
    to_port     = 9092
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_address]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "kafka" {
  ami             = var.instance_ami
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.ssh_sg.name, aws_security_group.zookeeper_customer_sg.name, aws_security_group.kafka_customer_sg.name]
  key_name        = var.kafka_key_name
  tags = {
    Name = "kafka-security"
  }

  depends_on = [aws_security_group.kafka_customer_sg, aws_security_group.ssh_sg, aws_security_group.zookeeper_customer_sg]
}

resource "aws_eip" "kafka_eip" {
  instance = aws_instance.kafka.id
  tags = {
    Name = "eip-kafka-security"
  }
}

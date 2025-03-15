variable "my_ip_address" {
  type = string
}

variable "instance_ami" {
  type = string
  default = "ami-04d88e4b4e0a5db46"
}

variable "kafka_key_name" {
  type = string
  default = "kafka-security"
}
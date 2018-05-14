resource "aws_instance" "jumphost" {
  ami           = "ami-9cbe9be5"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.public.id}"
  key_name = "TrainingKPIreland"
  vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]

  tags {
    Name = "dev"
  }
}

resource "aws_eip" "jumphost" {
  instance = "${aws_instance.jumphost.id}"
  vpc = true
}

resource "aws_instance" "jumpee" {
  ami           = "ami-9cbe9be5"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.private.id}"
  key_name = "TrainingKPIreland"
  vpc_security_group_ids = ["${aws_security_group.allow_public.id}"]


}

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id = "${aws_vpc.vpc.id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "dev"
  }
}

resource "aws_security_group" "allow_public" {
  name        = "allow_public"
  description = "Allow ssh from public subnet"
  vpc_id = "${aws_vpc.vpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.subnet1_cidr}"]
  }

 egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "dev"
  }
}

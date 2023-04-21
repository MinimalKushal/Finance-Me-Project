provider "aws" {
  region = "ap-south-1"
  access_key = "my-access-key"
  secret_key = "my-secret-access-key"
}

resource "aws_instance" "Finance-Me-Deploy" {
  ami           = "ami-07d3a50bd29811cd1" 
  instance_type = "t2.micro" 
  key_name = "Kushal"
  vpc_security_group_ids= ["sg-0906b8b9eb805dc82"]
  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("Kushal.pem")
    host     = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [ "echo 'wait to start instance' "]
  }
  tags = {
    Name = "Finance Me Deploy"
  }
  provisioner "local-exec" {
        command = " echo ${aws_instance.Finance-Me-Deploy.public_ip} >> inventory.txt "
  }
   provisioner "local-exec" {
  command = "ansible-playbook /var/lib/jenkins/workspace/FinanceMeProject/Playbook.yml "
  } 
}

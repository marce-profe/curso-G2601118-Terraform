# PASO 4 · La AMI (ya resuelto)
# Imagen de Ubuntu 24.04 publicada por Canonical. Solo se busca si no indicas ami_id.
data "aws_ami" "ubuntu" {
  count       = var.ami_id == null ? 1 : 0
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

locals {
  ami = coalesce(var.ami_id, one(data.aws_ami.ubuntu[*].id))
}

# PASO 5 · Servidor web (complétalo)
# Documentación:
#   https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
resource "aws_instance" "web" {
  ami                         = local.ami                   # local.ami
  instance_type               = var.tipo_instancia          # variable tipo_instancia
  subnet_id                   = aws_subnet.publica.id       # la subred pública
  vpc_security_group_ids      = [aws_security_group.web.id] # lista con el grupo de seguridad web
  user_data_replace_on_change = true

  # Script que se ejecuta en el primer arranque (ya resuelto)
  user_data = <<-EOT
    #!/bin/bash
    apt-get update -y
    apt-get install -y nginx
    echo "<h1>Hola desde ${var.prefijo}</h1><p>Servidor creado con Terraform</p>" > /var/www/html/index.html
    systemctl enable --now nginx
  EOT

  tags = {
    Name = "${var.prefijo}-web" # "<prefijo>-web"
  }
}

# PASO 3 · Grupo de seguridad del servidor web
# Documentación:
#   https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
#   https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule
#   https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule

resource "aws_security_group" "web" {
  name        = "${var.prefijo}-sg-web" # "<prefijo>-sg-web"
  description = "Servidor web: HTTP de entrada y toda la salida"
  vpc_id      = aws_vpc.principal.id

  tags = {
    Name = "${var.prefijo}-sg-web"
  }
}

# Entrada: HTTP (puerto 80, protocolo tcp) desde cualquier lugar (0.0.0.0/0)
resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.web.id
  description       = "HTTP"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

# Salida: todo el tráfico. Terraform elimina la regla de salida por defecto,
# así que hay que crearla. ip_protocol "-1" significa "todos los protocolos".
resource "aws_vpc_security_group_egress_rule" "todo" {
  security_group_id = aws_security_group.web.id
  description       = "Toda la salida"
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = -1
}

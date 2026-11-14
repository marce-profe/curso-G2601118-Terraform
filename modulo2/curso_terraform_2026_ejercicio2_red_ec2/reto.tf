# RETO OPCIONAL · Subred privada
# 1. Crea una variable "subred_privada_cidr" con valor por defecto "10.0.2.0/24".
# 2. Crea un aws_subnet "privada" en la misma VPC y zona, SIN IP pública.
#    No la asocies a la tabla de rutas pública: así no tendrá salida a Internet.
# 3. Añade un output "subred_privada_id".

variable "subred_privada_cidr" {
  description = "cidr de subred privada"
  type        = string
  default     = "10.0.2.0/24"
}

resource "aws_subnet" "privada" {
  vpc_id                  = aws_vpc.principal.id
  cidr_block              = var.subred_privada_cidr
  availability_zone       = var.zona
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.prefijo}-subred-privada"
  }
}

#Salida. Quizás sería mejor en el archivo de outputs para ser más ordenado
output "subred_privada_id" {
  description = "Id de la subred privada del reto"
  value       = aws_subnet.privada.id
}
# PASOS 1 y 2 · Red: VPC, subred pública y salida a Internet
# Sustituye cada ___ por el valor correcto. Documentación:
#   https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
#   https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
#   https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway
#   https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
#   https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association

# Paso 1 · VPC (ya resuelta: úsala como modelo)
resource "aws_vpc" "principal" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.prefijo}-vpc"
  }
}

# Paso 1 · Subred pública (complétala)
resource "aws_subnet" "publica" {
  vpc_id                  = aws_vpc.principal.id # referencia al id de la VPC
  cidr_block              = var.subred_publica_cidr # variable subred_publica_cidr
  availability_zone       = var.zona # variable zona
  map_public_ip_on_launch = true # true: las instancias reciben IP pública

  tags = {
    Name = "${var.prefijo}-subred-publica" # "<prefijo>-subred-publica"
  }
}

# Paso 2 · Internet Gateway
resource "aws_internet_gateway" "principal" {
  vpc_id = aws_vpc.principal.id

  tags = {
    Name = "${var.prefijo}-igw"
  }
}

# Paso 2 · Tabla de rutas: todo el tráfico (0.0.0.0/0) sale por el Internet Gateway
resource "aws_route_table" "publica" {
  vpc_id = aws_vpc.principal.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.principal.id
  }

  tags = {
    Name = "${var.prefijo}-rt-publica"
  }
}

# Paso 2 · Asociación de la subred con la tabla de rutas
resource "aws_route_table_association" "publica" {
  subnet_id      = aws_subnet.publica.id
  route_table_id = aws_route_table.publica.id
}

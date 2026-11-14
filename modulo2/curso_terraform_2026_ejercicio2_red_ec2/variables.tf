variable "region" {
  description = "Región de AWS"
  type        = string
  default     = "eu-west-1"
}

variable "usar_floci" {
  description = "true para trabajar en local con Floci; false para usar tu cuenta de AWS"
  type        = bool
  default     = false
}

variable "prefijo" {
  description = "Tu nombre y apellido en minúsculas y con guiones (ej.: ana-lopez). Se usa en los nombres de los recursos."
  type        = string
}

variable "zona" {
  description = "Zona de disponibilidad de la subred"
  type        = string
  default     = "eu-west-1a"
}

variable "vpc_cidr" {
  description = "Rango de direcciones de la VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subred_publica_cidr" {
  description = "Rango de direcciones de la subred pública (dentro de la VPC)"
  type        = string
  default     = "10.0.1.0/24"
}

variable "tipo_instancia" {
  description = "Tipo de instancia EC2"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "Déjalo vacío en AWS (se busca Ubuntu 24.04). Con Floci, indica una AMI de las que muestra Floci UI."
  type        = string
  default     = null
}

# PASO 6 · Salidas

output "vpc_id" {
  description = "Identificador de la VPC"
  value       = aws_vpc.principal.id
}

output "subred_id" {
  description = "Identificador de la subred pública"
  value       = aws_subnet.publica.id
}

output "ip_publica" {
  description = "IP pública del servidor web"
  value       = aws_instance.web.public_ip # atributo public_ip de la instancia
}

output "url" {
  description = "Dirección del servidor web (espera 1-2 minutos tras el apply)"
  value       = "http://${aws_instance.web.public_ip}" # "http://<ip pública>" usando interpolación
}

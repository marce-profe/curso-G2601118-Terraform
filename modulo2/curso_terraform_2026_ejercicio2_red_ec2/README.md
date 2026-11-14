# Ejercicio 2.1 · Infraestructura básica en AWS con HCL

Curso G2601118 · Infraestructura como código con Terraform · Módulo 2

Vas a crear una VPC con una subred pública, su salida a Internet, un grupo de seguridad y un servidor web en EC2.

| Fichero | Contenido | Estado |
| --- | --- | --- |
| `providers.tf` | Provider de AWS o Floci | Listo |
| `variables.tf` | Variables de entrada | Listo |
| `network.tf` | Pasos 1 y 2: VPC, subred, Internet Gateway y tabla de rutas | Completar |
| `security.tf` | Paso 3: grupo de seguridad y reglas | Completar |
| `compute.tf` | Paso 4 (AMI, listo) y paso 5 (instancia EC2) | Completar |
| `outputs.tf` | Paso 6: salidas | Completar |
| `reto.tf` | Reto opcional: subred privada | Opcional |

## Cómo trabajar

```bash
cp terraform.tfvars.example terraform.tfvars   # y rellénalo
terraform init
terraform fmt
terraform validate
terraform plan        # debe indicar 9 recursos para añadir
terraform apply
terraform destroy     # al terminar
```

Mientras queden huecos `___`, `terraform validate` dará error: es normal.

## Con AWS

Abre la URL que muestra el output `url`. El servidor tarda 1-2 minutos en instalar nginx tras el `apply`.

## Con Floci

1. Arranca Floci UI con `docker compose up` (ver ejercicios del módulo 1).
2. En `terraform.tfvars`, pon `usar_floci = true` e indica en `ami_id` una AMI de las que muestra Floci UI (Compute).
3. Comprueba los recursos en Floci UI o con la CLI:

```bash
aws --endpoint-url http://localhost:4566 ec2 describe-vpcs
aws --endpoint-url http://localhost:4566 ec2 describe-subnets
aws --endpoint-url http://localhost:4566 ec2 describe-security-groups
aws --endpoint-url http://localhost:4566 ec2 describe-instances
```

La prueba en el navegador solo es posible con AWS.

## Reglas de oro

- **Destruye siempre** lo que crees: la instancia y su IP pública tienen coste en AWS.
- **Nunca subas** credenciales, `terraform.tfvars` ni ficheros `*.tfstate` (ya están en `.gitignore`).

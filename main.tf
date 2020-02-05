#Crear la VPC en la zona CNBD
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "VPC-ZonaPrivada"
  }
}
#Obtener todas las zonas disponibles en la region
data "aws_availability_zones" "available" {
  state = "available"
}
#Crear las subnets para la capa de applicación
resource "aws_subnet" "private-app-subnets" {
  count                   = "${length(var.private-app-subnets)}"
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.private-app-subnets[count.index]}"
  availability_zone       = "${data.aws_availability_zones.available.names[count.index]}"
  map_public_ip_on_launch = false
  tags = {
    Name = "Subnet-APP-Privada-${count.index}"
  }
}
#Crear las subnets para la capa de base de datos
resource "aws_subnet" "private-db-subnets" {
  count                   = "${length(var.private-db-subnets)}"
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${var.private-db-subnets[count.index]}"
  availability_zone       = "${data.aws_availability_zones.available.names[count.index]}"
  map_public_ip_on_launch = false
  tags = {
    Name = "Subnet-BD-Privada-${count.index}"
  }
}
#Tabla de ruteo para subnets de aplicación (app)
resource "aws_route_table" "private-rt-app" {
  vpc_id = "${aws_vpc.vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
  }
  tags = {
    Name = "Route-APP-Privada"
  }
}
#Tabla de ruteo para subnets de base de datos (db)
resource "aws_route_table" "private-rt-db" {
  vpc_id = "${aws_vpc.vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
  }
  tags = {
    Name = "Route-BD-Privada"
  }
}
# Asociación de tablas de ruteo con subnets de aplicación (app)
resource "aws_route_table_association" "associate-rt-app" {
  count = "${length(var.private-app-subnets)}"
  subnet_id      = "${element(aws_subnet.private-app-subnets.*.id,count.index)}"
  route_table_id = "${aws_route_table.private-rt-app.id}"
}
# Asociación de tablas de ruteo con subnets de base de datos (db)
resource "aws_route_table_association" "associate-rt-bd" {
  count = "${length(var.private-db-subnets)}"
  subnet_id      = "${element(aws_subnet.private-db-subnets.*.id,count.index)}"
  route_table_id = "${aws_route_table.private-rt-db.id}"
}
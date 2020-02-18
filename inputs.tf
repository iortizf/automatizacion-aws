variable "nombre-proyecto" {}
variable "sufijo-proyecto" {}
variable "cnbd-cidr" {}

variable "private-app-subnets" {
  type = list(string)
}
variable "private-db-subnets" {
  type = list(string)
}
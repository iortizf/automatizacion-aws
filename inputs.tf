variable "CIDR" {
  default = "10.96.237.64/26"
}
variable "nombre-proyecto" {
  default = "SISTEMAS DRAGON"
}
variable "sufijo-proyecto" {
  default = "DRAGON"
}
variable "private-app-subnets" {
  type = list(string)
  default = ["10.96.237.94/27","10.96.237.128/27"]
}
variable "private-db-subnets" {
  type = list(string)
  default = ["10.96.237.160/27","10.96.237.192/27"]
}




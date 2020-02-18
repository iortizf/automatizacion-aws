output "vpc-id" {
  value = "aws_vpc.vpc.id"
}
output "subnets-app-ids" {
  value = "aws_subnet.private-app-subnets.*.id"
}
output "subnets-app-cidrs" {
  value = "aws_subnet.private-app-subnets.*.cidr_block"
}
output "subnets-db-ids" {
  value = "aws_subnet.private-db-subnets.*.id"
}
output "subnets-db-cidrs" {
  value = "aws_subnet.private-db-subnets.*.cidr_block"
}

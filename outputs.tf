
output "cluster_endpoint" {
  value = aws_docdb_cluster.pixels.endpoint
}

output "instance_endpoint" {
  value = aws_docdb_cluster_instance.pixels.endpoint
}

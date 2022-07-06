output "LoadBalancerDNSName" {
    value       = aws_lb.WebAppLB.dns_name
    description = "Load balancer DNS name"
}

output "LBPublicURL" {
    value       = "http://${aws_lb.WebAppLB.dns_name}"
    description = "Load balancer public url"
}
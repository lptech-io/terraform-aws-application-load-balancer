output "load_balancer_arn" {
  value = aws_lb.load_balancer.arn
}

output "listener_443_arn" {
  value = var.certificate_arn != null ? aws_lb_listener.listener_443[0].arn : "No listener rule on 443"
}

output "security_group_id" {
  value = aws_security_group.security_group.id
}

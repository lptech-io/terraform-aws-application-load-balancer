resource "aws_security_group" "security_group" {
  description = "${var.name} application load balancer security group"
  name        = "${var.name}-sg"
  tags = {
    "Name" = "${var.name}-sg"
  }
  vpc_id = var.vpc_id
}

resource "aws_lb" "load_balancer" {
  dynamic "access_logs" {
    for_each = var.logs_bucket_arn[*] # If logs_bucket_arn is null, then access_logs is not created

    content {
      bucket  = var.logs_bucket_arn
      enabled = true
      prefix  = lower(var.name)
    }
  }
  drop_invalid_header_fields = true
  internal                   = var.is_internal
  load_balancer_type         = "application"
  name                       = var.name
  tags = {
    "Name" = var.name
  }
  security_groups = [aws_security_group.security_group.id]
  subnets         = var.subnet_ids
}

resource "aws_lb_listener" "listener_80" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "redirect"
    redirect {
      port        = 443
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_listener" "listener_443" {
  certificate_arn   = var.certificate_arn
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy = var.elb_security_policy  # https://docs.aws.amazon.com/elasticloadbalancing/latest/application/create-https-listener.html#describe-ssl-policies
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "418 - I'm a teapot"
      status_code  = "418"
    }
  }
}

resource "aws_security_group_rule" "ingress_from_internet_port_80" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.security_group.id
  to_port           = 80
  type              = "ingress"
}

resource "aws_security_group_rule" "ingress_from_internet_port_443" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.security_group.id
  to_port           = 443
  type              = "ingress"
}

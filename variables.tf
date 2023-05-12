variable "certificate_arn" {
  description = "ARN of the default SSL server certificate"
  type        = string
}

variable "logs_bucket_arn" {
  default     = null
  description = "Bucket ARN for logs"
  type        = string
}

variable "is_internal" {
  default     = false
  description = "States if it's internet-facing or internal"
  type        = bool
}

variable "name" {
  description = "Name of the load balancer"
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9][a-zA-Z0-9-]{0,30}[a-zA-Z0-9]$", var.name))
    error_message = "Name must be between 2 and 32 characters long and can contain only alphanumeric characters and hyphens. Can't start or end with a hyphen."
  }
}

variable "elb_security_policy" {
  default     = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  description = "ELB security policy (https://docs.aws.amazon.com/elasticloadbalancing/latest/application/create-https-listener.html#describe-ssl-policies)"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs in which deploy the load balancer"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

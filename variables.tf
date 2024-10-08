variable "certificate_arn" {
  default     = null
  description = "ARN of the default SSL server certificate"
  type        = string
}

variable "drop_invalid_header_fields" {
  default     = true
  description = "Enable/disable the drop of invalid header fields"
  type        = bool
}

variable "elb_security_policy" {
  default     = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  description = "ELB security policy (https://docs.aws.amazon.com/elasticloadbalancing/latest/application/create-https-listener.html#describe-ssl-policies)"
  type        = string
}

variable "is_internal" {
  default     = false
  description = "States if it's internet-facing or internal"
  type        = bool
}

variable "logs_bucket_name" {
  default     = null
  description = "Bucket name for logs"
  type        = string
}

variable "name" {
  default = null
  description = "Name for the load balancer"
  type = string
}

variable "subnet_ids" {
  description = "List of subnet IDs in which deploy the load balancer"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

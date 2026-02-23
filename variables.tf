variable "environment" {
  type        = string
  description = "Deployment environment (e.g., dev, test, prod)"

  validation {
    condition     = contains(["dev", "test", "qa", "stage", "prod"], lower(var.environment))
    error_message = "Environment must be one of: dev, test, qa, stage, prod."
  }
}

variable "allowed_locations" {
  type        = list(string)
  description = "List of Azure regions allowed for resource deployment"

  validation {
    condition     = length(var.allowed_locations) > 0
    error_message = "You must provide at least one allowed location."
  }
}
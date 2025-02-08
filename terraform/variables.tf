variable "databricks_host" {
    description = "Databricks workspace URL"
    type        = string
}

variable "databricks_token" {
    description = "Databricks personal access token"
    type        = string
    sensitive   = true
}

variable "full_name" {
    description = "Your full name, used for catalog naming"
    type        = string
}
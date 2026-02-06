variable "project" {
    default = "robomart"
}

variable "environment" {
    default = "dev"
}

variable "zone_name" {
  type        = string
  default     = "azharprojects.site"
  description = "description"
}

variable "zone_id" {
  type        = string
  default     = "Z0553382WPE1E3VPCYS6"
  description = "description"
}

variable "sonar" {
default = false
}
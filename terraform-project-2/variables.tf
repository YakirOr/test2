variable "resource_group_location" {
  type        = string
  default     = "eastus"
  description = "Location of the resource group."
}

variable "resource_group_name" {
  type        = string
  default     = "clalit-proj-rg"
  description = "The name of the resource group"
}


variable "storage_account_name" {
  type        = string
  default     = "clalitprojsa"
  description = "The name of the Storage account"
}

variable "virtual_network_name" {
  type        = string
  default     = "clalit-proj-vnet"
  description = "The name of the VNet"
}


variable "subnet_name" {
  type        = string
  default     = "clalit-proj-sub"
  description = "The name of the subnet"
}


variable "dns_zone_name" {
  type        = string
  default     = "clalit-proj-prv.dns"
  description = "The name of the dns"
}


variable "dns_network_link_name" {
  type        = string
  default     = "clalit-proj-vnl"
  description = "The name of the dns"
}


variable "dns_record_name" {
  type        = string
  default     = "clalit-proj-dns-rec"
  description = "The name of the dns"
}

variable "private_endpoint_sa_name" {
  type        = string
  default     = "clalit-proj-prv_sa_endpoint"
  description = "The name of the dns"
}


variable "function_app_name" {
  type        = string
  default     = "clalit-proj-function-app"
  description = "The name of the function-app"
}


variable "service_plan_name" {
  type        = string
  default     = "clalit-proj-service-app"
  description = "The name of the function-app"
}


variable "Private_Endpoint_name_funapp_name" {
  type        = string
  default     = "clalit-proj-prv-endpoint-fa"
  description = "The name of the function-app"
}


variable "as_service_diagnostics_name" {
  type        = string
  default     = "clalit-proj-ap-diagnostic"
  description = "The name of the function-app"
}
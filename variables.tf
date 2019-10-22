variable "allowed_account_ids" {
  type = list(string)
}


variable "origin_bucket_name" {
  type = string
}

variable "resize_lambda_edge" {
  type = object({
    name    = string
    version = number
  })
}


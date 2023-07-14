variable "name" {
  default = "ljh"
}

variable "env" {
  default = "test"
}

# variable "apache_setup" {
#   description = "Map of project names to configuration."
#   type        = map(any)

#   default = {
#     apache1 = {
#       listen_port            = "7070",
#       my_name                = "ljh-1"
#     },
#     apache2 = {
#       listen_port            = "8080",
#       my_name                = "ljh-2"
#     },
#     apache3 = {
#       listen_port            = "9090",
#       my_name                = "ljh-3"
#     }
#   }
# }

variable "my_name" {
  type    = list(string)
  default = ["junho1", "junho2", "junho3"]
}

variable "port_num" {
  type    = list(string)
  default = ["7070", "8080", "9090"]
}
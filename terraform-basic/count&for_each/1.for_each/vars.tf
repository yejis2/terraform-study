variable "name" {
  default = "ljh"
}

variable "env" {
  default = "test"
}

variable "apache_setup" {
  description = "Map of project names to configuration."
  type        = map(any)

  default = {
    apache1 = {
      listen_port            = "7070",
      my_name                = "ljh-1"
      instance_tag_num       = "1"
    },
    apache2 = {
      listen_port            = "8080",
      my_name                = "ljh-2"
      instance_tag_num       = "2"
    },
    apache3 = {
      listen_port            = "9090",
      my_name                = "ljh-3"
      instance_tag_num       = "3"
    }
  }
}

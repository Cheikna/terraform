variable private_ip_of_public_machine {
    type    = string
    default = "10.0.0.5"
}

variable private_ip_of_private_machine {
    type    = string
    default = "10.0.1.5"
}

variable mongodb_port {
    type = number
    default = 27017
}
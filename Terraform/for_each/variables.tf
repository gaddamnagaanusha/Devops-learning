# variable "instances" {
#     type = map
#     default = {
#         mongodb = "t3.micro"
#         mysql = "t3.small"
#         user = "t3.micro"
#         shipping = "t3.small"

#     }
# }

# This should be converted into set
variable "instances" {
    type = list
    default = ["mongodb", "redis"]
}

variable "zone_id" {
    default = "Z05013202FKF0ZL12WAOP"
}

variable "domain_name" {
    default = "daws88s.online"
}
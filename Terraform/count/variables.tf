variable "instances" {
    type = list
    default = ["mongodb","catalogue","user","cart","shipping","payment"]
  
}

variable "zone_id" {
    default = "Z02669081FB4X7KDSL5OS"
  
}
variable "domain_name" {
    default = "sainu.online"
  
}
variable "fruits" {
    type = list(string)
    default = [ "apple","banana","orange" ]
  
}
variable "fruits_set" {
    type = set(string)
    default = ["apple", "banana", "apple", "orange"]
}
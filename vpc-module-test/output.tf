output "availability_zones_names" {
 
  value = module.vpc.availability_zones_names # we are referring the output of availability_zones_names from vpc module and assigning it to the output of this file, so that we can use this output in other terraform file by calling this module.
  description = "The list of available Availability Zone names in the current region"    
  }
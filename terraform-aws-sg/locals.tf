locals {
   common_tags = {

    Project     = var.project
    Environment = var.environment
    terraform   = "true"

  }

  tags = merge(
       var.sg_tags,
       local.common_tags,
       {
           Name = "${var.project}-${var.environment}"  #this is for giving the name to our security group, we are using the merge function to merge the common_tags with the name tag, so that we can have the name tag in our security group along with the common tags
       },
  )
}
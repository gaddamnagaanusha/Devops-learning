locals {
  common_tags = {
    Project     = var.project
    Environment = var.environment
    terraform   = "true"
  }

  vpc_final_tags = merge(
        local.common_tags,
        {
            Name = "${var.project}-${var.environment}"  #this is for giving the name to our vpc, we are using the merge function to merge the common_tags with the name tag, so that we can have the name tag in our vpc along with the common tags
        },

        var.vpc_tags
    )

    igw_final_tags = merge(
        local.common_tags,
        {
            Name = "${var.project}-${var.environment}"  #this is for giving the name to our internet gateway, we are using the merge function to merge the common_tags with the name tag, so that we can have the name tag in our internet gateway along with the common tags
        },

        var.igw_tags
    )
}
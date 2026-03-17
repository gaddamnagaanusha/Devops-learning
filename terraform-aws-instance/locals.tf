locals{
    common_tags = {
        project = var.project
        environment = var.environment
        terrafrom = "true"
    }
    ec2_final_tags = merge(local.common_tags, var.tags)
}
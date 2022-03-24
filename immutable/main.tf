module "ec2" {
  source              = "./vendor/modules/ec2-immutable"
  SPOT_INSTANCE_COUNT = var.SPOT_INSTANCE_COUNT
  OD_INSTANCE_COUNT   = var.OD_INSTANCE_COUNT
  SPOT_INSTANCE_TYPE  = var.SPOT_INSTANCE_TYPE
  OD_INSTANCE_TYPE    = var.OD_INSTANCE_TYPE
  ENV                 = var.ENV
  COMPONENT           = var.COMPONENT
  ALB_ATTACH_TO       = "backend"
  PORT                = var.PORT
  TRIGGER             = var.TRIGGER
  APP_VERSION         = var.APP_VERSION
  ASG_DESIRED         = var.ASG_DESIRED
  ASG_MIN             = var.ASG_MIN
  ASG_MAX             = var.ASG_MAX
}



locals {
  create_function                           = var.create_function ? 1 : 0
  role_assume_role_policy_default_file_path = "${path.module}/templates/default_assume_role_policy.tpl"
  role_assume_role_policy_file_path         = var.create_role_assume_role_policy_file == "" || var.create_role_assume_role_policy_file == null ? local.role_assume_role_policy_default_file_path : var.create_role_assume_role_policy_file
  role_assume_role_policy_full_json         = (var.create_role_assume_role_policy_source == "string") ? var.create_role_assume_role_policy_string : (var.create_role_assume_role_policy_source == "file" ? file(local.role_assume_role_policy_file_path) : "")
  role_permissions_policy_default_file_path = "${path.module}/templates/default_iam_policy.tpl"
  role_permissions_policy_file_path         = var.create_role_permission_policy_file == "" || var.create_role_permission_policy_file == null ? local.role_permissions_policy_default_file_path : var.create_role_permission_policy_file
  role_permissions_policy_full_json         = (var.create_role_permission_policy_source == "string") ? var.create_role_permission_policy_source : (var.create_role_permission_policy_source == "file" ? file(local.role_permissions_policy_file_path) : "")
  create_role_boolean                       = var.create_function && (var.create_role_assume_role_policy_source == "string" ||  var.create_role_assume_role_policy_source == "file")  && (var.role == null || var.role == "") ? 1 : 0
  resources_basename                        = "${var.function_name}-${var.environment}"
}

resource "aws_lambda_function" "lambda" {
  count                          = local.create_function
  description                    = var.description
  function_name                  = local.resources_basename
  handler                        = var.handler
  role                           = coalesce(var.role, aws_iam_role.lambda[0].arn)
  runtime                        = var.runtime
  publish                        = var.publish
  s3_object_version              = var.s3_object_version
  tags                           = module.default_tags.tags
  layers                         = var.layers
  s3_bucket                      = var.s3_bucket
  source_code_hash               = var.source_code_hash == null || var.source_code_hash == "" ? filebase64sha512(var.filename) : var.source_code_hash
  reserved_concurrent_executions = var.reserved_concurrent_executions
  memory_size                    = var.memory_size
  timeout                        = var.timeout
  s3_key                         = var.s3_bucket == null || var.s3_bucket == "" ? null : var.filename
  kms_key_arn                    = var.kms_key_arn
  filename                       = var.s3_bucket == null || var.s3_bucket == "" ? var.filename : null


  vpc_config {
    security_group_ids = var.vpc_config_security_group_ids
    subnet_ids         = var.vpc_config_subnet_ids
  }

  dynamic "tracing_config" {
    for_each = compact(list(var.tracing_config_mode))
    content {
      mode = var.tracing_config_mode
    }
  }

  dynamic "environment" {
    for_each = length(var.environment_variables) > 0 ? {
      create_environment_block = true
    } : {}
    content {
      variables = var.environment_variables
    }
  }

  dynamic "dead_letter_config" {
    for_each = compact(list(var.dead_letter_config_target_arn))
    content {
      target_arn = dead_letter_config.value
    }
  }

  lifecycle {
    ignore_changes = [
      tags]
  }
}

resource "aws_iam_role" "lambda" {
  count                 = local.create_role_boolean
  assume_role_policy    = local.role_assume_role_policy_full_json
  name                  = local.resources_basename
  name_prefix           = var.create_role_name_prefix
  permissions_boundary  = var.create_role_permissions_boundary
  force_detach_policies = var.create_role_force_detach_policies
  path                  = var.create_role_path
  tags                  = module.default_tags.tags
  lifecycle {
    ignore_changes = [
      tags]
  }
}

resource "aws_iam_role_policy" "lambda" {
  count       = local.create_role_boolean
  name        = local.resources_basename
  name_prefix = var.create_role_name_prefix
  policy      = local.role_permissions_policy_full_json
  role        = aws_iam_role.lambda[0].name
}


resource "aws_lambda_permission" "lambda" {
  count               = var.create_lambda_permission ? 1 : 0
  action              = var.lambda_permission_action
  event_source_token  = var.lambda_permission_event_source_token
  function_name       = aws_lambda_function.lambda[0].function_name
  principal           = var.lambda_permission_principal
  qualifier           = var.lambda_permission_qualifier
  source_account      = var.lambda_permission_source_account
  source_arn          = var.lambda_permission_source_arn
  statement_id        = var.lambda_permission_statement_id
  statement_id_prefix = var.lambda_permission_statement_id_prefix
}


resource "aws_lambda_event_source_mapping" "trigger" {
  count            = var.aws_lambda_event_source_mapping_event_source_arn == null ||  var.aws_lambda_event_source_mapping_event_source_arn ==  "" ? 0 : 1
  event_source_arn = var.aws_lambda_event_source_mapping_event_source_arn
  function_name    = aws_lambda_function.lambda[0].arn
}

module "default_tags" {
  source          = "git@github.com:facets-io/terraform-module-aws-tags-default.git?ref=0.0.1"
  additional_tags = var.tags
  envrionment     = var.environment
}


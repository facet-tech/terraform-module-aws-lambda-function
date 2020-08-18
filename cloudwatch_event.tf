locals {
  create_trigger = var.create_trigger ? 1 : 0
}

resource "aws_cloudwatch_event_rule" "trigger" {
  count               = local.create_trigger
  name                = local.resources_basename
  name_prefix         = var.trigger_name_prefix
  schedule_expression = var.trigger_schedule_expression
  event_pattern       = var.trigger_event_pattern
  role_arn            = aws_iam_role.lambda[0].arn
  description         = var.trigger_description
  is_enabled          = var.trigger_is_enabled
  tags                = module.default_tags.tags
}

resource "aws_cloudwatch_event_target" "trigger" {
  count     = local.create_trigger
  arn       = aws_lambda_function.lambda[0].arn
  rule      = aws_cloudwatch_event_rule.trigger[0].name
  target_id = local.resources_basename
  input     = var.trigger_input
}

resource "aws_lambda_permission" "trigger" {
  count              = local.create_trigger
  action             = var.trigger_lambda_permission_action
  event_source_token = var.trigger_lambda_permission_event_source_token
  function_name      = aws_lambda_function.lambda[0].function_name
  principal          = var.constants.trigger_service_endpoint
  qualifier          = var.trigger_lambda_permission_qualifier
  source_account     = var.trigger_lambda_permission_source_account
  source_arn         = aws_cloudwatch_event_rule.trigger[0].arn
  statement_id       = var.trigger_lambda_permission_statement_id

}
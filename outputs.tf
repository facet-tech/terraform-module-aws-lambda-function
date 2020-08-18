output "lambda" {
  value       = var.create_function ? aws_lambda_function.lambda[0] : null
  description = "Lambda function details"
}
output "lambda_versioned_invoke_arn" {
  value       = var.create_function ? replace(aws_lambda_function.lambda[0].invoke_arn, aws_lambda_function.lambda[0].arn, aws_lambda_function.lambda[0].qualified_arn) : null
  description = "Lambda function ARN"
}
output "cloudwatch_event_rules" {
  value       = var.create_trigger ? aws_cloudwatch_event_rule.trigger[0] : null
  description = "Cloudwatch event rules resource details"
}
output "lambda_arn" {
  value       = var.create_function ? aws_lambda_function.lambda[0].arn : null
  description = "Lambda function ARN"
}

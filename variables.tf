variable "environment" {
  type    = string
  default = ""
}
variable "function_name" {
  type        = string
  description = "The name of the lambda function."
  default     = ""
}
variable "description" {
  type        = string
  description = "The description of the lambda function."
  default     = null
}
variable "handler" {
  type        = string
  description = "The executable file name value. For example, 'myHandler' would call the main function in the package “main” of the myHandler executable program.."
  default     = null
}
variable "runtime" {
  type        = string
  description = "The runtime of the lambda function. Options can be found here: https://docs.aws.amazon.com/sdkfornet/v3/apidocs/index.html?page=Lambda/TLambdaRuntime.html&tocid=Amazon_Lambda_Runtime"
  default     = "nodejs12.x"
}
variable "filename" {
  type        = string
  description = "The path to the deployment package.  Tf s3_bucket is defined this is the path relative from the root of the bucket.  If s3_bucket is not defined this the path on the local file system."

}

variable "s3_bucket" {
  type        = string
  description = "(Optional) The S3 bucket location containing the function's deployment package. This bucket must reside in the same AWS region where you are creating the Lambda function."
  default     = null
}

variable "s3_object_version" {
  type        = string
  description = "(Optional) The object version containing the function's deployment package. If set s3_bucket if required."
  default     = null
}
variable "dead_letter_config_target_arn" {
  type        = string
  description = "(Optional) ARN of a target SNS topic or SQS queue to notify when an invocation fails. If this option is used, the function's IAM role must be granted suitable access to write to the target object, which means allowing either the sns:Publish or sqs:SendMessage action on this ARN, depending on which service is targeted."
  default     = null
}
variable "layers" {
  type        = list(string)
  description = "(Optional) List of Lambda Layer Version ARNs (maximum of 5) to attach to your Lambda Function. See Lambda Layers"
  default     = null
}
variable "memory_size" {
  type        = number
  description = "(Optional) Amount of memory in MB your Lambda Function can use at runtime. Defaults to 128. See Limits"
  default     = 256
}
variable "timeout" {
  type        = number
  description = "(Optional) The amount of time your Lambda Function has to run in seconds. Defaults to 3. See Limits"
  default     = 30
}
variable "reserved_concurrent_executions" {
  type        = number
  description = "(Optional) The amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations. Defaults to Unreserved Concurrency Limits -1. See Managing Concurrency"
  default     = -1
}
variable "publish" {
  type        = bool
  description = "(Optional) Whether to publish creation/change as new Lambda Function Version. Defaults to false."
  default     = true
}
variable "vpc_config_subnet_ids" {
  type        = list(string)
  description = "(Required if running Lambda in VPC) A list of subnet IDs associated with the Lambda function."
  default     = []
}
variable "vpc_config_security_group_ids" {
  type        = list(string)
  description = "(Required if running Lambda in VPC) A list of security group IDs associated with the Lambda function."
  default     = []
}
variable "environment_variables" {
  type        = map(string)
  description = "(Optional) A map that defines environment variables for the Lambda function."
  default     = {}
}
variable "kms_key_arn" {
  type        = string
  description = "(Optional) Amazon Resource Name (ARN) of the AWS Key Management Service (KMS) key that is used to encrypt environment variables. If this configuration is not provided when environment variables are in use, AWS Lambda uses a default service key. If this configuration is provided when environment variables are not in use, the AWS Lambda API does not save this configuration and Terraform will show a perpetual difference of adding the key. To fix the perpetual difference, remove this configuration."
  default     = null
}
variable "source_code_hash" {
  type        = string
  description = "(Optional) Used to trigger updates. Must be set to a base64-encoded SHA256 hash of the package file specified with either filename or s3_key. The usual way to set this is filebase64sha256('file.zip') (Terraform 0.11.12 and later) or base64sha256(file('file.zip')) (Terraform 0.11.11 and earlier), where 'file.zip' is the local filename of the lambda function source archive."
  default     = null
}
variable "tracing_config_mode" {
  type        = string
  description = "(Optional) Can be either PassThrough or Active. If PassThrough, Lambda will only trace the request from an upstream service if it contains a tracing header with 'sampled=1'. If Active, Lambda will respect any tracing header it receives from an upstream service. If no tracing header is received, Lambda will call X-Ray for a tracing decision."
  default     = ""
}
variable "tags" {
  type        = map(string)
  description = "(Optional) A mapping of tags to assign to the object."
  default     = {}
}

variable "create_lambda_permission" {
  type        = bool
  description = "If true, grants resources permission to invoke lambda function.  See lambda_permission variables."
  default     = false
}

variable "lambda_permission_action" {
  type        = string
  description = "(Required if assigning a resource policy) The AWS Lambda action you want to allow in this statement. (e.g. lambda:InvokeFunction)"
  default     = "lambda:InvokeFunction"
}
variable "lambda_permission_event_source_token" {
  type        = string
  description = "(Optional) The Event Source Token to validate. Used with Alexa Skills."
  default     = null
}
variable "lambda_permission_principal" {
  type        = string
  description = "(Required if assigning a resource policy) The principal who is getting this permission. e.g. s3.amazonaws.com, an AWS account ID, or any valid AWS service principal such as events.amazonaws.com or sns.amazonaws.com."
  default     = "events.amazonaws.com"
}
variable "lambda_permission_qualifier" {
  type        = string
  description = "(Optional) Query parameter to specify function version or alias name. The permission will then apply to the specific qualified ARN. e.g. arn:aws:lambda:aws-region:acct-id:function:function-name:2"
  default     = null
}
variable "lambda_permission_source_account" {
  type        = string
  description = "(Optional) This parameter is used for S3 and SES. The AWS account ID (without a hyphen) of the source owner."
  default     = null
}
variable "lambda_permission_source_arn" {
  type        = string
  description = "(Optional) When granting Amazon S3 or CloudWatch Events permission to invoke your function, you should specify this field with the Amazon Resource Name (ARN) for the S3 Bucket or CloudWatch Events Rule as its value. This ensures that only events generated from the specified bucket or rule can invoke the function. API Gateway ARNs have a unique structure described here."
  default     = null
}
variable "lambda_permission_statement_id" {
  type        = string
  description = "(Optional) A unique statement identifier. By default generated by Terraform."
  default     = null
}
variable "lambda_permission_statement_id_prefix" {
  type        = string
  description = "(Optional) A statement identifier prefix. Terraform will generate a unique suffix. Conflicts with statement_id."
  default     = "AllowInvoke"
}
variable "role" {
  type        = string
  description = "The ARN of a role that defines the permissions of your function."
  default     = ""
}
variable "create_role_assume_role_policy_string" {
  type        = string
  description = "(Optional) Full JSON policy to assign to newly created role. Mandatory if no role is supplied."
  default     = ""
}
variable "create_role_assume_role_policy_file" {
  type        = string
  description = "(Optional) Path to JSON policy to assign to newly created role. Mandatory if no role is supplied."
  default     = ""
}
#Possible values are string, file, or none.
#If you specify string, then assign a value to create_role_assume_role_policy_string.
#If file, you must specify a file path to create_role_assume_role_policy_file.
#None requires no changes to other variables
variable "create_role_assume_role_policy_source" {
  description = "Whether to load from 'create_role_assume_role_policy_string' or 'create_role_assume_role_policy_file' Acceptable values are 'file', 'string', or 'none' (if not creating a role)."
  default     = "file"
}
variable "create_role_permission_policy_string" {
  type        = string
  description = "(Optional) Full JSON permission policy to assign to newly created role. Mandatory if no role is supplied."
  default     = ""
}
variable "create_role_permission_policy_file" {
  type        = string
  description = "(Optional) Path to JSON permission policy to assign to newly created role. Mandatory if no role is supplied."
  default     = ""
}
#Possible values are string, file, or none.
#If you specify string, then assign a value to create_role_permission_policy_string.
#If file, you must specify a file path to create_role_permission_policy_file.
#None requires no changes to other variables
variable "create_role_permission_policy_source" {
  type        = string
  description = "Whether to load from 'create_role_permission_policy_string' or 'create_role_permission_policy_file' Acceptable values are 'file', 'string', or 'none' (if not creating a role)."
  default     = "file"
}

variable "create_role_description" {
  type        = string
  description = "Description of the newly created role."
  default     = ""
}
variable "create_max_session_duration" {
  type        = number
  description = "The maximum session duration (in seconds) that you want to set for the newly created role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours."
  default     = 3600
}
variable "create_role_permissions_boundary" {
  type        = string
  description = "(Optional) The ARN of the policy that is used to set the permissions boundary for the newly created role."
  default     = ""
}
variable "create_role_tags" {
  type        = map(string)
  description = "(Optional) Key-value mapping of tags for the newly created role."
  default     = {}
}
variable "create_role_path" {
  type        = string
  description = "(Optional) The path to the newly created role."
  default     = null
}
variable "create_role_force_detach_policies" {
  type        = bool
  description = "(Optional) Specifies to force detaching any policies the newly created role has before destroying it. Defaults to false."
  default     = false
}
variable "create_role_name_prefix" {
  type        = string
  description = "(Optional, Forces new resource) Creates a unique name for the newly created role beginning with the specified prefix. Conflicts with name."
  default     = null
}

variable "aws_lambda_event_source_mapping_event_source_arn" {
  type    = string
  default = null
}

variable "trigger_is_enabled" {
  default     = true
  description = "(Optional) Whether the rule should be enabled (defaults to true)."
  type        = bool
}

variable "trigger_schedule_expression" {
  default     = ""
  description = "(Required, if event_pattern isn't specified) The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes)."
  type        = string
}

variable "trigger_description" {
  default     = ""
  description = "(Optional) The description of the rule."
  type        = string
}

variable "trigger_name_prefix" {
  default     = null
  description = " (Optional) The rule's name. Conflicts with name."
  type        = string
}

variable "trigger_event_pattern" {
  default     = null
  description = "(Required, if schedule_expression isn't specified) Event pattern described a JSON object. "
}

variable "create_trigger" {
  default     = false
  description = "A flag to create an event rule. Default is  False"
  type        = bool
}

variable "trigger_input" {
  default     = ""
  description = "(Optional) Valid JSON text passed to the target."
}

variable "constants" {
  description = "Constants used within module."
  type        = object({
    trigger_service_endpoint = string
  })
  default     = {
    trigger_service_endpoint = "events.amazonaws.com"

  }
}

variable "create_function" {
  type        = bool
  description = "Whether to create a lambda function."
  default     = true
}

variable "trigger_lambda_permission_action" {
  type        = string
  description = "(Required if assigning a resource policy) The AWS Lambda action you want to allow in this statement. (e.g. lambda:InvokeFunction)"
  default     = "lambda:InvokeFunction"
}
variable "trigger_lambda_permission_event_source_token" {
  type        = string
  description = "(Optional) The Event Source Token to validate. Used with Alexa Skills."
  default     = null
}
variable "trigger_lambda_permission_qualifier" {
  type        = string
  description = "(Optional) Query parameter to specify function version or alias name. The permission will then apply to the specific qualified ARN. e.g. arn:aws:lambda:aws-region:acct-id:function:function-name:2"
  default     = null
}
variable "trigger_lambda_permission_source_account" {
  type        = string
  description = "(Optional) This parameter is used for S3 and SES. The AWS account ID (without a hyphen) of the source owner."
  default     = null
}
variable "trigger_lambda_permission_statement_id" {
  type        = string
  description = "(Optional) A unique statement identifier. By default generated by Terraform."
  default     = null
}

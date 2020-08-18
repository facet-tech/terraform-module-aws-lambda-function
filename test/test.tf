module "lambda" {
  source = "../"
  function_name = "bill-test"
  filename = "/home/tf/tmp/0.1.3.20.zip"
  handler = "GGX_DirectIDCallbackHandler::GGX_DirectIDCallbackHandler.DirectIDCallbackHandler::ProcessDirectIDCallbackDataAsync"
  create_role_assume_role_policy_file = "${path.cwd}/templates/test_role_policy_template.tpl"
  create_role_permission_policy_file = "${path.cwd}/templates/test_default_iam_policy.tpl"
}

provider "aws" {
  region     = "us-east-1"
  profile = "trulioo-developer"
}
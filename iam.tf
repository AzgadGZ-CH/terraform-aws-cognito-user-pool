resource "aws_lambda_permission" "custom_email_sender" {
#   for_each = local.lambda_config
  for_each = lookup(local.lambda_config.value, "custom_email_sender")
  statement_id  = "AllowExectionFromCognitoPool-${aws_cognito_user_pool.pool.name}"
  action        = "lambda:InvokeFunction"
  function_name = "${split(":", each.value.function_name)[-1]}"
  principal     = "cognito-idp.amazonaws.com"
  source_arn    = aws_cognito_user_pool.pool.arn
}
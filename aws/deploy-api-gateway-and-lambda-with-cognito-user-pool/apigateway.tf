resource "aws_api_gatewa_rest_api" "mylocalone_api" {
  name = "mylocalone_api"
  description = "My API Gateway"

  endpoint_configuraton {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "root" {
  rest_api_id = aws_api_gateway_resource.mylocalone_api.id
  parent_id = aws_api_gateway_rest_api.mylocalone_api.root_resource_id
  path_part = "mypath"
}

resource "aws_api_gateway_method" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.mylocalone_api.id
  resource_id = aws_api_gateway_resource.root.id
  http_method = "POST"

  //authorization = "NONE"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.demo.id
}

resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id = aws_api_gateway_rest_api.mylocalone_api.id
  resource_id = aws_api_gateway_resource.root.id
  http_method = aws_api_gateway_method.proxy.http_method
  integration_http_method = "POST"
  type = "AWS"  
  uri = aws_lambda_function.html_lambda.invoke_arn
}

resource "aws_api_gateway_method_response" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.mylocalone_api.id
  resource_id = aws_api_gateway_resource.root.id
  http_method = aws_api_gateway_method.proxy.http_method
  status_code = "200"

  //cors section
  responce_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}

resource "aws_api_gateway_integration_response" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.mylocalone_api.id
  resource_id = aws_api_gateway_resource.root.id
  http_method = aws_api_gateway_method.proxy.http_method
  status_code = aws_api_gateway_method_response.proxy.status_code

  //cors
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" =  "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }

  depends_on = [
    aws_api_gateway_method.proxy,
    aws_api_gateway_integration.lambda_integration
  ]
}

resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [
    aws_api_gateway_integration.lambda_integration,
    aws_api_gateway_integration.options_integration, # Add this line
  ]
  rest_api_id = aws_api_gateway_rest_api.mylocalone_api.id
  stage_name = "dev"
}

resource "aws_api_gateway_authorizer" "demo" {
  name = "mylocalone_api_gw_authorizer"
  rest_api_id = aws_api_gateway_rest_api.mylocalone_api.id
  type = "COGNITO_USER_POOLS"
  provider_arns = [aws_cognito_user_pool.pool.arn]
}

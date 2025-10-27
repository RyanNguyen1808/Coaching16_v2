# --- IAM Role for Lambda ---
resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Effect = "Allow"
      }
    ]
  })
}

# --- IAM Policy for CloudWatch Logs ---
resource "aws_iam_role_policy_attachment" "lambda_logging" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# --- Lambda Function ---
resource "aws_lambda_function" "retrieve_url_lambda" {
  # checkov:skip=CKV_AWS_117:Ensure that AWS Lambda function is configured inside a VPC - non compliant
  # checkov:skip=CKV_AWS_116:Ensure that AWS Lambda function is configured for a Dead Letter Queue(DLQ) - non compliant
  # checkov:skip=CKV_AWS_50:X-Ray tracing is enabled for Lambda - non compliant
  # checkov:skip=CKV_AWS_173:Check encryption settings for Lambda environmental variable - non compliant
  # checkov:skip=CKV_AWS_115:Ensure that AWS Lambda function is configured for function-level concurrent execution limit - non compliant
  # checkov:skip=CKV_AWS_272:Ensure AWS Lambda function is configured to validate code-signing - non compliant
  function_name = "retrieve_url_lambda"
  filename      = "lambda_impl/retrieve-url-lambda.zip" # path to your zip
  handler       = "retrieve-url-lambda.lambda_handler"  # filename.function_name
  runtime       = "python3.11"

  role = aws_iam_role.lambda_exec.arn

  # optional: environment variables
  environment {
    variables = {
      ENV = "dev"
    }
  }

  # optional: memory, timeout, etc.
  memory_size = 128
  timeout     = 10
}
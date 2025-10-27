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
resource "aws_lambda_function" "my_lambda" {
  function_name = "my_lambda"
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
resource "aws_cloudwatch_metric_alarm" "info_count-breach" {
  alarm_name          = "info-count-breach"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "info-count"
  namespace           = "moviedb-api/marlon"
  period              = 300
  statistic           = "Sum"
  threshold           = 10

  alarm_description   = "Alarm when Lambda function exceeds 10 info logs in 5 minutes"
  treat_missing_data  = "notBreaching"

  alarm_actions = [
    aws_sns_topic.lambda_alerts.arn
  ]
}

resource "aws_sns_topic" "lambda_alerts" {
  name = "lambda-alerts-topic"
}

/* no need email subscription 
resource "aws_sns_topic_subscription" "email_sub" {
  topic_arn = aws_sns_topic.lambda_alerts.arn
  protocol  = "email"
  endpoint  = "zanjero3333@gmail.com"
}
*/
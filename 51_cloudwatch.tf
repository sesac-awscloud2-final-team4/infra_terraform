# Dashboard
resource "aws_cloudwatch_dashboard" "EC2_Dashboard" {
  dashboard_name = "EC2-Dashboard"
  dashboard_body = <<EOF
{
    "widgets": [
        {
            "type": "explorer",
            "width": 24,
            "height": 15,
            "x": 0,
            "y": 0,
            "properties": {
                "metrics": [
                    {
                        "metricName": "CPUUtilization",
                        "resourceType": "AWS::EC2::Instance",
                        "stat": "Maximum"
                    }
                ],
                "aggregateBy": {
                    "key": "InstanceType",
                    "func": "MAX"
                },
                "labels": [
                    {
                        "key": "State",
                        "value": "running"
                    }
                ],
                "widgetOptions": {
                    "legend": {
                        "position": "bottom"
                    },
                    "view": "timeSeries",
                    "rowsPerPage": 8,
                    "widgetsPerRow": 2
                },
                "period": 60,
                "title": "Running EC2 Instances CPUUtilization"
            }
        }
    ]
}
EOF
}

# Metric Alarm
resource "aws_cloudwatch_metric_alarm" "EC2_CPU_Usage_Alarm" {
  alarm_name          = "EC2_CPU_Usage_Alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "70"
  alarm_description   = "This metric monitors ec2 cpu utilization exceeding 70%"
}

# Log group (Collecting resources' log)
resource "aws_cloudwatch_log_group" "EC2_logGroup" {
  name              = "EC2_logGroup"
  retention_in_days = 30
}


# Log stream
resource "aws_cloudwatch_log_group" "ebs_log_group" {
  name = "ebs_log_group"
}
resource "aws_cloudwatch_log_stream" "ebs_log_stream" {
  name           = "ebs_log_stream"
  log_group_name = aws_cloudwatch_log_group.ebs_log_group.name
}


# Log metric filter
resource "aws_cloudwatch_log_metric_filter" "ElasticBeanStalk_metric_filter" {
  name           = "ElasticBeanStalk_metric_filter"
  pattern        = "ERROR"
  log_group_name = aws_cloudwatch_log_group.ElasticBeanStalk_log_group.name
  metric_transformation {
    name      = "ErrorCount"
    namespace = "ElasticBeanstalk"
    value     = "1"
  }
}
resource "aws_cloudwatch_log_group" "ElasticBeanStalk_log_group" {
  name = "ElasticBeanStalk_log_group"
}





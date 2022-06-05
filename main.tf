
provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "us-east-1"
}

variable "ec2-instance" {
  type    = string
  default = "i-0ab6b889c2a736d7d"

}


resource "aws_cloudwatch_dashboard" "starter-dashboard" {
  dashboard_name = "dashboard-${var.ec2-instance}"


  dashboard_body = <<EOF
{
  "widgets": [
    {
      "type": "metric",
      "x": 0,
      "y": 0,
      "width": 12,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/EC2",
            "CPUUtilization",
            "InstanceId",
            "${var.ec2-instance}"
          ]
        ],
        "period": 300,
        "stat": "Average",
        "region": "us-east-1",
        "title": "${var.ec2-instance} - CPU Utilization"
      }
    },
    {
      "type": "text",
      "x": 0,
      "y": 7,
      "width": 3,
      "height": 3,
      "properties": {
        "markdown": "Hello world"
      }
    },
     {
         "type":"metric",
         "x":0,
         "y":0,
         "width":12,
         "height":6,
         "properties":{
            "metrics":[
               [
                  "AWS/EC2",
                  "NetworkIn",
                  "InstanceId",
                  "${var.ec2-instance}"
               ]
            ],
            "period":300,
            "stat":"Average",
            "region":"us-east-1",
            "title":"${var.ec2-instance} - NetworkIn"
         }
      }

  ]
}
EOF
}

resource "aws_cloudwatch_metric_alarm" "ec2-cpu-88" {
  alarm_name                = "terraform-test-ec2-cpu-80"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "80"
  alarm_description         = "This metric monitors when ec2 cpu utilization reaches 80"
  insufficient_data_actions = []
}

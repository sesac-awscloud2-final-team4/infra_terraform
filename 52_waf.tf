# ip set
resource "aws_wafv2_ip_set" "ipset" {
  name               = "ipset"
  description        = "Example IP set"
  scope              = "REGIONAL"
  ip_address_version = "IPV4"
  addresses          = ["172.16.8.133/22"] #예시


  tags = {
    Tag1 = "Value1"
    Tag2 = "Value2"
  }
}


# Regex pettern set
resource "aws_wafv2_regex_pattern_set" "regex-pattern-set" {
  name        = "regex-pattern-set"
  description = "Example regex pattern set"
  scope       = "REGIONAL"


  regular_expression {
    regex_string = "one" # 정규 표현식 문자열
  }


  regular_expression {
    regex_string = "two"
  }


  tags = {
    Tag1 = "Value1"
    Tag2 = "Value2"
  }
}

# web acls : web acl rules
resource "aws_wafv2_web_acl" "managed-rule-example" {
  name        = "managed-rule-example"
  description = "Example of a managed rule."
  scope       = "REGIONAL"

  default_action {
    allow {}
  }

  rule {
    name     = "rule-1"
    priority = 1

    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"

        rule_action_override {
          action_to_use {
            count {}
          }

          name = "SizeRestrictions_QUERYSTRING"
        }

        rule_action_override {
          action_to_use {
            count {}
          }

          name = "NoUserAgent_HEADER"
        }

        scope_down_statement {
          geo_match_statement {
            country_codes = ["KR","US"] #요청이 해당국가에서 발생한 경우만 허용
          }
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "friendly-rule-metric-name"
      sampled_requests_enabled   = false
    }
  }

  tags = {
    Tag1 = "Value1"
    Tag2 = "Value2"
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "friendly-metric-name"
    sampled_requests_enabled   = false
  }
}

# rate based rule
resource "aws_wafv2_web_acl" "rate-based-rule" {
  name        = "rate-based-rule"
  description = "Test of a managed rule"
  scope       = "REGIONAL"


  default_action {
    block {}
  }


  rule {
    name     = "rateLimitRule"
    priority = 0


    action {
      count {}
    }

    statement {
      rate_based_statement {
        limit              = 1000
        aggregate_key_type = "IP"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "friendly-metric-name"
      sampled_requests_enabled   = false
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "friendly-metric-name"
    sampled_requests_enabled   = false
  }
}

  
 
#waf associate
resource "aws_wafv2_web_acl_association" "managed-rules" {
  resource_arn = aws_lb.sesac_alb.arn  
  web_acl_arn  = aws_wafv2_web_acl.managed-rule-example.arn  
}



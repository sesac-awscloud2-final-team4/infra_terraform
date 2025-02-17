resource "aws_cloudtrail" "project-cloudtrail" {
  depends_on = [aws_s3_bucket_policy.project-cloudtrail]

  name                          = "project-cloudtrail"
  s3_bucket_name                = aws_s3_bucket.project-cloudtrail.id
  s3_key_prefix                 = "prefix"
  include_global_service_events = false
}

resource "aws_s3_bucket" "project-cloudtrail" { 
  bucket        = "project-cloudtrail"
  force_destroy = true
}

data "aws_iam_policy_document" "project-cloudtrail" {
  statement {
    sid    = "AWSCloudTrailAclCheck"
    effect = "Allow"


    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }


    actions   = ["s3:GetBucketAcl"]
    resources = [aws_s3_bucket.project-cloudtrail.arn]
    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = ["arn:${data.aws_partition.current.partition}:cloudtrail:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:trail/project-cloudtrail"]
    }
  }


  statement {
    sid    = "AWSCloudTrailWrite"
    effect = "Allow"


    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }


    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.project-cloudtrail.arn}/prefix/AWSLogs/${data.aws_caller_identity.current.account_id}/*"]


    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = ["arn:${data.aws_partition.current.partition}:cloudtrail:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:trail/project-cloudtrail"]
    }
  }
}


resource "aws_s3_bucket_policy" "project-cloudtrail" {
  bucket = aws_s3_bucket.project-cloudtrail.id
  policy = data.aws_iam_policy_document.project-cloudtrail.json
}


data "aws_caller_identity" "current" {}


data "aws_partition" "current" {}


data "aws_region" "current" {}




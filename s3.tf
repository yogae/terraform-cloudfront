data "aws_s3_bucket" "cloudfront_origin_bucket" {
  bucket = "${var.origin_bucket_name}"
}

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "${var.origin_bucket_name}-oai"
}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${data.aws_s3_bucket.cloudfront_origin_bucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn}"]
    }
  }

  statement {
    actions   = ["s3:ListBucket"]
    resources = ["${data.aws_s3_bucket.cloudfront_origin_bucket.arn}"]

    principals {
      type        = "AWS"
      identifiers = ["${aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn}"]
    }
  }
}


resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  bucket = "${data.aws_s3_bucket.cloudfront_origin_bucket.id}"
  policy = "${data.aws_iam_policy_document.s3_policy.json}"
}

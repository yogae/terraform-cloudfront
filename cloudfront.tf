locals {
  s3_origin_bucket_id = "s3-${data.aws_s3_bucket.cloudfront_origin_bucket.id}"
}
resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = "${data.aws_s3_bucket.cloudfront_origin_bucket.bucket_regional_domain_name}"
    origin_id   = "${local.s3_origin_bucket_id}"

    s3_origin_config {
      origin_access_identity = "${aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path}"
    }
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "${local.s3_origin_bucket_id}"
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    lambda_function_association {
      event_type   = "origin-response"
      lambda_arn   = "${data.aws_lambda_function.resize_lambda_edge.qualified_arn}"
      include_body = false
    }
  }

  price_class = "PriceClass_200"
  enabled     = true
  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    stage = "dev"
  }
}

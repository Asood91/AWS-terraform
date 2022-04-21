resource "aws_s3_bucket" "s3" {
  bucket = "tf_aws_s3-cloudfront"
}

## to give access to S3 from CF, an OAI is required in S3 policy 
resource "aws_s3_bucket_policy" "s3policy" {
  bucket = aws_s3_bucket.s3.id
  policy = data.aws_iam_policy_document.s3policy.json
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  enabled = true
  default_root_object = "index.html"
  origin {
      domain_name = aws_s3_bucket.s3.bucket_regional_domain_name
      origin_id = aws_s3_bucket.s3.bucket_regional_domain_name


      ## restirting access to s3 from cloudffront
      s3_origin_config {
        origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
      }
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD", "OPTIONS"]
    target_origin_id       = aws_s3_bucket.s3.bucket_regional_domain_name
    viewer_protocol_policy = "redirect-to-https"
    forwarded_values {
      query_string = false
      headers      = ["Origin"]

      cookies {
        forward = "none"
      }
    }

  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE"]
    }
  }  
    
  ## true if not using aliases, otherwise need ACM details  
  viewer_certificate {
    cloudfront_default_certificate = true
      }
 } 


## to give access to S3 from CF, an OAI is required in S3 policy 
resource "aws_cloudfront_origin_access_identity" "oai" {
    comment = "OAI for CF"
}

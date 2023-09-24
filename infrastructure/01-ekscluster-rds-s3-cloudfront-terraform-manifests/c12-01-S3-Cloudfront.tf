resource "aws_cloudfront_origin_access_identity" "cloudfront_oia" {
  comment = "Ethan origin access identify"
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.deploy_bucket.id  
#  policy = data.aws_iam_policy_document.bucket_policy.json  

policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${var.bucket_name}/*"
        },        
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "${aws_cloudfront_origin_access_identity.cloudfront_oia.iam_arn}"
            },
            "Action": [
                "s3:ListBucket",
                "s3:GetObjectAcl",
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::${var.bucket_name}/*",
                "arn:aws:s3:::${var.bucket_name}"
            ]
        }
    ]
}
POLICY


} 

# data "aws_iam_policy_document" "bucket_policy" {
#   statement {
#     principals {
#       type        = "AWS"
#       identifiers = ["${aws_cloudfront_origin_access_identity.cloudfront_oia.iam_arn}"]
#     }

#     actions = [
#       "s3:GetObject",
#       "s3:GetObjectAcl",
#       "s3:ListBucket",
#     ]

#     resources = [ 
#       "${aws_s3_bucket.deploy_bucket.arn}",
#       "${aws_s3_bucket.deploy_bucket.arn}/*",
#       ]
#   }
# }


resource "aws_s3_bucket" "deploy_bucket" {
  bucket = var.bucket_name
 # acl    = "public-read"

#   website {
#     index_document = "index.html"
#     error_document = "index.html"
#   }
 }

resource "aws_s3_bucket_website_configuration" "bucket_config" {
  bucket = aws_s3_bucket.deploy_bucket.bucket
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "index.html"
  }

  
}



resource "aws_cloudfront_distribution" "website_cdn" {
  enabled = true  

  origin {
    origin_id   = "origin-bucket-${aws_s3_bucket.deploy_bucket.id}"
    domain_name = aws_s3_bucket.deploy_bucket.website_endpoint

    custom_origin_config {
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "DELETE", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods         = ["GET", "HEAD"]
    min_ttl                = "0"
    default_ttl            = "300"
    max_ttl                = "1200"
    target_origin_id       = "origin-bucket-${aws_s3_bucket.deploy_bucket.id}"
    viewer_protocol_policy = "redirect-to-https"
    compress               = true

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}


output "website_cdn_id" {
  value = aws_cloudfront_distribution.website_cdn.id
}

output "website_endpoint" {
  value = aws_cloudfront_distribution.website_cdn.domain_name
}

output "s3_bucketname" {
  description = "S3 bucket name for frontend"
  value       = var.bucket_name
}

# terraform cloudfront

## 구성

* Lambda
* CloudFront
  * query string: true
  * lambda@Edge
* S3

## 주의사항

* terraform에서 lambda@edge를 설정 시 us-east-1에 배포된 lamdba를 사용

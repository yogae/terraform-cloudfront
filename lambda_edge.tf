data "aws_lambda_function" "resize_lambda_edge" {
  function_name = "${var.resize_lambda_edge.name}"
  qualifier     = "${var.resize_lambda_edge.version}"

  provider = aws.us_east_1
}

resource "aws_s3_bucket" "vault_backend" {
  bucket = "vault_backend"
  acl    = "private"
}

data "aws_iam_policy_document" "vault_backend" {
  statement {
    actions = ["s3:*"]
    resources = [aws_s3_bucket.vault_backend.arn]
    effect = "Allow"
  }
}

resource "aws_iam_policy" "vault_backend" {
  name = "vault_backend"
  description = "IAM policy allowing Vault to leverage an S3 backend"
  policy = data.aws_iam_policy_document.vault_backend.json
}

resource "aws_iam_user" "vault_backend" {
  name = "vault_backend"
}

resource "aws_iam_user_policy_attachment" "vault_backend" {
  user       = aws_iam_user.vault_backend.name
  policy_arn = aws_iam_policy.vault_backend.arn
}

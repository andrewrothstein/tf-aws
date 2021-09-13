resource "aws_secretsmanager_secret" "vault_unseal" {
  name = "vault_backend_unseal_key"
}

data "aws_iam_policy_document" "vault_unseal" {
  statement {
    actions = ["secretsmanager:*"]
    resources = [aws_secretsmanager_secret.vault_unseal.arn]
    effect = "Allow"
  }
}

resource "aws_iam_policy" "vault_unseal" {
  name = "vault_unseal"
  description = "IAM policy allowing Vault unsealer to use SecretsManager"
  policy = data.aws_iam_policy_document.vault_unseal.json
}

resource "aws_iam_user" "vault_unseal" {
  name = "vault_unseal"
}

resource "aws_iam_user_policy_attachment" "vault_unseal" {
  user = aws_iam_user.vault_unseal.name
  policy_arn = aws_iam_policy.vault_unseal.arn
}

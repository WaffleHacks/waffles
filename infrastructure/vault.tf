/*
    AWS accounts and groups for Hashicorp Vault
*/
resource "aws_iam_group" "vault" {
  name = "vault"
  path = "/wafflehacks/"
}

resource "aws_iam_policy" "vault" {
  name        = "wafflehacks-vault"
  description = "Gives necessary permissions for HashiCorp Vault to manage AWS users"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "iam:AddUserToGroup",
          "iam:AttachUserPolicy",
          "iam:CreateAccessKey",
          "iam:CreateUser",
          "iam:DeleteAccessKey",
          "iam:DeleteUser",
          "iam:DeleteUserPolicy",
          "iam:DetachUserPolicy",
          "iam:ListAccessKeys",
          "iam:ListGroupsForUser",
          "iam:ListUserPolicies",
          "iam:RemoveUserFromGroup"
        ]
        Resource = [
          "arn:aws:iam::${data.aws_caller_identity.current.account_id}:group/*",
          "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/vault-*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "iam:CreateAccessKey",
          "iam:DeleteAccessKey",
          "iam:GetUser"
        ]
        Resource = [
          "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/wafflehacks/vault/$${aws:username}"
        ]
      }
    ]
  })
}

resource "aws_iam_group_policy_attachment" "vault-attachment" {
  group      = aws_iam_group.vault.name
  policy_arn = aws_iam_policy.vault.arn
}

resource "aws_iam_user" "vault" {
  name = "primary"
  path = "/wafflehacks/vault/"
}

resource "aws_iam_access_key" "vault" {
  user = aws_iam_user.vault.name
}

resource "aws_iam_user_group_membership" "vault-group" {
  user = aws_iam_user.vault.name

  groups = [
    aws_iam_group.vault.name
  ]
}

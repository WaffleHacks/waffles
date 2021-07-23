/*
  AWS access key for Vault
*/
output "aws_vault_credentials" {
  value = {
    access_key = aws_iam_access_key.vault.id,
    secret_key = aws_iam_access_key.vault.secret
  }
  sensitive   = true
  description = "The credentials to use for the Vault instance"
}

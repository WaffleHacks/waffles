# Waffles

Waffles is the complementary repository to our deployment abstraction layer [WaffleMaker](https://github.com/WaffleHacks/wafflemaker).
All the services currently running for WaffleHacks are specified here and deployed automatically on push. An example service can be 
found [here](https://github.com/WaffleHacks/wafflemaker/tree/master/example-service.toml).

This repository also contains the infrastructure definitions such as servers and DNS records specified using [Terraform](https://terraform.io).
Our infrastructure is updated automatically as well using [Terraform Cloud](https://app.terraform.io).

# Before you start deploying Controller and Copilot

Subcribe to:

https://aws.amazon.com/marketplace/pp/prodview-nsys2ingy6m3w?qid=1627375660123

https://aws.amazon.com/marketplace/pp/prodview-hr74smekrfqiu?qid=1627375694838


Make sure that there is no existing AWS Console > IAM  aviatrix-role-ec2 / aviatrix-role-app / aviatrix-assume-role-policy / aviatrix-app-policy


Terraform will create:
- VPC + 2 public subnets in two seperate AZ

- Controller and Copilot Security Group

- IAM Roles/Policies

- Aviatrix Controller

- Aviatrix Copilot (CPLT BYOL ami in eu-central-1)

# terraform-aws-ecs-terragrunt

1. Edit pipe4.yml

2. Run
```
python3 pipe4.py
```
Skeleton
```
.
|____webapps
| |____dev
| | |____us-east-1
| | | |____ecs
| | | | |____api
| | | | | |____app-api
| | | | | | |____main.tf
| | | | | | |____terragrunt.hcl
| | | | | | |____terraform.tfvars
| | | | | |____main.tf
| | | | | |____terragrunt.hcl
| | | | | |____terraform.tfvars
| | | | |____front
| | | | | |____main.tf
| | | | | |____terragrunt.hcl
| | | | | |____terraform.tfvars
| | | | | |____app-front
| | | | | | |____main.tf
| | | | | | |____terragrunt.hcl
| | | | | | |____terraform.tfvars
```


## GIT branchs

### Branch [main]

Controlled by Atlantis, new format.

### Branch [development]

Managed with terraform binary, old format.


## Branch [development] Usage

### Requirements

*terraform version* >= `1.0.0`        [Download](https://www.terraform.io/downloads.html)

*aws cli*                             [Download](https://aws.amazon.com/cli/)



### Code changes

```
## Clone repo code
git clone -b <GIT_BRANCH> <GIT_PROJECT>

## Create a new local branch
git checkout -b <YOUR_NEW_BRANCH>
```

Usually *GIT_BRANCH* is `main` or `master`.

*GIT_PROJECT* you copy it from Github -> <Repository> -> *Code* green button


*YOUR_NEW_BRANCH* has a good practice on prefixing it with:
- hotfix/<MEANING_BRANCH_NAME>
- feature/<MEANING_BRANCH_NAME>

*hotfix* for fixes
*feature*  for new features


After code changes:

- `terraform validate`
- `terraform fmt`
- `terraform plan -var-file=<ENV_NAME>.tfvars`

If its ok, then:

1. `git status`
2. `git add <CHANGED_FILES>`
3. `git commit -m "MEANING COMMIT MESSAGE"`
4. `git push origin <YOUR_NEW_BRANCH>`
5. Click on *Open Pull* request link that is showed, or go thru Github website
6. Pull request peer review
7. Merge
8. terraform apply from master branch


### Terraform run

These are temporary credentials, you must get it again from time to time.

Export it or use with credentials file/profile.


```
## Show workspaces
terraform workspace list

## Select the one you want to work on
terraform workspace select <WORKSPACE_NAME>

## Plan changes
terraform plan -var-file=<ENV_NAME>.tfvars

## Apply changes
terraform apply -var-file=<ENV_NAME>.tfvars

```

Little help, checking AWS cli caller, if you need to check:
```
aws sts get-caller-identity
```

### Terraform lock

If for some reason, there is a stuck lock on dynamodb, that is no longer in use, you can force remove that.

```
terraform force-unlock <LOCKID>
```

```
$ terraform plan -var-file=development.tfvars
Acquiring state lock. This may take a few moments...

```

#### Plan without locking

```
terraform plan -var-file=terraform.tfvars -lock=false
```

```

#### Upgrading local providers

This is on your workstation.

```
terraform init -upgrade

```


#### Setup AWS and Terraform

Create role:

```
Role: terraform_admin_role
Policy: AdministratorAccess
Trusted entities: arn:aws:iam:::role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_AdministratorAccess_BlaBlaBlaBlaBla
```

Create workspace:

```
terraform workspace new <WORKSPACE_NAME>
```

##### Lock table

Create it on DynamoDb table at Gp webapp SHR account.

Table:

```
Table name: s_terraform_lock
Primary key: LockID
Type: String
```




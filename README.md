# Terraform AWS EC2 with Portainer Agent

**Note: I take no responsibility for anyone executing this terraform**

## Description

I've copied this from [Kevin Vogel](https://medium.com/@hellokevinvogel) article series on Medium:  

- [Why You Should Use Terraform | by Kevin Vogel](https://levelup.gitconnected.com/devops-why-you-should-use-terraform-667f0411e383)
- [How To Create An EC2 Instance With Terraform | by Kevin Vogel](https://levelup.gitconnected.com/devops-how-to-create-an-ec2-instance-with-terraform-a1f8285ee5f7)

## Run

```bash
# init modules
$ terraform init

# validate configuration
$ terraform validate

# plan configuration
$ terraform plan

# apply configuration
$ terraform apply

# Change key permissions
chmod 400 ./key.pem

# Access your instance through ssh
ssh -i "key.pem" ubuntu@<YOUR_INSTANCE_PUBLIC_IP>

# Verify everything was installed properly
cat /var/log/cloud-init-output.log

# destroy configuration
$ terraform destroy
```


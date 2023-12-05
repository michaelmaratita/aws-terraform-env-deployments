# Terraform Automated EC2 Deployments

## **Overview**
In this scenario, the objective is to leverage Terraform and Python to create multiple Virtual Private Clouds (VPCs) along with associated EC2 instances based on specifications provided in a Excel (XLSX) file. Terraform will automate the provisioning of infrastructure, ensuring consistency and ease of management.

## **Scenario**

### **Goal**

The goal is to deploy three distinct VPCs, each containing a specified number of EC2 instances, as outlined in the CSV file. The CSV file serves as a configuration document, detailing the specifications of EC2 instances for each VPC.

### **XLSX Format**

**VPC Tab**

The current configuration utilizes these columns to define the infrastructure for the VPC

- Name
- CIDR
- Private Subnet (x2)
- Public Subnet (x2)

**EC2 Tab**

The current configuration utilizes these columns to define the infrastructure for each EC2 instance.

- Name
- Instance Type
- Root Volume Size
- Data Volume Size
- Environment
- Server Type
- Operating System
- Availability Zone

### **Python Execution**

Parses the XLSX and define python dictionaries for VPC and EC2 using Pandas module

1. **Variables File Creation**
    - From the dicitonaries defined, those values are passed to custom functions that
    create formatted strings that the `variables.tf` expects:
    - The `variables.tf` is created if none exist, or appends an existing file.

```tf
variable "instance_metadata_option" {
  type = map(string)
}
variable "vpc_name" {
  type = object({
    Development = object({
      cidr = string
      private_subnet = list(string)
      public_subnet = list(string)
    })
  })
}
variable "public_ec2_name" {
  type = object({
    dev-app-linux1 = object({
      ami = string
      public_ip = bool
      availability_zone = string
      environment = string
      instance_type = string
      key_name = string
      monitoring = bool
      root_volume = object({
        delete_on_termination = bool
        encrypted = bool
        volume_size = number
      })
      subnet_id = number
    })
  })
}
```

**TFVARS File Creation**
    - much like the `variables.tf`, the `terraform.tfvars` is created using custom
    formatting functions to format string values the `tfvars` file expects.

### **Terraform Execution**

1. **VPC Creation**
    - Define Terraform configurations for VPC/Subnet creation, incorporating CIDR blocks and subnets.
    - Implement Terraform code to create VPCs based on the provided specifications.
2. **EC2 Instances**
    - Leverage Terraform to create the specified EC2 instances within the corresponding VPCs.

### **Execution Instructions**

1. **Configure Permissions for AWS CLI**
    - Ensure AWS CLI is configured with credentials that are authorized to create EC2 instances, Volumes, and VPCs/Subnets
2. **Configure Terraform**
    - Ensure Terraform is installed on the machine that will perform the Terraform creations. 
3. **CSV File Input:**
    - Replace the example XLSX file with your own, ensuring it follows the provided format.
4. **Terraform Initialization:**
    - Run `terraform init` to initialize the Terraform project.
5. **Terraform Execution:**
    - Execute `terraform apply` to create the VPCs and EC2 instances based on the XLSX file.

### **Clean Up**

After completing the testing and validation of the infrastructure, run `terraform destroy`
to tear down the created resources.
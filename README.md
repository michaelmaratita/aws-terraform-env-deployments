# Terraform Automated EC2 Deployments

## **Overview**
In this scenario, the objective is to leverage Terraform and Python to create multiple Virtual Private Clouds (VPCs) along with associated EC2 instances based on specifications provided in a CSV (Comma-Separated Values) file. Terraform will automate the provisioning of infrastructure, ensuring consistency and ease of management.

## **Scenario**

### **Goal**

The goal is to deploy three distinct VPCs, each containing a specified number of EC2 instances, as outlined in the CSV file. The CSV file serves as a configuration document, detailing the specifications of EC2 instances for each VPC.

### **CSV Format**

The CSV file should have the following structure:

```csv
Name,Instance_Type,Root_Volume,Data_Volume,Environment_Tag,Server_Type_Tag,OS_Type_Tag,Availability-Zone
```
1. Name
2. Instance Type
3. Root Volume Size (int)
4. Data Volume Size (int)
5. Environment Tag, e.g. Development, Test, PreProduction, Production
5. Server Type Tag, e.g. Application, Database
6. OS Tag, e.g. Linux, Windows
7. Availability-Zone, e.g. us-west-1a, us-west-1b

### **Python Execution**

1. **EC2 Resource TF File Creation**
    - Parse the CSV file to extract EC2 details.
    - Implement Terraform code to create VPCs based on the provided specifications.
    - Create [resource-ec2.tf](resource-ec2.tf) with each EC2 instance resource

### **Terraform Execution**

1. **VPC Creation**
    - Define Terraform configurations for VPC/Subnet creation, incorporating CIDR blocks and subnets.
    - Implement Terraform code to create VPCs based on the provided specifications.
2. **EC2 Instances**
    - Leverage Terraform to create the specified EC2 instances within the corresponding VPCs.

### **Execution Instructions**

1. **CSV File Input:**
    - Replace the example CSV 


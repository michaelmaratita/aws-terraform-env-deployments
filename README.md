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

1. **Configure Permissions for AWS CLI**
    - Ensure AWS CLI is configured with credentials that are authorized to create EC2 instances, Volumes, and VPCs/Subnets
2. **Configure Terraform**
    - Ensure Terraform is installed on the machine that will perform the Terraform creations. 
3. **CSV File Input:**
    - Replace the example CSV file with your own, ensuring it follows the provided format.
4. **Terraform Initialization:**
    - Run `terraform init` to initialize the Terraform project.
5. **Terraform Execution:**
    - Execute `terraform apply` to create the VPCs and EC2 instances based on the CSV file.

### **CSV File Cusomization**

Modify the CSV file according to your specific requirements, and if additional parameters
need to be met, ensure to modify the `read_csv` function in [functions.py](functions.py).

Additional parameters can be annotated by "**...**" within the code block below:

```python
ec2 = {
    value[0] : {
        "Instance Type" : value[1],
        "Root Volume" : value[2],
        "Data Volume" : value[3],
        "Environment" : value[4],
        "Server Type" : value[5],
        "OS" : value[6],
        "Availability-Zone" : value[7]
        ...
        ...
    }
}
```

### **Clean Up**

After completing the testing and validation of the infrastructure, run `terraform destroy`
to tear down the created resources.
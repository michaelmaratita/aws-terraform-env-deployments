import csv
import os


def read_csv(csv_path):
    ec2_vals = {}
    with open(csv_path, 'r') as csv_file:
        next(csv_file) # header lines
        values_list = csv.reader(csv_file)
        for value in values_list:
            ec2 = {
                value[0] : {
                    "Instance Type" : value[1],
                    "Root Volume" : value[2],
                    "Data Volume" : value[3],
                    "Environment" : value[4],
                    "Server Type" : value[5],
                    "OS" : value[6],
                    "Availability-Zone" : value[7]
                }
            }
            ec2_vals.update(ec2)
    return ec2_vals

def tf_resource(ec2_vals):
    for ec2_instance in ec2_vals:
        server_name = ec2_instance
        instance_type = ec2_vals[ec2_instance]["Instance Type"]
        root = ec2_vals[ec2_instance]["Root Volume"]
        env = ec2_vals[ec2_instance]["Environment"]
        availability_zone = ec2_vals[ec2_instance]["Availability-Zone"]
        server_type = ec2_vals[ec2_instance]["Server Type"]
        ami = get_ami(ec2_vals[ec2_instance]["OS"])
        key = get_key(ec2_vals[ec2_instance]["OS"])
        subnet_id = get_subnet(env, availability_zone, server_type)
        
        tf_resource =f'resource "aws_instance" "{server_name}" ' + '{\n\t' + \
                f'ami = {ami}\n\tinstance_type = "{instance_type}"\n\tsub' + \
                f'net_id = {subnet_id}\n\tkey_name = {key}\n\troot_block_' + \
                f'device '+ '{\n\t\tdelete_on_termination = true\n\t\tencry' + \
                f'pted = true\n\t\tvolume_size = {root}\n\n\t\t' + 'tags = ' + \
                '{' + f'\n\t\t\tName = "{server_name}"\n\t\t\tEnvironment =' + \
                f' "{env}"\n\t\t' + '}\n\t}\n\n\ttags = {\n\t\tName = "' + \
                f'{server_name}"\n\t\tEnvironment = "{env}"\n' + '\t}\n}'
        create_ec2_tf(tf_resource)

def get_ami(OS):
    ami_dict = {
        "Linux" : "var.linux_ami",
        "Windows": "var.windows_ami"
    }
    return ami_dict[OS]

def get_key(OS):
    key_dict = {
        "Linux" : "var.linux_key",
        "Windows": "var.windows_key"
    }
    return key_dict[OS]

def get_subnet(environment, availability_zone, server_type):
    subnet_dict = {
        "Development" : {
            "us-west-1a" : {
                "Application" : "aws_subnet.dev_app_subnet1.id",
                "Database" : "aws_subnet.dev_db_subnet1.id"
            },
            "us-west-1b" : {
                "Application" : "aws_subnet.dev_app_subnet2.id",
                "Database" : "aws_subnet.dev_db_subnet2.id"
            }
        },
        "Test" : {
            "us-west-1a" : {
                "Application" : "aws_subnet.test_app_subnet1.id",
                "Database" : "aws_subnet.test_db_subnet1.id"
            },
            "us-west-1b" : {
                "Application" : "aws_subnet.test_app_subnet2.id",
                "Database" : "aws_subnet.test_db_subnet2.id"
            }
        },
        "PreProd" : {
            "us-west-1a" : {
                "Application" : "aws_subnet.preprod_app_subnet1.id",
                "Database" : "aws_subnet.preprod_db_subnet1.id"
            },
            "us-west-1b" : {
                "Application" : "aws_subnet.preprod_app_subnet2.id",
                "Database" : "aws_subnet.preprod_db_subnet2.id"
            }
        }
    }
    return subnet_dict[environment][availability_zone][server_type]

def create_ec2_tf(tf_resource):
    
    file_path = 'E:\\GitHub\\aws-terraform-env-deployments\\resource-ec2.tf'
        
    tf_isfile = os.path.isfile(file_path)
    if tf_isfile:
        tf = open(file_path, 'a')
        tf.write("\n" + tf_resource)
        tf.close()
    else:
        tf = open(file_path, 'w')
        tf.write(tf_resource)
        tf.close()
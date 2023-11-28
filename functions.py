import csv
import os


def read_csv(csv_path):
    ec2_vals = {}
    with open(csv_path, 'r') as csv_file:
        next(csv_file) # Skip Name, Type, Size lines
        values_list = csv.reader(csv_file)
        for value in values_list:
            
            ec2 = {
                value[0] : {
                    "Instance Type" : value[1],
                    "Size" : value[2],
                    "Resource" : value[3]
                }
            }
            ec2_vals.update(ec2)
    return ec2_vals

def tf_resource(ec2_vals):
    for ec2_instance in ec2_vals:
        server_name = ec2_instance
        instance_type = ec2_vals[ec2_instance]["Instance Type"]
        resource = ec2_vals[ec2_instance]["Resource"]
        tf_resource =f'resource "aws_instance" "{server_name}" ' + '{' + \
                '\n\tami = "ami-06e4ca05d431835e9"' + \
                f'\n\tinstance_type = "{instance_type}"' + \
                '\n\tsubnet_id = aws_subnet.development_subnet.id' + \
                f'\n\tkey_name = "test_linux"' + \
                '\n\troot_block_device {' + \
                '\n\t\tdelete_on_termination = true' + \
                '\n\t\tencrypted = true' + \
                '\n\t\tvolume_size = 10' + \
                '\n' + \
                '\n\t\ttags = {' + \
                f'\n\t\t\tName = "{server_name}"' + \
                f'\n\t\t\tEnvironment = "{resource}"' + \
                '\n\t\t}' + \
                '\n\t}' + \
                '\n' + \
                '\n\ttags = {' + \
                f'\n\t\tName = "{server_name}"' +\
                '\n\t\tEnvironment = "Development"' +\
                '\n\t}' + \
                '\n}'
        create_ec2_tf(tf_resource)

def create_ec2_tf(tf_resource):
    
    file_path = 'E:\\GitHub\\aws-terraform-env-deployments\\resource-ec2.tf'
        
    tf_isfile = os.path.isfile(file_path)
    if tf_isfile:
        tf = open(file_path, 'a')
        tf.write("\n\n" + tf_resource)
        tf.close()
    else:
        tf = open(file_path, 'w')
        tf.write(tf_resource)
        tf.close()
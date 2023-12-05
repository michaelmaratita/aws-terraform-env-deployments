import pandas as pd
import os


def main():
    vpc_dict, ec2_dict = read_excel_to_dict("vpc_ec2.xlsx")
    variables_file(vpc_dict, ec2_dict)
    tfvars_file(vpc_dict, ec2_dict)

def create_tf_file(file_entry, file_path):
    tf_isfile = os.path.isfile(file_path)
    if tf_isfile:
        tf = open(file_path, 'a')
        tf.write("\n" + file_entry)
        tf.close()
    else:
        tf = open(file_path, 'w')
        tf.write(file_entry)
        tf.close()

def get_additional_tfvars():
    var_str = 'region = "us-west-1"\navailability-zones = ["us-west-1a", "u' + \
    's-west-1b"]\n'
    return var_str

def get_additional_variables():
    var_str = 'variable "region" {\n  type = string\n}\nvariable "availabi' + \
    'lity-zones" {\n  type = list(string)\n}\nvariable "instance_metadata_o' + \
    'ption" {\n  type = map(string)\n}\n'
    return var_str

def get_ami(operating_system):
    ami_dict = {
        "Linux" : "ami-06e4ca05d431835e9",
        "Windows" : "ami-00e4817e2aba98c93"
    }
    return ami_dict[operating_system]

def get_ec2_keys(ec2_dict, server):
    i_type = ec2_dict[server]["Instance Type"]
    root_vol = ec2_dict[server]["Root Volume"]
    Environment = ec2_dict[server]["Environment"]
    s_type = ec2_dict[server]["Server Type"]
    OS = ec2_dict[server]["OS"]
    az = ec2_dict[server]["Availability Zone"]
    return i_type, root_vol, Environment, s_type, OS, az

def get_ec2_tfvars_str(ec2_dict):
    app_str = ''
    db_str = ''
    for server in ec2_dict:
        vars = get_ec2_variables(ec2_dict, server)
        if vars[3] == "Application":
            app_str += ec2_tfvars_str(server, vars)
        else:
            db_str += ec2_tfvars_str(server, vars)
    ec2_str = 'public_ec2_name = {\n' + app_str + '}\nprivate_ec2_name = {' + \
    '\n' + db_str + '}'
    return ec2_str

def ec2_tfvars_str(server, vars):
    ec2_str = f'\t{server} = ' + '{\n\t\tami = "' + f'{vars[6]}"\n\t\t' + \
        f'public_ip = {vars[7]}\n\t\tavailability_zone = "{vars[5]}"\n\t\te' + \
        f'nvironment = "{vars[2]}"\n\t\tinstance_type = "{vars[0]}"\n\t\tke' + \
        f'y_name = "{vars[8]}"\n\t\tmonitoring = true\n\t\troot_volume = ' + \
        '{\n\t\t\tdelete_on_termination = true\n\t\t\tencrypted = true\n\t' + \
        f'\t\tvolume_size = {vars[1]}\n\t\t' + '}' + \
        f'\n\t\tsubnet_id = {vars[9]}\n\t' + '}\n'
    return ec2_str

def get_ec2_variables_str(ec2_dict):
    app = ''
    db = ''
    for server in ec2_dict:
        vars = get_ec2_variables(ec2_dict, server)
        if vars[3] == "Application":
            app += ec2_variables_str(server)
        else:
            db += ec2_variables_str(server)
    ec2_str = 'variable "public_ec2_name" {\n  type = object({\n' + app + \
    '  })\n}\nvariable "private_ec2_name" {\n  type = object({\n' + db + \
    '  })\n}'
    return ec2_str

def ec2_variables_str(server):
    e_str = f'    {server} = object(' + '{\n      ami = string\n      publ' + \
        'ic_ip = bool\n      availability_zone = string\n      environment ' + \
        '= string\n      instance_type = string\n      key_name = string\n ' + \
        '     monitoring = bool\n      root_volume = object({\n        dele' + \
        'te_on_termination = bool\n        encrypted = bool\n        volume' + \
        '_size = number\n      })\n      subnet_id = number\n    })\n'
    return e_str

def get_ec2_variables(ec2_dict, server):
    i, rv, e, s, oper_sys, az = get_ec2_keys(ec2_dict, server)
    ami = get_ami(oper_sys)
    public_ip = get_ip_bool(s)
    key = get_env_key(e, oper_sys)
    subnet_id = get_subnet_id(az)
    return i, rv, e, s, oper_sys, az, ami, public_ip, key, subnet_id

def get_env_key(environment, operating_system):
    key_dict = {
        "Development" : {
            "Linux"   : "test_linux",
            "Windows" : "test_windows"
        },
        "Test"        : {
            "Linux"   : "test_linux",
            "Windows" : "test_windows"
        },
        "PreProd"     : {
            "Linux"   : "test_linux",
            "Windows" : "test_windows"
        },
        "Production"  : {
            "Linux"   : "test_linux",
            "Windows" : "test_windows"
        }
    }
    return key_dict[environment][operating_system]

def get_inst_str():
    i = 'instance_metadata_option = {\n\t"http_endpoint": "enabled",\n\t"ht' + \
    'tp_put_response_hop_limit": 1,\n\t"http_tokens": "required"\n}'
    return i

def get_ip_bool(server_type):
    ip_bool_dict = {
        "Application" : "true", 
        "Database"    : "false"
    }
    return ip_bool_dict[server_type]

def get_subnet_id(availability_zone):
    id = {
        "us-west-1a" : 0,
        "us-west-1b" : 1
    }
    return id[availability_zone]

def get_vpc_keys(vpc_dict):
    for environment in vpc_dict:
        k1 = list(vpc_dict[environment])[0]
        k2 = list(vpc_dict[environment])[1]
        k3 = list(vpc_dict[environment])[3]
    return k1, k2, k3

def get_vpc_lower_keys(vpc_dict):
    new_list = list(get_vpc_keys(vpc_dict))
    val_list = []
    for i in new_list:
        val_list.append(i.replace(' ', '_').lower())
    return(val_list)

# fix vpc_str to go full len
def get_vpc_variables_str(vpc_dict):
    k1, k2, k3 = get_vpc_lower_keys(vpc_dict)
    vpc_str = ''
    for environment in vpc_dict:
        vpc_str += f'    {environment} = object(' + '{\n      ' + \
        f'{k1} = string\n' + f'      {k2} = list(string)\n      ' + \
        f'{k3} = list(string)' + '\n    })\n'
    vpc_str = 'variable "vpc_name" {\n  type = object({\n' + vpc_str + '  })\n}'
    return vpc_str

# fix vpc_str to go full len
def get_vpc_tfvars_str(vpc_dict):
    vpc_str = ''
    k1, k2, k3 = get_vpc_lower_keys(vpc_dict)
    for env in vpc_dict:
        cidr, priv_subnet, pub_subnet = get_vpc_tfvars_vals(vpc_dict, env)
        vpc_str += f'\n\t{env} = ' + '{\n\t' + \
            f'  {k1} = "{cidr}"\n\t  {k2} = {priv_subnet}\n\t' + \
            f'  {k3} = {pub_subnet}\n\t' + \
            '}'
    vpc_str = 'vpc_name = {' + vpc_str.replace("'", '"') + '\n}'
    return vpc_str

def get_vpc_tfvars_vals(vpc_dict, environment):
    k1, k2, k3 = get_vpc_keys(vpc_dict)
    cidr = vpc_dict[environment][k1]
    private_subnet = [vpc_dict[environment][k2],
                        vpc_dict[environment][f'{k2}.1']]
    public_subnet = [vpc_dict[environment][k3],
                        vpc_dict[environment][f'{k3}.1']]
    return cidr, private_subnet, public_subnet

def read_excel_to_dict(csv_path):
    df_vpc = pd.read_excel(csv_path, sheet_name='vpc')
    df_ec2 = pd.read_excel(csv_path, sheet_name = 'ec2')
    vpc_dict = df_vpc.set_index('Name').to_dict('index')
    ec2_dict = df_ec2.set_index('Name').to_dict('index')
    return vpc_dict, ec2_dict

def tfvars_file(vpc_dict, ec2_dict):
    file_path = 'E:\\GitHub\\aws-terraform-env-deployments\\terraform.tfvars'
    inst_str = get_inst_str()
    var_str = get_additional_tfvars()
    vpc_entry = get_vpc_tfvars_str(vpc_dict)
    ec2_entry = get_ec2_tfvars_str(ec2_dict)
    tfvars_entry = var_str + vpc_entry + '\n' + ec2_entry + '\n' + inst_str
    create_tf_file(tfvars_entry, file_path)

def variables_file(vpc_dict, ec2_dict):
    file_path = 'E:\\GitHub\\aws-terraform-env-deployments\\variables.tf'
    ec2_str = get_ec2_variables_str(ec2_dict)
    var_str = get_additional_variables()
    vpc_str = get_vpc_variables_str(vpc_dict)
    variables_str = var_str + vpc_str + '\n' + ec2_str
    create_tf_file(variables_str, file_path)

# if __name__ == '__main__':
#     main()
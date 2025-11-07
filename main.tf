provider "aws" {
    region = "ap-south-1"
}

variable "cidr" {
    default = "10.0.0.0/16"
  }

resource "aws_vpc" "my_VPC" {
    cidr_block = var.cidr
    instance_tenancy =  "default" 

    tags = {
      Name = "TrendStore-VPC"
    }
}

resource "aws_subnet" "pub_SUB_1" {
    vpc_id = aws_vpc.my_VPC.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "ap-south-1a"
    map_public_ip_on_launch = true
    
    tags = {
	    Name = "public-subnet-1"
	    "kubernetes.io/cluster/trendstore" = "shared"
	    "kubernetes.io/role/elb"           = "1"
	}
}

resource "aws_subnet" "pub_SUB_2" {
    vpc_id = aws_vpc.my_VPC.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-south-1c"
    map_public_ip_on_launch = true
    
    tags = {
	    Name = "public-subnet-2"
	    "kubernetes.io/cluster/trendstore" = "shared"
	    "kubernetes.io/role/elb"           = "1"
	}
}

resource "aws_subnet" "priv_SUB_1" {
    vpc_id = aws_vpc.my_VPC.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "ap-south-1b"
    
    tags = {
	    Name = "private-subnet-1"
	    "kubernetes.io/cluster/trendstore" = "shared"
	    "kubernetes.io/role/internal-elb"  = "1"
	}
}

resource "aws_subnet" "priv_SUB_2" {
    vpc_id = aws_vpc.my_VPC.id
    cidr_block = "10.0.3.0/24"
    availability_zone = "ap-south-1c"
    
    tags = {
	    Name = "private-subnet-2"
	    "kubernetes.io/cluster/trendstore" = "shared"
	    "kubernetes.io/role/internal-elb"  = "1"
	}
}


resource "aws_internet_gateway" "my_IGW" {
    vpc_id = aws_vpc.my_VPC.id
    tags = {
      Name = "Trendstore_IGW"
    }
}

resource "aws_route_table" "public_RT" {
    vpc_id = aws_vpc.my_VPC.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my_IGW.id
    }
    tags = {
      Name = "Trendstore-RT"
    }
}

resource "aws_route_table_association" "pub_RT_Assoc-1" {
    subnet_id = aws_subnet.pub_SUB_1.id
    route_table_id = aws_route_table.public_RT.id
}

resource "aws_route_table_association" "pub_RT_Assoc-2" {
    subnet_id = aws_subnet.pub_SUB_2.id
    route_table_id = aws_route_table.public_RT.id
}

resource "aws_security_group" "my_SG" {
    name = "EC2_SG"
    vpc_id = aws_vpc.my_VPC.id

    ingress {
        description = "HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "Custom TCP"
        from_port = 3000
        to_port = 3000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    } 

    ingress {
        description = "Custom TCP"
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "Custom TCP"
        from_port = 9090
        to_port = 9090
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "Custom TCP"
        from_port = 9100
        to_port = 9100
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        description = "All traffic"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "EC2-Sg"
    }
}

resource "aws_security_group" "eks_nodegroup_SG" {
    name = "Nodegroup-SG"
    vpc_id = aws_vpc.my_VPC.id

    ingress {
        description = "Custom Traffic"
        from_port = 3000
        to_port = 3000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "Nodegroup-SG"
    }
}

resource "aws_iam_role" "instance_role" {
    name = "instance_role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = "sts:AssumeRole"
                Effect = "Allow"
                Principal = {
                    Service = "ec2.amazonaws.com"
                }
            }
        ]
    })
}

resource "aws_iam_role_policy_attachment" "inst_Attach" {
    role = aws_iam_role.instance_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess" 
}

resource "aws_iam_instance_profile" "inst_profile" {
    name = "instance_profile"
    role = aws_iam_role.instance_role.name
}

resource "aws_iam_role_policy_attachment" "eks_cluster_attach" {
    role = aws_iam_role.instance_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "eks_service_attach" {
    role = aws_iam_role.instance_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}

resource "aws_iam_role" "eks_cluster" {
    name = "eks_cluster_role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Action = "sts:AssumeRole"
                Effect = "Allow"
                Principal = {
                    Service = "eks.amazonaws.com"
                }
            }
        ]
    })
  
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
    role = aws_iam_role.eks_cluster.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "eks_service_ploicy" {
    role = aws_iam_role.eks_cluster.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}

resource "aws_iam_role" "eks_nodegroup" {
    name = "eks_nodegroup_role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Principal = {
                Service = "ec2.amazonaws.com"
            }
        }]
    })
}

resource "aws_iam_role_policy_attachment" "eks_worker_nodegroup_policy" {
    role = aws_iam_role.eks_nodegroup.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
    role = aws_iam_role.eks_nodegroup.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "ec2_cont-reg-readonly_policy" {
    role = aws_iam_role.eks_nodegroup.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_instance" "my_instance" {
    ami = "ami-02b8269d5e85954ef"
    instance_type = "t3.medium"
    vpc_security_group_ids = [aws_security_group.my_SG.id]
    subnet_id = aws_subnet.pub_SUB_1.id
    iam_instance_profile = aws_iam_instance_profile.inst_profile.name
    key_name = "testkey"
    user_data = (file("user_data.sh"))

    root_block_device {
      volume_size = "20"
      volume_type = "gp3"
      delete_on_termination = true
    }

    tags = {
      Name = "Jenkins-Server"
    }
}

output "ec2_instance" {
    value = aws_instance.my_instance.public_ip
}

output "vpc" {
    value = aws_vpc.my_VPC.id
}

output "public_subnet_1" {
    value = aws_subnet.pub_SUB_1.id
}

output "public_subnet_2" {
    value = aws_subnet.pub_SUB_2.id
}

output "private_subnet_1" {
    value = aws_subnet.priv_SUB_1.id 
}

output "private_subnet_2" {
    value = aws_subnet.priv_SUB_2.id 
}

output "nodegroup-sg" {
    value = aws_security_group.eks_nodegroup_SG.id
}

output "eks_cluster_role" {
    value = aws_iam_role.eks_cluster.arn
}

output "eks_nodegroup_role" {
    value = aws_iam_role.eks_nodegroup.arn
}
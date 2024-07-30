

# Terraform AWS Infrastructure Project with Rust Automation

This project provisions a complete AWS infrastructure using Terraform. It includes a Virtual Private Cloud (VPC), a subnet, an EC2 instance, and a Relational Database Service (RDS) instance. Additionally, a Rust script automates the execution of Terraform commands.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Project Structure](#project-structure)
- [Setup Instructions](#setup-instructions)
- [Rust Automation Script](#rust-automation-script)
- [Terraform Configuration Files](#terraform-configuration-files)
  - [main.tf](#maintf)
  - [variables.tf](#variablestf)
  - [outputs.tf](#outputstf)
- [Usage](#usage)
- [Cleanup](#cleanup)
- [License](#license)

## Prerequisites

Before you begin, ensure you have the following installed on your machine:

- [Terraform](https://www.terraform.io/downloads.html)
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate permissions
- [Rust](https://www.rust-lang.org/tools/install)

## Project Structure

```
terraform-aws-rust/
├── main.tf
├── variables.tf
├── outputs.tf
├── README.md
└── src/
    └── main.rs
```

- **main.tf**: Terraform configurations for AWS resources.
- **variables.tf**: Terraform variables for AWS configurations.
- **outputs.tf**: Terraform outputs to display created resource IDs and endpoints.
- **README.md**: Project documentation.
- **src/main.rs**: Rust script for automating Terraform operations.

## Setup Instructions

1. Clone this repository:

    ```bash
    git clone https://github.com/yourusername/terraform-aws-rust.git
    ```

2. Navigate to the project directory:

    ```bash
    cd terraform-aws-rust
    ```

3. Initialize Terraform:

    ```bash
    terraform init
    ```

4. Apply the Terraform configuration:

    ```bash
    terraform apply
    ```

    Follow the prompts to confirm the infrastructure creation.

## Rust Automation Script

This project includes a Rust script to automate Terraform operations. The script performs the following actions:

1. Initializes Terraform.
2. Applies the Terraform configuration to create the infrastructure.
3. Displays the current state of the infrastructure using `terraform show`.

### src/main.rs

```rust
use std::process::Command;

fn main() {
    // Print a friendly message to indicate the start of the process
    println!("Starting Terraform automation...");

    // Initialize Terraform
    let init_output = Command::new("terraform")
        .arg("init")
        .output()
        .expect("Failed to execute Terraform init");

    // Check if the Terraform init command was successful
    if init_output.status.success() {
        println!("Terraform initialized successfully.");
    } else {
        eprintln!("Error initializing Terraform: {:?}", init_output);
        return;
    }

    // Apply Terraform configuration
    let apply_output = Command::new("terraform")
        .arg("apply")
        .arg("-auto-approve")
        .output()
        .expect("Failed to execute Terraform apply");

    // Check if the Terraform apply command was successful
    if apply_output.status.success() {
        println!("Terraform applied successfully.");
    } else {
        eprintln!("Error applying Terraform configuration: {:?}", apply_output);
        return;
    }

    // Capture and print the output of Terraform show to display the current state
    let show_output = Command::new("terraform")
        .arg("show")
        .output()
        .expect("Failed to execute Terraform show");

    // Convert the output to a string and print it
    println!("Terraform show output: {:?}", String::from_utf8_lossy(&show_output.stdout));
}
```

## Terraform Configuration Files

### main.tf

```hcl
# Defining the AWS provider and specifying the region
provider "aws" {
  region = var.aws_region
}

# Creating a VPC with a CIDR block
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "my_vpc"
  }
}

# Creating a public subnet within the VPC
resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = var.availability_zone
  tags = {
    Name = "my_subnet"
  }
}

# Launching an EC2 instance within the subnet
resource "aws_instance" "my_instance" {
  ami           = var.ec2_ami_id
  instance_type = var.ec2_instance_type
  subnet_id     = aws_subnet.my_subnet.id
  tags = {
    Name = "my_instance"
  }
}

# Creating an RDS instance
resource "aws_db_instance" "my_rds" {
  allocated_storage    = 20
  engine               = "mysql"
  instance_class       = "db.t2.micro"
  name                 = "mydatabase"
  username             = "admin"
  password             = "password123"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  tags = {
    Name = "my_rds"
  }
}

# Outputs to display after Terraform apply
output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "subnet_id" {
  value = aws_subnet.my_subnet.id
}

output "instance_id" {
  value = aws_instance.my_instance.id
}

output "rds_endpoint" {
  value = aws_db_instance.my_rds.endpoint
}
```

### variables.tf

```hcl
# Variable definitions with default values

variable "aws_region" {
  description = "The AWS region where resources will be created"
  default     = "us-west-2"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  description = "CIDR block for the subnet"
  default     = "10.0.1.0/24"
}

variable "availability_zone" {
  description = "AWS availability zone"
  default     = "us-west-2a"
}

variable "ec2_ami_id" {
  description = "AMI ID for the EC2 instance"
  default     = "ami-0abcdef1234567890"
}

variable "ec2_instance_type" {
  description = "Instance type for the EC2 instance"
  default     = "t2.micro"
}
```

### outputs.tf

```hcl
# Outputs to show the created resource IDs and endpoints

output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "subnet_id" {
  value = aws_subnet.my_subnet.id
}

output "instance_id" {
  value = aws_instance.my_instance.id
}

output "rds_endpoint" {
  value = aws_db_instance.my_rds.endpoint
}
```

## Usage

1. **Navigate to the project directory**:

    ```bash
    cd terraform-aws-rust
    ```

2. **Run the Rust script** to automate Terraform operations:

    ```bash
    cargo run
    ```

    This script will initialize Terraform, apply the configuration, and display the current state of the infrastructure.

## Cleanup

To destroy the infrastructure, run the following command:

```bash
terraform destroy
```

Follow the prompts to confirm the destruction of the infrastructure.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

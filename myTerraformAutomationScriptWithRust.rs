

**src/main.rs**:

  
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

# OpenStack Terraform Deployment Test Workflow

This GitHub Action workflow automates the testing of deployments of OpenStack virtual machines using Terraform. It also includes parallelized SSH connectivity tests for all VMs with batch processing to avoid overload. The workflow is optimized to:

- Retry Terraform Apply on failure
- Discover and parse floating IPs
- Execute parallel SSH connectivity tests with batching
- Report connection success and failure
- Clean up with Terraform Destroy

---

## 🚀 **Workflow Steps**

1. **Checkout the Code**
   - Uses `actions/checkout@v2` to pull the latest code from the repository.

2. **Setup Terraform**
   - Configures Terraform using `hashicorp/setup-terraform@v2`.

3. **Terraform Init**
   - Initializes the Terraform configuration for the specified scenario.

4. **Terraform Apply with Retry Logic**
   - Runs `terraform apply` with retry logic up to 5 attempts, waiting 15 seconds between retries.
   - If successful, logs the duration of the apply process.

5. **Discover Floating IPs from Terraform Output**
   - Fetches and parses `floating_ips` from Terraform output.
   - Stores IP addresses in `floating_ips.txt`.

6. **Prepare SSH Private Key**
   - Writes the private key from GitHub Secrets to a file for SSH access.

7. **SSH Connectivity Test (Parallelized with Batching)**
   - Runs parallel SSH connectivity checks with a maximum batch size of 10.
   - Logs the results of successful and failed connections.
   - Generates a report at the end, listing all VMs that succeeded or failed.

8. **Terraform Destroy (Cleanup)**
   - Always runs at the end to destroy the deployed infrastructure.

---

## 🔧 **Environment Variables**

| Variable                  | Description                               |
|--------------------------- |------------------------------------------|
| `OS_AUTH_URL`             | OpenStack Authentication URL              |
| `OS_PROJECT_ID`           | OpenStack Project ID                      |
| `OS_PROJECT_NAME`         | OpenStack Project Name                    |
| `OS_PROJECT_DOMAIN_NAME`  | OpenStack Project Domain Name             |
| `OS_USER_DOMAIN_NAME`     | OpenStack User Domain Name                |
| `OS_USERNAME`             | OpenStack Username                        |
| `OS_PASSWORD`             | OpenStack Password                        |
| `OS_REGION_NAME`          | OpenStack Region Name                     |
| `OS_INTERFACE`            | OpenStack Interface                       |
| `OS_IDENTITY_API_VERSION` | OpenStack API Version                     |
| `OS_PRIVATE_KEY`          | SSH Private Key for connectivity tests    |
| `DEFAULT_SSH_USER`        | Default SSH Username (e.g., `rocky`)      |

---

## 📄 **Outputs**

After the SSH Connectivity Test, the following files are generated:

- `success_list.txt`: List of VMs that successfully connected via SSH.
- `failed_list.txt`: List of VMs that failed to connect via SSH.
- Duration times for both:
  - `Terraform Apply`
  - `SSH Connectivity Test`

---

## 🚀 **Usage**

To trigger this workflow:

- Push to the `main` branch.
- Or manually trigger via the **workflow_dispatch** option in GitHub Actions.

---

## 📋 **SSH Connectivity Test Logic**

1. **Batch Size:**  
   Runs up to **10 VMs** in parallel. New batches are started as soon as a slot is free.

2. **Port Check:**  
   - Tests if port `22` is available before initiating SSH.  
   - Exponential backoff is used if the port is closed.

3. **SSH Connection Attempts:**  
   - Retries up to 5 times with an exponential delay if the connection fails.

4. **Output Files:**  
   - `success_list.txt` - Sorted list of successful connections.  
   - `failed_list.txt` - Sorted list of failed connections.

---

## 📝 **Example Output**

```plaintext
📋 SSH Connectivity Test Summary:
Total VMs Processed: 4
Successfully Connected: 3
Failed Connections: 1

✅ Successfully Connected VMs:
- vm-01 (192.168.1.10)
- vm-02 (192.168.1.11)
- vm-03 (192.168.1.12)

❌ Failed to Connect VMs:
- vm-04 (192.168.1.13)
```

---

## 🔄 **Cleanup Logic**

At the end of the workflow, `terraform destroy` is called to remove the provisioned infrastructure.

This step runs even if there were failures during SSH connectivity tests.

---

## 📦 **Improvements to Consider**

- Increasing batch size for larger deployments.
- Adding detailed logs for debugging failed SSH connections.
- Implementing dynamic backoff for more adaptive retry logic.

---

## ✨ **Contributing**

If you find issues or want to add improvements, feel free to create a pull request or open an issue.

# OpenStack Terraform Module Deployment Examples - CI/CD with GitHub Actions

This repository contains automated deployment tests for OpenStack VMs using the **openstack_compute_instance_v2** Terraform module. The deployments are triggered and managed using **GitHub Actions** to ensure consistent and repeatable infrastructure provisioning.

---

## 🚀 Deployment Scenarios

This repository supports the following scenarios:

1. **Scenario 1: Local Disk Deployment**
   - Deploys a Rocky Linux 9 VM to **local (ephemeral) storage**.
   - Associates Floating IPs to the VMs.
   - Directory: `openstack_compute_instance_v2/dfw3-rocky9-local-disk-deployment/`

2. **Scenario 2: Volume Deployment**
   - Deploys a Rocky Linux 9 VM to **Cinder volume storage**.
   - Attaches additional block storage volumes.
   - Associates Floating IPs to the VMs.
   - Directory: `openstack_compute_instance_v2/dfw3-rocky9-volume-deployment/`

---

## 🏗️ Repository Structure

```
.
├── .github/
│ └── workflows/
│ └── openstack_deploy.yml # GitHub Actions workflow file
└── openstack_compute_instance_v2/
├── dfw3-rocky9-local-disk-deployment/
│ ├── main.tf
│ ├── outputs.tf
│ └── cloud-init/
└── dfw3-rocky9-volume-deployment/
├── main.tf
├── outputs.tf
└── cloud-init/

```

---

## ⚙️ CI/CD with GitHub Actions

### Workflow Trigger

The deployment is triggered on:

- **Push events** to the `main` branch.
- **Manual trigger** via the GitHub Actions UI.

### Workflow Process

The CI/CD pipeline runs the following steps for each scenario:

1. **Checkout the code.**
2. **Install Terraform** (version 1.5.7).
3. **Initialize Terraform**.
4. **Plan the deployment**.
5. **Apply the deployment**.
6. **Destroy the deployment** (cleanup).

### Environment Variables (Secrets)

GitHub Actions uses the following secrets:

- **OS_AUTH_URL**
- **OS_PROJECT_ID**
- **OS_PROJECT_NAME**
- **OS_PROJECT_DOMAIN_NAME**
- **OS_USER_DOMAIN_NAME**
- **OS_USERNAME**
- **OS_PASSWORD**
- **OS_REGION_NAME**
- **OS_INTERFACE**
- **OS_IDENTITY_API_VERSION**

These secrets are configured under **Settings → Secrets and variables → Actions**.

---

## 📝 Running the Workflow Manually

1. Go to the **Actions** tab in your GitHub repository.
2. Select **Terraform OpenStack Deployment**.
3. Click **Run workflow**.
4. Choose the branch (`main`) and trigger the deployment.

---

## ✅ Verifying the Deployment

1. Check the **GitHub Actions logs** for successful execution.
2. Log in to the **OpenStack dashboard**.
3. Verify that:
   - VMs are created.
   - Floating IPs are assigned.
   - Volumes are attached (for Scenario 2).

---

## 🌟 Future Improvements

- Add **more scenarios** (e.g., different OS types).
- Integrate **automatic connectivity tests** post-deployment.
- Add **notification support** (e.g., Slack integration for build failures).

---

## 🗺️ Roadmap

- Implement **multi-region testing** (e.g., DFW3, SJC3).
- Automate **post-deployment verification** (e.g., SSH access check).
- Add **cost optimization checks** to ensure cleanup.

---

## 💡 Contributing

Feel free to open issues and submit PRs to improve the deployment scenarios and CI/CD workflow.

---

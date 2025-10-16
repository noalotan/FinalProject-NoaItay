# Status Page Migration Project

## Overview
This project is a **full DevOps lifecycle migration** of a **status page application** from a single-file structure to a fully containerized, cloud-deployed, and CI/CD-managed solution. The migration includes:

- **Containerization** of the application.
- **CI/CD pipelines** for automated testing and deployment.
- **Cloud migration** using AWS services.
- **Monitoring** with Prometheus & Grafana.
- **Agile methodology** for continuous development and deployment.

## **Technologies Used**
| **Component** | **Technology Used** |
|--------------|------------------|
| **Containerization** | Docker |
| **Image Repository** | DockerHub |
| **Orchestration** | Kubernetes (EKS) |
| **Database** | AWS RDS |
| **Infrastructure as Code** | Terraform |
| **CI/CD Tool** | Jenkins (running on EC2 within the same VPC) |
| **Monitoring** | Prometheus & Grafana (deployed via Helm) |

## Project Workflow
The project follows a structured branching model where each directory represents a "branch" in the original project. Engineers work collaboratively within this model:

### **Branch Structure**
- **Dev Branch**: Engineers clone this branch to develop and introduce new features/tools for the status page.
- **CI-Dev & CI-Prod Branches**: Contain automated **testing and CI/CD pipelines** to ensure stability.
- **Prod Branch**: Contains the live application serving consumers. Updates are pushed here **only through CD pipelines** to maintain uptime and low latency.

### **Workflow**
1. Engineers develop in **Dev branch**.
2. CI pipelines in **CI-Dev** validate changes via automated tests.
3. Approved pull requests are merged into **Dev branch**.
4. **Scheduled testing** ensures Dev branch is stable before pushing to **Prod branch**.
5. CD pipelines automatically update **Prod branch** while ensuring minimal downtime.

## **Deployment & Monitoring**
### **Continuous Integration & Deployment**
- **Jenkins pipelines** run CI/CD processes, ensuring smooth and automated updates.
- **CI pipelines (CI-Dev, CI-Prod)** include test automation, security scans, and performance checks.
- **CD pipelines** handle automated production updates with rollback mechanisms.

### **Cloud & Infrastructure**
- **Terraform** provisions **semi-prod environments** for testing.
- **EKS (Elastic Kubernetes Service)** deploys the application efficiently.
- **RDS (Relational Database Service)** manages persistent data.
  ![Architecture](https://github.com/user-attachments/assets/e1a080b6-81a9-44a7-99ec-f5906eb5cb33)

### **Monitoring & Logging**
- **Prometheus & Grafana** (deployed via Helm) provide real-time insights.
- **Alerting mechanisms** ensure immediate response to incidents.

## **Future Improvements**
- Improved test automation coverage.
- Enhanced logging and alerting.

---

This project ensures a **fully automated, cloud-native, and continuously improving status page application** following best DevOps practices. 🚀

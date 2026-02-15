# CS365-CapstoneProject
# Enterprise DevSecOps Transformation: Automated GitOps Pipeline for Tetris Game ⊞

## Project Overview
โปรเจกต์นี้เป็นการจำลองระบบ CI/CD Pipeline ระดับ Enterprise สำหรับการ Deploy เว็บแอปพลิเคชัน (Tetris Game) บน **AWS EKS (Elastic Kubernetes Service)**. โดยใช้แนวคิด **DevSecOps** เพื่อรวมขั้นตอนความปลอดภัย (Security Scanning) เข้าไปในทุกขั้นตอน และใช้หลักการ **GitOps** ผ่าน **ArgoCD** เพื่อจัดการการส่งมอบซอฟต์แวร์ให้มีความเสถียรและสามารถซ่อมแซมตัวเองได้ (Self-healing).

## 👥 Team Members & Roles
1. **นางสาวณัฐธิดา บุญเสือ (6609650350)**: **GitOps & SRE Specialist** - รับผิดชอบการจัดการ Kubernetes Manifests และ Continuous Deployment ผ่าน ArgoCD.
2. **[ชื่อ] ([รหัส])**: **DevSecOps Engineer** - รับผิดชอบ Jenkins CI Pipeline และความปลอดภัย (Trivy, SonarQube).
3. **[ชื่อ] ([รหัส])**: **Infrastructure Architect** - รับผิดชอบการใช้ Terraform เพื่อสร้าง VPC และ EKS Cluster.

## 🛠 Tech Stack
* **Cloud Platform:** AWS (EKS, EC2, ECR)
* **Infrastructure as Code:** Terraform
* **CI/CD Tools:** Jenkins, ArgoCD
* **Security & Quality:** Trivy, SonarQube, OWASP Dependency Check
* **Containerization:** Docker & Kubernetes

## 📂 Repository Structure คร่าวๆ
* `/EKS-TF`: Terraform scripts สำหรับสร้าง EKS Cluster
* `/Jenkins-Server-TF`: Terraform scripts สำหรับสร้าง Jenkins Server
* `/Jenkins-Pipeline-Code`: รหัสต้นฉบับของ CI/CD Pipeline
* `/Manifest-file`: ไฟล์คอนฟิก Kubernetes สำหรับการ Deployment (CD)
* `/Tetris-V2`: ซอร์สโค้ดของแอปพลิเคชันเวอร์ชันล่าสุด

# CS365-CapstoneProject
# Enterprise DevSecOps Transformation: Automated GitOps Pipeline for Tetris Game ⊞

## Project Overview
โปรเจกต์นี้เป็นการจำลองระบบ CI/CD Pipeline ระดับ Enterprise สำหรับการ Deploy เว็บแอปพลิเคชัน (Tetris Game) บน **AWS EKS (Elastic Kubernetes Service)**. โดยใช้แนวคิด **DevSecOps** เพื่อรวมขั้นตอนความปลอดภัย (Security Scanning) เข้าไปในทุกขั้นตอน และใช้หลักการ **GitOps** ผ่าน **ArgoCD** เพื่อจัดการการส่งมอบซอฟต์แวร์ให้มีความเสถียรและสามารถซ่อมแซมตัวเองได้ (Self-healing).

## Team Members & Roles(คร่าวๆ)
1. **นางสาวณัฐธิดา บุญเสือ (6609650350)**: **GitOps & SRE Specialist** - รับผิดชอบการจัดการ Kubernetes Manifests และ Continuous Deployment ผ่าน ArgoCD.
2. **นายปิติภัทร จาดเนือง (6609650483)**: **DevSecOps Engineer** - รับผิดชอบ Jenkins CI Pipeline และความปลอดภัย (Trivy, SonarQube).
3. **นายภูมิภัทร แสนทองแก้ว (6609650574)**: **Infrastructure Architect** - รับผิดชอบการใช้ Terraform เพื่อสร้าง VPC และ EKS Cluster.

## 🛠 Tech Stack
* **Cloud Platform:** AWS (EKS, EC2, ECR)
* **Infrastructure as Code:** Terraform
* **CI/CD Tools:** Jenkins, ArgoCD
* **Security & Quality:** Trivy, SonarQube, OWASP Dependency Check
* **Containerization:** Docker & Kubernetes

## 📂 Repository Structure(คร่าวๆ)
* `/EKS-TF`: Terraform scripts สำหรับสร้าง EKS Cluster
* `/Jenkins-Server-TF`: Terraform scripts สำหรับสร้าง Jenkins Server
* `/Jenkins-Pipeline-Code`: รหัสต้นฉบับของ CI/CD Pipeline
* `/Manifest-file`: ไฟล์คอนฟิก Kubernetes สำหรับการ Deployment (CD)
* `/Tetris-V2`: ซอร์สโค้ดของแอปพลิเคชันเวอร์ชันล่าสุด


# Aida Work Detail
# Continuous Deployment & GitOps Documentation (SRE Role)

ในส่วนนี้เป็นการจัดการด้านการส่งมอบซอฟต์แวร์ (Continuous Deployment) โดยใช้หลักการ **GitOps** เพื่อให้สถานะของแอปพลิเคชันบน Cluster ตรงกับค่าที่กำหนดไว้ใน Repository นี้เสมอ.

## Kubernetes Resources
ไฟล์คอนฟิกพื้นฐานประกอบด้วย:
* **`deployment.yaml`**: กำหนดการทำงานของแอปพลิเคชัน (Replicas, Container Image, Resource Limits).
* **`service.yaml`**: กำหนดการเข้าถึงแอปพลิเคชันผ่าน **AWS Load Balancer**.

## Deployment Workflow (ArgoCD)
1. เมื่อ Jenkins CI Pipeline ทำการ Build และ Scan Docker Image เสร็จสิ้น จะทำการอัปเดต Image Tag มายังไฟล์ในโฟลเดอร์นี้.
2. **ArgoCD Controller** จะตรวจพบการเปลี่ยนแปลง (Out-of-Sync) และทำการดึงค่าใหม่ไปใช้บน EKS Cluster โดยอัตโนมัติ.
3. ระบบจะตรวจสอบสุขภาพของ Pods (Self-healing) หากเกิดความผิดพลาด ArgoCD จะทำการแจ้งเตือนหรือรักษาค่าเดิมไว้.

## Future Roadmap (Extension Ideas)
* การเพิ่ม **Ingress Controller** สำหรับจัดการ Domain Name และ SSL.
* การติดตั้ง **Prometheus & Grafana** เพื่อทำ Monitoring ตามมาตรฐาน SRE.


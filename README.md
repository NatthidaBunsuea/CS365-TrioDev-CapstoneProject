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

# Oom Work Detail
# Infrastructure & Cloud Architect (Cloud Architect Role)

ในส่วนนี้เป็นการจัดการโครงสร้างพื้นฐานบนระบบ Cloud (AWS) โดยเน้นการใช้หลักการ **Infrastructure as Code (IaC)** เพื่อสร้างระบบที่มีความยืดหยุ่น มั่นคง และเป็นไปตามมาตรฐาน Automation

## Cloud Infrastructure (AWS)
ใช้ Terraform ในการจัดการ Resource ทั้งหมด (Provisioning) เพื่อให้สามารถตรวจสอบและทำซ้ำได้ (Idempotency):
* **`Networking`**: สร้าง VPC, Public/Private Subnets, และ Routing Table เพื่อแยก Layer ของ Application และ Database
* **`service.yaml`**: ติดตั้ง **AWS EKS Cluster** (Managed Kubernetes) สำหรับรองรับการ Scale ของ Microservices
* **`Tooling Server`**: ติดตั้ง **Jenkins Server** บน EC2 โดยใช้ Terraform (Jenkins-Server-TF) เพื่อเป็นศูนย์กลางของ CI/CD

## Security & IAM Management
การจัดการสิทธิ์การเข้าถึง (Least Privilege) เพื่อความปลอดภัยสูงสุด:
* กำหนด IAM Roles & Policies เฉพาะเจาะจงเพื่อให้ Jenkins และ ArgoCD สามารถสื่อสารกับบริการของ AWS (เช่น EKS, ECR) ได้อย่างปลอดภัยโดยไม่ต้องใช้ Static Credentials
* การจัดการ Network Security Groups เพื่อควบคุม Traffic ระหว่าง Jenkins และ Kubernetes Cluster

## Continuous Deployment & GitOps
เมื่อโครงสร้างพื้นฐานพร้อมแล้ว วางระบบการส่งมอบซอฟต์แวร์โดยใช้หลักการ **GitOps**:
* **`Kubernetes Resources`**: จัดทำไฟล์คอนฟิกพื้นฐาน (deployment.yaml, service.yaml) พร้อมการตั้งค่า Resource Limits และ Load Balancer
* **`ArgoCD Integration`**: ตั้งค่า Controller ให้คอยตรวจจับความเปลี่ยนแปลง (Out-of-Sync) ระหว่าง GitHub และ Cluster เพื่อทำ Automated Sync แบบ Real-time
* **`Self-healing`**: ระบบจะตรวจสอบสุขภาพของ Pods โดยอัตโนมัติ หากเกิดความผิดพลาด ArgoCD จะทำการ Rollback หรือรักษาค่าตามที่ระบุไว้ใน Repository

## Evidence & Repository Structure
หลักฐานการทำงานสามารถตรวจสอบได้ในโฟลเดอร์:
* **`/EKS-TF`**: ไฟล์ Terraform สำหรับสร้าง Network และ Cluster
* **`/Jenkins-Server-TF`**: การ Config EC2 สำหรับ Jenkins
* **`/K8s-Manifests`**: ไฟล์ Kubernetes YAML สำหรับการทำ GitOps

## Networking Infrastructure Provisioning
มีการสร้างโครงสร้างพื้นฐานด้าน Network บน AWS โดยใช้ Terraform ตามแนวคิด Infrastructure as Code (IaC) เพื่อให้สามารถสร้างระบบซ้ำได้ ตรวจสอบได้ และลดการตั้งค่าด้วยมือ (Manual Configuration)

ทรัพยากรที่ถูกสร้างมีดังนี้

**VPC (Virtual Private Cloud):**
สร้าง VPC สำหรับระบบทั้งหมด โดยกำหนด CIDR Block เป็น 10.0.0.0/16 เพื่อใช้เป็นเครือข่ายหลักสำหรับบริการต่าง ๆ ภายในระบบ

**Subnets:**
มีการแบ่ง Subnet ออกเป็น 2 ประเภท เพื่อแยกการทำงานของระบบ
* Public Subnets (2 Subnets) ใช้สำหรับทรัพยากรที่ต้องเชื่อมต่อกับ Internet เช่น NAT Gateway
* Private Subnets (2 Subnets) ใช้สำหรับทรัพยากรภายใน เช่น Kubernetes Worker Nodes หรือ Application Services
การกระจาย Subnets ถูกออกแบบให้ทำงานข้าม Availability Zones เพื่อเพิ่มความทนทานของระบบ (High Availability)

**Internet Gateway:**
เชื่อมต่อกับ VPC เพื่อให้ทรัพยากรที่อยู่ใน Public Subnet สามารถติดต่อกับ Internet ได้

**NAT Gateway:**
ติดตั้งใน Public Subnet เพื่อให้ทรัพยากรใน Private Subnet สามารถออกไปใช้งาน Internet ได้ (เช่น Download package หรือดึง container image) โดยไม่ต้องเปิด Public IP

**Route Tables:**
มีการกำหนดเส้นทาง Network ดังนี้
* Public Route Table → ส่ง Traffic 0.0.0.0/0 ไปยัง Internet Gateway
* Private Route Table → ส่ง Traffic 0.0.0.0/0 ไปยัง NAT Gateway

**Route Table Association:**
มีการเชื่อม Route Table เข้ากับ Subnet แต่ละตัวเพื่อกำหนดเส้นทาง Network ที่ถูกต้อง

## Future Roadmap (Extension Ideas)
* การเพิ่ม **Ingress Controller** สำหรับจัดการ Domain Name และ SSL.
* การติดตั้ง **Prometheus & Grafana** เพื่อทำ Monitoring ตามมาตรฐาน SRE.


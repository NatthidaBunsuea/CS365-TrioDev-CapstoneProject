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

# Continuous Deployment & GitOps Documentation (SRE / DevSecOps Role)

ในส่วนนี้เป็นการจัดการด้าน **Continuous Deployment และ GitOps** สำหรับระบบ Tetris DevSecOps CI/CD Pipeline บน AWS EKS โดยใช้ Jenkins, DockerHub และ ArgoCD เพื่อให้สถานะของ Application บน Kubernetes Cluster ตรงกับค่าที่กำหนดไว้ใน GitHub Repository อยู่เสมอ.

## Kubernetes Resources

ไฟล์ Kubernetes Manifest หลักประกอบด้วย:

* **`deployment.yaml`**
  กำหนดรายละเอียดของ Application Deployment เช่น:

  * Replica จำนวน Pods
  * Docker Image Version
  * Rolling Update Strategy
  * Resource Configuration

* **`service.yaml`**
  สร้าง Kubernetes Service แบบ `LoadBalancer` เพื่อเชื่อมต่อ Application ออกสู่อินเทอร์เน็ตผ่าน AWS Load Balancer.

* **`hpa.yaml`**
  กำหนด Horizontal Pod Autoscaler (HPA) สำหรับ Auto Scaling ตามการใช้งาน Resource ของระบบ.

* **`namespace.yaml`**
  แยก Resource ของระบบให้อยู่ภายใน Namespace `tetris-app`.


# GitOps Deployment Workflow (ArgoCD)

## 1. Jenkins Pipeline

เมื่อ Developer Push Source Code ขึ้น GitHub:

* Jenkins จะทำการ Checkout Source Code
* วิเคราะห์คุณภาพโค้ดด้วย SonarQube
* ตรวจสอบ Quality Gate
* สแกนช่องโหว่ด้วย Trivy FS Scan
* Build Docker Image
* สแกน Docker Image ด้วย Trivy Image Scan
* Push Image ไปยัง DockerHub

หลังจาก Build สำเร็จ Jenkins จะอัปเดตค่า Image Tag ภายใน `deployment.yaml` และ Push Manifest กลับขึ้น GitHub Repository.


## 2. ArgoCD Synchronization

ArgoCD ทำงานในรูปแบบ GitOps Controller โดย:

* ตรวจจับการเปลี่ยนแปลงของ Kubernetes Manifest จาก GitHub Repository
* เปรียบเทียบสถานะใน Git กับสถานะจริงบน EKS Cluster
* Sync ค่าล่าสุดลง Kubernetes Cluster อัตโนมัติ

เมื่อ Sync สำเร็จ ระบบจะแสดงสถานะ:

* **Synced**
* **Healthy**

บนหน้า ArgoCD Dashboard.


## 3. Rolling Update & Self-Healing

ระบบ Deployment ถูกออกแบบให้รองรับ:

### Rolling Update

Kubernetes จะทยอยสร้าง Pod ใหม่และลบ Pod เดิมทีละส่วน เพื่อลด Downtime ระหว่าง Deployment.

### Self-Healing

หาก Pod เกิดปัญหา เช่น:

* Image Pull Error
* Container Crash
* Pod Failure

Kubernetes และ ArgoCD จะตรวจพบความผิดปกติและพยายามรักษาสถานะของระบบให้กลับมาทำงานตาม Manifest ล่าสุดที่ถูกต้อง.


## 4. Deployment Monitoring

การตรวจสอบสถานะระบบใช้เครื่องมือดังนี้:

* **ArgoCD Dashboard**
  ตรวจสอบ Sync Status และ Health Status

* **kubectl / CloudShell**
  ใช้ตรวจสอบ Pods, Services, Rollout และ Rollback

* **CloudWatch**
  ใช้ตรวจสอบ Logs และ Metrics บน AWS Infrastructure

* **Metrics Server + HPA**
  ใช้สำหรับ Resource Monitoring และ Auto Scaling ภายใน Cluster.


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

# Woon Work Detail
## CI & Security Pipeline Documentation (DevSecOps Role)
ในส่วนนี้รับผิดชอบการออกแบบและพัฒนา Continuous Integration Pipeline พร้อมผสานมาตรการด้านความปลอดภัย (DevSecOps) เพื่อให้ทุกการเปลี่ยนแปลงของโค้ดผ่านกระบวนการตรวจสอบคุณภาพและความปลอดภัยก่อนนำไปใช้งานจริง

## CI Pipeline Architecture (Jenkins – Pipeline as Code)
ใช้ Jenkinsfile ในรูปแบบ Pipeline as Code เพื่อควบคุมกระบวนการทำงานทั้งหมดของระบบ CI โดยมีขั้นตอนหลักดังนี้:
* Source Code Checkout จาก GitHub Repository
* Build Application
* Static Code Analysis ด้วย SonarQube
* Dependency Vulnerability Scan ด้วย OWASP Dependency-Check
* Docker Image Build
* Container Image Scan ด้วย Trivy
* Push Docker Image ไปยัง Docker Hub หรือ AWS ECR

Pipeline ถูกออกแบบให้ทำงานแบบอัตโนมัติเมื่อมีการ Commit หรือ Pull Request เพื่อป้องกันโค้ดที่มีช่องโหว่เข้าสู่ระบบหลัก

## Security Controls & Quality Gates
เพื่อยกระดับมาตรฐานความปลอดภัย มีการกำหนด Quality Gate ดังนี้:
* SonarQube ตรวจสอบ Code Smell, Bug, และ Vulnerability
* OWASP Dependency-Check วิเคราะห์ช่องโหว่จาก Third-party Libraries
* Trivy ตรวจสอบ Container Image ก่อนการ Deploy

หากตรวจพบ Critical/High Vulnerability ระบบจะหยุด Pipeline โดยอัตโนมัติ (Fail Fast Principle) เพื่อป้องกันความเสี่ยงด้านความปลอดภัย

## Containerization Strategy
มีการออกแบบ Dockerfile ให้เหมาะสมกับ Production Environment โดยคำนึงถึง:
* การเลือก Base Image ที่มีความปลอดภัย
* การลดขนาด Image เพื่อลด Attack Surface
* การกำหนด Non-root User ภายใน Container
* การจัดการ Resource อย่างเหมาะสม

Docker Image จะถูก Push ไปยัง Registry ก็ต่อเมื่อผ่านขั้นตอน Security Scan เท่านั้น


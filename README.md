# ☁️ Cloud-Native Task Manager REST API

A production-style, containerized RESTful API built for scalable task management using modern DevOps and Cloud-Native paradigms.

---

## 🛠️ Architecture & Tech Stack

- **Backend Language & Framework:** Node.js, Express, TypeScript
- **Database:** SQLite (Lightweight file-based persistence)
- **Containerization & Orchestration:** Docker (Multi-stage build), Nginx Reverse Proxy, `docker-compose`
- **Infrastructure as Code (IaC):** Terraform (AWS Security Group, S3 Bucket)
- **Container Orchestration:** Kubernetes (`Deployment`, `Service` LoadBalancer)
- **CI/CD Automation:** GitHub Actions (Automated type checking and Docker image build verification)

---

## 📊 API Endpoints

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `GET` | `/health` | Application health check endpoint |
| `GET` | `/api/tasks` | Fetch all tasks ordered by creation date |
| `GET` | `/api/tasks/:id` | Fetch a specific task by ID |
| `POST` | `/api/tasks` | Create a new task (`title`, `description`, `status`, `priority`) |
| `PUT` | `/api/tasks/:id` | Update an existing task |
| `DELETE` | `/api/tasks/:id` | Delete a task by ID |

---

## 🚀 Quick Start & Local Execution

### Option 1: Local Node.js Execution
```bash
# Install dependencies
npm install

# Start development server
npm run dev
```

### Option 2: Docker Compose Setup (App + Nginx Proxy)
```bash
# Execute deployment script
chmod +x scripts/deploy.sh
./scripts/deploy.sh
```
🏛️ Infrastructure & Kubernetes Deployment
Provision AWS Infrastructure via Terraform
```bash
cd terraform
terraform init
terraform plan
terraform apply
```
Deploy to Kubernetes Cluster
```bash
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/service.yaml
```

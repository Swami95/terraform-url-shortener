# 🚀 Terraform URL Shortener

This project provisions a **serverless URL shortener** using **Terraform** and AWS services.

## 📌 Features
- **AWS Lambda** (Python) to handle URL shortening logic
- **API Gateway** to expose a RESTful API
- **DynamoDB** for short/long URL mapping
- **Terraform Modules** for clean infrastructure as code

## 🏗️ Architecture
The project consists of:
1. **Lambda Function**: Accepts long URLs and returns shortened versions.
2. **API Gateway**: Routes requests to Lambda.
3. **DynamoDB**: Stores the mapping of short URLs to original URLs.

## 🛠️ Technologies Used
- **Terraform** (Infrastructure as Code)
- **AWS Lambda** (Python backend)
- **AWS API Gateway** (REST API)
- **AWS DynamoDB** (NoSQL database)

---

## 🔧 Setup Instructions

### 1️⃣ Clone the Repository
```sh
git clone https://github.com/YOUR_USERNAME/terraform-url-shortener.git
cd terraform-url-shortener

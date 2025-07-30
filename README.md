# DevOps Microservices Pipeline

A comprehensive DevOps pipeline showcasing modern microservices architecture with containerization, orchestration, and automated deployment strategies. This project demonstrates production-ready practices for building, testing, and deploying distributed applications.

## 🏗️ Project Architecture

```
├── services/                    # Microservices applications
│   ├── user-service/           # User management API
│   ├── order-service/          # Order processing API
│   └── frontend/               # React web application
├── shared/                     # Common utilities and libraries
│   └── utils/                  # Shared utility functions
├── k8s/                        # Kubernetes deployment manifests
├── scripts/                    # Automation and deployment scripts
└── docker-compose.yml          # Local development orchestration
```

## 🚀 Implementation Progress

<details>
<summary><strong>✅ Phase 1: Application Development</strong></summary>

### Microservices Architecture
- **User Service** (Node.js + Express)
  - RESTful API for user management
  - CRUD operations with validation
  - Health monitoring endpoints
  - Unit and integration testing
- **Order Service** (Node.js + Express)  
  - Order processing and management
  - Service-to-service communication
  - Business logic validation
  - Comprehensive test coverage
- **Frontend Application** (React)
  - Modern SPA with React Router
  - API integration with backend services
  - Responsive UI components
  - State management with React Query

### Shared Infrastructure
- **Common Utilities Package**
  - Centralized logging with Winston
  - Input validation schemas
  - Standardized response helpers
  - Error handling middleware
- **Testing Framework**
  - Jest for unit testing
  - Supertest for API testing
  - Integration test suites
  - Code coverage reporting

</details>

<details>
<summary><strong>✅ Phase 2: Containerization & Build Pipeline</strong></summary>

### Docker Implementation
- **Multi-stage Dockerfiles**
  - Optimized build processes
  - Security best practices
  - Non-root user implementation
  - Health check integration
- **Container Orchestration**
  - Docker Compose for local development
  - Service networking configuration
  - Volume management
  - Environment variable handling

### Build Automation
- **Image Building Scripts**
  - Semantic versioning strategy
  - Git commit hash tagging
  - Automated build processes
  - Cross-platform compatibility
- **Security Scanning**
  - Trivy vulnerability assessment
  - Automated security reporting
  - Build pipeline integration
  - Critical vulnerability blocking
- **Registry Management**
  - Docker Hub integration
  - Image tagging strategies
  - Push automation scripts
  - Multi-environment support

</details>

<details>
<summary><strong>✅ Phase 3: Kubernetes Orchestration</strong></summary>

### Container Orchestration
- **Kubernetes Manifests**
  - Deployment configurations
  - Service definitions
  - ConfigMap management
  - Resource allocation
- **High Availability Setup**
  - Multi-replica deployments
  - Load balancing configuration
  - Health check probes
  - Auto-restart policies
- **Networking & Ingress**
  - Service mesh configuration
  - External traffic routing
  - SSL/TLS termination
  - Path-based routing

### Scalability Features
- **Horizontal Pod Autoscaling**
  - CPU-based scaling policies
  - Memory utilization monitoring
  - Custom metrics integration
  - Automatic scale-up/down
- **Resource Management**
  - CPU and memory limits
  - Quality of Service classes
  - Node affinity rules
  - Resource quotas

</details>

<details>
<summary><strong>✅ Phase 4: Jenkins CI/CD Pipeline</strong></summary>

### Jenkins Setup
- **Docker-based Jenkins** with local agent support
- **Pipeline as Code** using Jenkinsfile
- **Multi-stage pipeline** with parallel execution
- **Branch-based deployment** (master branch only)

### Pipeline Stages
- **📥 Checkout**: Clone code from GitHub repository
- **📦 Install Dependencies**: npm install for all services
- **🧪 Run Tests**: Parallel testing for all microservices
- **🐳 Build Images**: Smart building based on code changes
- **🔒 Security Scan**: Trivy vulnerability scanning
- **📤 Push Images**: Docker Hub registry integration
- **🚀 Deploy**: Kubernetes deployment automation

### Automation Features
- **Auto-trigger** on code changes (Poll SCM)
- **Smart building** - only build when code changes
- **Script integration** - uses existing build/deploy scripts
- **Error handling** - continues pipeline on non-critical failures

</details>

<details>
<summary><strong>🔄 Phase 5: Monitoring & Observability (Planned)</strong></summary>

### Metrics & Monitoring
- Prometheus metrics collection
- Grafana dashboard setup
- Alert manager configuration
- Custom business metrics

### Logging & Tracing
- Centralized logging with ELK stack
- Distributed tracing
- Log aggregation and analysis
- Performance monitoring

</details>

## 🛠️ Technology Stack

### Backend Services
- **Runtime**: Node.js 18+ with Express framework
- **Testing**: Jest, Supertest for comprehensive testing
- **Validation**: Joi for input validation
- **Logging**: Winston for structured logging
- **Security**: Helmet, CORS middleware

### Frontend Application
- **Framework**: React 18 with modern hooks
- **Routing**: React Router for SPA navigation
- **State Management**: React Query for server state
- **HTTP Client**: Axios for API communication
- **UI**: Custom CSS with responsive design

### Infrastructure & DevOps
- **Containerization**: Docker with multi-stage builds
- **Orchestration**: Kubernetes with native manifests
- **Security**: Trivy for vulnerability scanning
- **Automation**: Bash scripts for deployment
- **Development**: Docker Compose for local setup

## 🚀 Quick Start Guide

### Prerequisites
- Node.js 18+ and npm 8+
- Docker and Docker Compose
- kubectl and minikube (for Kubernetes deployment)

### Local Development Setup

<details>
<summary><strong>Option 1: Docker Compose (Recommended)</strong></summary>

```bash
# Clone and setup
git clone <repository-url>
cd microservices-devops-pipeline

# Build and run all services
docker-compose up --build

# Access applications
# Frontend: http://localhost:3000
# User API: http://localhost:3001/api/users
# Order API: http://localhost:3002/api/orders
```

</details>

<details>
<summary><strong>Option 2: Native Development</strong></summary>

```bash
# Install dependencies
npm install --workspaces

# Run services in separate terminals
cd services/user-service && npm run dev     # Port 3001
cd services/order-service && npm run dev    # Port 3002  
cd frontend && npm start                     # Port 3000
```

</details>

### Docker Build Pipeline

<details>
<summary><strong>Build and Scan Images</strong></summary>

```bash
# Build images with versioning
./scripts/build-images.sh v1.0.0

# Security scanning
./scripts/scan-images.sh

# Push to registry (optional)
./scripts/push-images.sh v1.0.0 docker.io your-username
```

</details>

### Jenkins CI/CD Pipeline

<details>
<summary><strong>🚀 Setup Jenkins (3 steps)</strong></summary>

```bash
# 1. Start Jenkins with Docker
cd jenkins
chmod +x jenkins-setup.sh
./jenkins-setup.sh

# 2. Access Jenkins Web UI
# URL: http://localhost:8080
# Password: Copy from terminal output

# 3. Create Pipeline Job
# - New Item → Pipeline
# - Name: devops-pipeline-github
# - Definition: Pipeline script from SCM
# - Repository: https://github.com/toannd021104/Devops-Pipeline
# - Script Path: Jenkinsfile.simple
```

</details>

<details>
<summary><strong>🔄 Pipeline Stages</strong></summary>

The Jenkins pipeline automatically:

1. **📥 Checkout** - Clone code from GitHub
2. **📦 Install Dependencies** - npm install for all services  
3. **🧪 Run Tests** - Parallel testing (user-service, order-service, frontend)
4. **🐳 Build Images** - Smart Docker builds (only when code changes)
5. **🔒 Security Scan** - Trivy vulnerability scanning
6. **📤 Push Images** - Docker Hub (master branch only)
7. **🚀 Deploy** - Kubernetes deployment (master branch only)

**Auto-trigger Options**:
- **Poll SCM**: Checks GitHub every 2 minutes for changes
- **GitHub Webhooks**: Instant trigger when code is pushed (requires public IP/ngrok)

</details>

<details>
<summary><strong>🛠️ Jenkins Features</strong></summary>

- **Smart Building**: Only builds services with code changes
- **Branch Protection**: Push/Deploy only on master branch
- **Script Integration**: Uses existing `scripts/` for build/deploy
- **Error Handling**: Continues pipeline on non-critical failures
- **Local Agent**: Runs on your machine (has Node.js, Docker, kubectl)

**View Pipeline**: Jenkins Dashboard → devops-pipeline-github → Build History

</details>

### Kubernetes Deployment

<details>
<summary><strong>Deploy to Kubernetes</strong></summary>

```bash
# Start local cluster
minikube start

# Deploy all services
chmod +x scripts/deploy-k8s.sh
./scripts/deploy-k8s.sh

# Access via ingress
echo "$(minikube ip) microservices.local" | sudo tee -a /etc/hosts
# Visit: http://microservices.local
```

</details>

### Testing

```bash
# Run all tests
npm test

# Run unit tests only
npm run test:unit

# Run integration tests only
npm run test:integration

# Run tests for specific service
cd services/user-service && npm test
```

### Linting

```bash
# Lint all services
npm run lint

# Fix linting issues
npm run lint:fix
```

## Environment Configuration

Each service has an `.env.example` file. Copy these to `.env` files and configure as needed:

```bash
# For user-service
cp services/user-service/.env.example services/user-service/.env

# For order-service
cp services/order-service/.env.example services/order-service/.env
```

## API Examples

### User Service Examples

```bash
# Get all users
curl http://localhost:3001/api/users

# Create a user
curl -X POST http://localhost:3001/api/users \
  -H "Content-Type: application/json" \
  -d '{"name": "John Doe", "email": "john@example.com"}'

# Get user by ID
curl http://localhost:3001/api/users/1

# Update user
curl -X PUT http://localhost:3001/api/users/1 \
  -H "Content-Type: application/json" \
  -d '{"name": "John Updated"}'

# Health check
curl http://localhost:3001/health
```

### Order Service Examples

```bash
# Get all orders
curl http://localhost:3002/api/orders

# Get orders for specific user
curl http://localhost:3002/api/orders?userId=1

# Create an order
curl -X POST http://localhost:3002/api/orders \
  -H "Content-Type: application/json" \
  -d '{
    "userId": "1",
    "items": [
      {
        "productId": "p1",
        "name": "Product 1",
        "quantity": 2,
        "price": 29.99
      }
    ]
  }'

# Update order status
curl -X PUT http://localhost:3002/api/orders/1 \
  -H "Content-Type: application/json" \
  -d '{"status": "completed"}'

# Health check
curl http://localhost:3002/health
```

## Shared Utilities

The `shared/utils` package provides common functionality:

- **Logger**: Winston-based logging with different levels
- **Validators**: Common validation schemas and functions
- **Response Helpers**: Standardized API response formats
- **Error Handlers**: Custom error classes and global error handling

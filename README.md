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
<summary><strong>🔄 Phase 4: CI/CD Pipeline (Planned)</strong></summary>

### Continuous Integration
- Jenkins pipeline configuration
- Automated testing workflows
- Code quality gates
- Security scanning integration

### Continuous Deployment
- Multi-environment deployments
- Blue-green deployment strategy
- Rollback mechanisms
- Deployment monitoring

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

## Testing Strategy

### Unit Tests
- Test individual functions and components
- Mock external dependencies
- Focus on business logic validation

### Integration Tests
- Test complete API workflows
- Test service interactions
- Validate end-to-end functionality

### Test Coverage
- Aim for >80% code coverage
- Include edge cases and error scenarios
- Test both success and failure paths

## Development Workflow

1. **Feature Development**: Create feature branches from main
2. **Testing**: Write unit and integration tests
3. **Code Quality**: Run linting and fix issues
4. **Pull Request**: Create PR with tests and documentation
5. **Review**: Code review and approval process
6. **Merge**: Merge to main branch
7. **Deployment**: Automated deployment via CI/CD pipeline

## Architecture Principles

- **Microservices**: Each service has a single responsibility
- **API-First**: RESTful APIs with consistent response formats
- **Health Checks**: Comprehensive health monitoring
- **Error Handling**: Graceful error handling and logging
- **Validation**: Input validation and sanitization
- **Security**: Security best practices and middleware
- **Testing**: Comprehensive test coverage
- **Documentation**: Clear API documentation and examples

## Next Steps

This project serves as the foundation for implementing:

1. **Docker Containerization** - Multi-stage Dockerfiles
2. **Kubernetes Deployment** - Helm charts and manifests
3. **CI/CD Pipeline** - Jenkins automation
4. **Monitoring Stack** - Prometheus and Grafana
5. **Logging Stack** - ELK stack implementation
6. **Security Scanning** - Container and dependency scanning
7. **Database Integration** - PostgreSQL and Redis
8. **Service Mesh** - Istio for advanced traffic management

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Ensure all tests pass
6. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
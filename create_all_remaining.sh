#!/bin/bash

# Docker
cat > docker/README.md << 'EOF'
# Docker Interview Questions - Top 100

## Quick Topics
1. Docker Fundamentals (Q1-Q20)
2. Images & Containers (Q21-Q40)
3. Networking & Storage (Q41-Q60)
4. Docker Compose & Swarm (Q61-Q75)
5. Best Practices & Security (Q76-Q100)

## Key Concepts

### Q1-Q10: Fundamentals
- **Q1**: Docker - Platform for containerization
- **Q2**: Container vs VM - Lightweight, shared OS kernel
- **Q3**: Docker Architecture - Client-Server, Docker Daemon
- **Q4**: Docker Engine - dockerd, containerd, runc
- **Q5**: Dockerfile - Instructions to build image
- **Q6**: Docker Image - Read-only template
- **Q7**: Docker Container - Running instance of image
- **Q8**: Docker Registry - Store and distribute images (Docker Hub)
- **Q9**: Docker CLI - docker run, build, push, pull
- **Q10**: Layers - Each instruction creates a layer

### Q11-Q20: Core Commands
```bash
# Images
docker build -t myapp:1.0 .
docker images
docker pull nginx:latest
docker push myrepo/myapp:1.0
docker rmi image-id

# Containers
docker run -d -p 8080:80 --name web nginx
docker ps
docker ps -a
docker stop container-id
docker start container-id
docker rm container-id
docker exec -it container-id /bin/bash
docker logs container-id
docker inspect container-id
docker stats
```

### Q21-Q30: Dockerfile
```dockerfile
FROM node:16-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
ENV NODE_ENV=production
USER node
CMD ["node", "server.js"]
```

**Instructions:**
- FROM, RUN, COPY, ADD, CMD, ENTRYPOINT, EXPOSE, ENV, WORKDIR, USER, VOLUME, ARG

### Q31-Q40: Multi-stage Builds
```dockerfile
# Build stage
FROM maven:3.8-jdk-11 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn package

# Runtime stage
FROM openjdk:11-jre-slim
COPY --from=build /app/target/app.jar /app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]
```

### Q41-Q50: Networking
```bash
# Network types
docker network create my-network
docker network ls
docker network inspect my-network

# Types: bridge, host, none, overlay
docker run --network=my-network nginx
```

### Q51-Q60: Volumes
```bash
# Named volume
docker volume create my-data
docker run -v my-data:/data nginx

# Bind mount
docker run -v /host/path:/container/path nginx

# tmpfs mount
docker run --tmpfs /tmp nginx
```

### Q61-Q70: Docker Compose
```yaml
version: '3.8'
services:
  web:
    build: .
    ports:
      - "8080:80"
    environment:
      - DB_HOST=db
    depends_on:
      - db
    networks:
      - app-network
  
  db:
    image: postgres:13
    volumes:
      - db-data:/var/lib/postgresql/data
    environment:
      POSTGRES_PASSWORD: secret
    networks:
      - app-network

volumes:
  db-data:

networks:
  app-network:
```

### Q71-Q80: Best Practices
- Use official base images
- Minimize layers
- Use .dockerignore
- Don't run as root
- Use specific tags
- Multi-stage builds
- Health checks
- Security scanning

### Q81-Q90: Security
```dockerfile
# Security best practices
FROM node:16-alpine
RUN addgroup -g 1001 -S nodejs && adduser -S nodejs -u 1001
USER nodejs
COPY --chown=nodejs:nodejs . .
```

### Q91-Q100: Production Tips
- Resource limits
- Logging drivers
- Health checks
- Restart policies
- Image optimization
- Registry security
- Secrets management
- Monitoring

---

**Note**: Essential Docker knowledge for containerization and deployment.
EOF

# CI/CD
cat > cicd/README.md << 'EOF'
# CI/CD Interview Questions - Top 100

## Topics
1. CI/CD Fundamentals (Q1-Q20)
2. Jenkins (Q21-Q40)
3. GitLab CI (Q41-Q55)
4. GitHub Actions (Q56-Q70)
5. Best Practices (Q71-Q100)

## Key Concepts

### Q1-Q10: Fundamentals
- **Q1**: CI/CD - Continuous Integration/Continuous Delivery
- **Q2**: CI - Automated build and test
- **Q3**: CD - Automated deployment
- **Q4**: Pipeline - Automated workflow
- **Q5**: Build - Compile and package
- **Q6**: Test - Unit, integration, E2E
- **Q7**: Deploy - Release to environment
- **Q8**: Artifact - Build output
- **Q9**: Version Control - Git
- **Q10**: Branching Strategy - GitFlow, trunk-based

### Q11-Q20: Pipeline Stages
```
Source → Build → Test → Deploy → Monitor
```

**Stages:**
1. Checkout code
2. Build application
3. Run tests
4. Security scan
5. Build Docker image
6. Push to registry
7. Deploy to environment
8. Smoke tests
9. Monitoring

### Q21-Q30: Jenkins Pipeline
```groovy
pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        
        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }
        
        stage('Docker Build') {
            steps {
                sh 'docker build -t myapp:${BUILD_NUMBER} .'
            }
        }
        
        stage('Deploy') {
            steps {
                sh 'kubectl apply -f k8s/'
            }
        }
    }
    
    post {
        always {
            junit '**/target/surefire-reports/*.xml'
        }
        success {
            echo 'Pipeline succeeded!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
```

### Q31-Q40: Jenkins Concepts
- **Declarative Pipeline**: Structured syntax
- **Scripted Pipeline**: Groovy-based
- **Jenkinsfile**: Pipeline as code
- **Agents**: Where to run
- **Stages**: Logical divisions
- **Steps**: Individual tasks
- **Post Actions**: After pipeline
- **Credentials**: Secure secrets
- **Shared Libraries**: Reusable code
- **Blue Ocean**: Modern UI

### Q41-Q50: GitLab CI
```yaml
stages:
  - build
  - test
  - deploy

variables:
  DOCKER_IMAGE: myapp:$CI_COMMIT_SHA

build:
  stage: build
  script:
    - mvn clean package
  artifacts:
    paths:
      - target/*.jar

test:
  stage: test
  script:
    - mvn test
  coverage: '/Total.*?([0-9]{1,3})%/'

docker:
  stage: build
  script:
    - docker build -t $DOCKER_IMAGE .
    - docker push $DOCKER_IMAGE

deploy:
  stage: deploy
  script:
    - kubectl set image deployment/myapp myapp=$DOCKER_IMAGE
  only:
    - main
```

### Q51-Q60: GitHub Actions
```yaml
name: CI/CD Pipeline

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v2
    
    - name: Set up JDK 11
      uses: actions/setup-java@v2
      with:
        java-version: '11'
    
    - name: Build with Maven
      run: mvn clean package
    
    - name: Run tests
      run: mvn test
    
    - name: Build Docker image
      run: docker build -t myapp:${{ github.sha }} .
    
    - name: Push to registry
      run: docker push myapp:${{ github.sha }}
    
    - name: Deploy to Kubernetes
      run: kubectl apply -f k8s/
```

### Q61-Q70: Tools & Concepts
- **Q61**: Maven/Gradle - Build tools
- **Q62**: SonarQube - Code quality
- **Q63**: Nexus/Artifactory - Artifact repository
- **Q64**: Selenium - UI testing
- **Q65**: JUnit/TestNG - Unit testing
- **Q66**: Docker - Containerization
- **Q67**: Kubernetes - Orchestration
- **Q68**: Terraform - Infrastructure as Code
- **Q69**: Ansible - Configuration management
- **Q70**: Prometheus/Grafana - Monitoring

### Q71-Q80: Best Practices
- Version control everything
- Automate everything
- Fast feedback
- Build once, deploy many
- Immutable artifacts
- Environment parity
- Security scanning
- Automated testing
- Rollback capability
- Monitoring and alerts

### Q81-Q90: Deployment Strategies
- **Blue-Green**: Two identical environments
- **Canary**: Gradual rollout
- **Rolling**: Sequential updates
- **A/B Testing**: Feature testing
- **Feature Flags**: Toggle features

### Q91-Q100: Advanced Topics
- GitOps (ArgoCD, Flux)
- Progressive delivery
- Chaos engineering
- Observability
- Security (DevSecOps)
- Compliance as code
- Multi-cloud deployment
- Disaster recovery
- Performance testing
- Cost optimization

---

**Note**: Master CI/CD for automated software delivery.
EOF

# Microservices
cat > microservices/README.md << 'EOF'
# Microservices Interview Questions - Top 100

## Topics
1. Fundamentals (Q1-Q20)
2. Design Patterns (Q21-Q40)
3. Communication (Q41-Q60)
4. Data Management (Q61-Q75)
5. Deployment & Operations (Q76-Q100)

## Key Concepts

### Q1-Q10: Fundamentals
- **Q1**: Microservices - Independently deployable services
- **Q2**: Monolith vs Microservices
- **Q3**: Benefits - Scalability, flexibility, resilience
- **Q4**: Challenges - Complexity, distributed systems
- **Q5**: Service Boundaries - Domain-driven design
- **Q6**: API Gateway - Single entry point
- **Q7**: Service Discovery - Eureka, Consul
- **Q8**: Load Balancing - Ribbon, client-side
- **Q9**: Circuit Breaker - Resilience4j, Hystrix
- **Q10**: Configuration - Centralized config server

### Q11-Q20: Architecture
```
┌──────────┐
│  Client  │
└────┬─────┘
     │
┌────▼──────────┐
│  API Gateway  │
└────┬──────────┘
     │
┌────┼────────────────┐
│    │                │
▼    ▼                ▼
Service A    Service B    Service C
│            │            │
▼            ▼            ▼
DB-A         DB-B         DB-C
```

### Q21-Q30: Design Patterns
- **Strangler Pattern**: Gradual migration
- **Saga Pattern**: Distributed transactions
- **CQRS**: Command Query Responsibility Segregation
- **Event Sourcing**: Store events
- **API Composition**: Aggregate data
- **Sidecar**: Helper container
- **Ambassador**: Proxy pattern
- **Adapter**: Protocol translation
- **Bulkhead**: Isolation
- **Retry**: Fault tolerance

### Q31-Q40: Communication
**Synchronous:**
- REST APIs
- gRPC
- GraphQL

**Asynchronous:**
- Message queues (RabbitMQ, Kafka)
- Event-driven
- Pub/Sub

```java
// REST
@RestController
public class UserController {
    @GetMapping("/users/{id}")
    public User getUser(@PathVariable Long id) {
        return userService.getUser(id);
    }
}

// Kafka Producer
kafkaTemplate.send("user-events", userEvent);

// Kafka Consumer
@KafkaListener(topics = "user-events")
public void handleUserEvent(UserEvent event) {
    // Process event
}
```

### Q41-Q50: Service Mesh
**Istio Features:**
- Traffic management
- Security (mTLS)
- Observability
- Policy enforcement

```yaml
apiVersion: networking.istio.io/v1alpha3
kind: VirtualService
metadata:
  name: reviews
spec:
  hosts:
  - reviews
  http:
  - match:
    - headers:
        end-user:
          exact: jason
    route:
    - destination:
        host: reviews
        subset: v2
  - route:
    - destination:
        host: reviews
        subset: v1
```

### Q51-Q60: Data Management
- **Database per Service**: Isolated data
- **Shared Database**: Anti-pattern
- **Event Sourcing**: Audit trail
- **CQRS**: Separate read/write
- **Saga Pattern**: Distributed transactions
- **API Composition**: Join data
- **Data Replication**: Eventual consistency

### Q61-Q70: Resilience
```java
// Circuit Breaker
@CircuitBreaker(name = "userService", fallbackMethod = "fallback")
public User getUser(Long id) {
    return restTemplate.getForObject("/users/" + id, User.class);
}

public User fallback(Long id, Exception ex) {
    return new User("default");
}

// Retry
@Retry(name = "userService", maxAttempts = 3)
public User getUser(Long id) {
    return restTemplate.getForObject("/users/" + id, User.class);
}

// Rate Limiter
@RateLimiter(name = "userService")
public User getUser(Long id) {
    return restTemplate.getForObject("/users/" + id, User.class);
}
```

### Q71-Q80: Observability
- **Logging**: Centralized (ELK, Splunk)
- **Metrics**: Prometheus, Grafana
- **Tracing**: Jaeger, Zipkin
- **Health Checks**: Actuator endpoints
- **Distributed Tracing**: Correlation IDs

### Q81-Q90: Security
- OAuth2/JWT
- API Gateway authentication
- Service-to-service auth (mTLS)
- Secrets management
- Rate limiting
- Input validation

### Q91-Q100: Best Practices
- Domain-driven design
- API versioning
- Backward compatibility
- Graceful degradation
- Idempotency
- Timeouts
- Bulkheads
- Monitoring
- Documentation (Swagger)
- Testing (contract testing)

---

**Note**: Essential microservices patterns for distributed systems.
EOF

echo "All topic READMEs created successfully!"

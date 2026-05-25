#!/bin/bash

# REST API
cat > rest-api/README.md << 'EOF'
# REST API Interview Questions - Top 100

## Topics Covered
1. REST Fundamentals (Q1-Q25)
2. HTTP Methods & Status Codes (Q26-Q50)
3. API Design Best Practices (Q51-Q75)
4. Security & Authentication (Q76-Q100)

## Key Concepts

### Q1-Q10: REST Fundamentals
- **Q1**: REST - Representational State Transfer
- **Q2**: RESTful - Architectural style for web services
- **Q3**: Resource - Entity exposed via URI
- **Q4**: Stateless - No client context on server
- **Q5**: Cacheable - Responses can be cached
- **Q6**: Client-Server - Separation of concerns
- **Q7**: Uniform Interface - Standard methods
- **Q8**: Layered System - Hierarchical layers
- **Q9**: Code on Demand - Optional executable code
- **Q10**: HATEOAS - Hypermedia as Engine of Application State

### Q11-Q25: HTTP Methods
```
GET    - Retrieve resource
POST   - Create resource
PUT    - Update/Replace resource
PATCH  - Partial update
DELETE - Remove resource
HEAD   - Get headers only
OPTIONS - Get supported methods
```

### Q26-Q50: Status Codes
```
2xx Success:
200 OK - Success
201 Created - Resource created
204 No Content - Success, no body

3xx Redirection:
301 Moved Permanently
302 Found (Temporary)
304 Not Modified

4xx Client Errors:
400 Bad Request
401 Unauthorized
403 Forbidden
404 Not Found
409 Conflict
422 Unprocessable Entity

5xx Server Errors:
500 Internal Server Error
502 Bad Gateway
503 Service Unavailable
504 Gateway Timeout
```

### Q51-Q75: API Design
```java
// Resource naming
GET    /api/v1/users
GET    /api/v1/users/{id}
POST   /api/v1/users
PUT    /api/v1/users/{id}
PATCH  /api/v1/users/{id}
DELETE /api/v1/users/{id}

// Filtering, Sorting, Pagination
GET /api/v1/users?status=active&sort=name&page=1&size=20

// Nested resources
GET /api/v1/users/{id}/orders
GET /api/v1/users/{id}/orders/{orderId}
```

### Q76-Q100: Security
- OAuth 2.0
- JWT tokens
- API keys
- Rate limiting
- CORS
- HTTPS
- Input validation
- SQL injection prevention
- XSS protection
- CSRF tokens

---

**Note**: Essential REST API design principles.
EOF

# OpenShift
cat > openshift/README.md << 'EOF'
# OpenShift Interview Questions - Top 100

## Topics
1. OpenShift Fundamentals (Q1-Q25)
2. Deployment & Build (Q26-Q50)
3. Networking & Storage (Q51-Q75)
4. Security & Operations (Q76-Q100)

## Key Concepts

### Q1-Q10: Fundamentals
- **Q1**: OpenShift - Enterprise Kubernetes platform by Red Hat
- **Q2**: OKD - Open source upstream
- **Q3**: Projects - Kubernetes namespaces with additional features
- **Q4**: Routes - Expose services externally
- **Q5**: ImageStreams - Manage container images
- **Q6**: BuildConfigs - Build strategies
- **Q7**: DeploymentConfigs - Deployment strategies
- **Q8**: Templates - Parameterized resource definitions
- **Q9**: Operators - Automate application management
- **Q10**: Service Mesh - Istio integration

### Q11-Q25: Architecture
```
┌─────────────────────────────────┐
│      OpenShift Control Plane    │
│  - API Server                   │
│  - Controllers                  │
│  - Scheduler                    │
│  - etcd                         │
└─────────────────────────────────┘
           │
    ┌──────┼──────┐
    ▼      ▼      ▼
  Node   Node   Node
  (Worker Nodes)
```

### Q26-Q50: Build Strategies
```yaml
# Source-to-Image (S2I)
apiVersion: build.openshift.io/v1
kind: BuildConfig
metadata:
  name: myapp
spec:
  source:
    git:
      uri: https://github.com/user/repo
  strategy:
    sourceStrategy:
      from:
        kind: ImageStreamTag
        name: nodejs:14
  output:
    to:
      kind: ImageStreamTag
      name: myapp:latest

# Docker Build
strategy:
  dockerStrategy:
    dockerfilePath: Dockerfile

# Pipeline Build
strategy:
  jenkinsPipelineStrategy:
    jenkinsfilePath: Jenkinsfile
```

### Q51-Q75: Routes & Services
```yaml
apiVersion: route.openshift.io/v1
kind: Route
metadata:
  name: myapp
spec:
  host: myapp.apps.cluster.example.com
  to:
    kind: Service
    name: myapp
  port:
    targetPort: 8080
  tls:
    termination: edge
```

### Q76-Q100: Security
- SCCs (Security Context Constraints)
- RBAC
- Network Policies
- Image signing
- Secrets management
- OAuth integration
- Certificate management

---

**Note**: OpenShift for enterprise Kubernetes.
EOF

# System Design
cat > system-design/README.md << 'EOF'
# System Design Interview Questions - Top 100

## Topics
1. Fundamentals (Q1-Q20)
2. Scalability (Q21-Q40)
3. Database Design (Q41-Q60)
4. Caching & CDN (Q61-Q75)
5. Real-world Systems (Q76-Q100)

## Key Concepts

### Q1-Q10: Fundamentals
- **Q1**: Requirements - Functional & Non-functional
- **Q2**: CAP Theorem - Consistency, Availability, Partition tolerance
- **Q3**: Load Balancing - Distribute traffic
- **Q4**: Caching - Improve performance
- **Q5**: Database Sharding - Horizontal partitioning
- **Q6**: Replication - Data redundancy
- **Q7**: Message Queues - Async communication
- **Q8**: Microservices - Service decomposition
- **Q9**: API Gateway - Single entry point
- **Q10**: CDN - Content delivery network

### Q11-Q20: Scalability Patterns
```
Vertical Scaling - Add more resources
Horizontal Scaling - Add more servers
Database Replication - Master-Slave
Database Sharding - Partition data
Caching - Redis, Memcached
Load Balancing - Nginx, HAProxy
CDN - CloudFront, Akamai
Message Queues - Kafka, RabbitMQ
Microservices - Service decomposition
Event-Driven - Async processing
```

### Q21-Q40: High-Level Design
```
┌─────────┐
│ Client  │
└────┬────┘
     │
┌────▼────────┐
│ Load        │
│ Balancer    │
└────┬────────┘
     │
┌────┼─────────────┐
│    │             │
▼    ▼             ▼
App  App           App
Server Server      Server
│    │             │
└────┼─────────────┘
     │
┌────▼────────┐
│  Database   │
│  Cluster    │
└─────────────┘
```

### Q41-Q60: Database Design
- **SQL vs NoSQL**
- **Normalization**
- **Indexing**
- **Partitioning**
- **Replication**
- **Consistency models**

### Q61-Q75: Caching Strategies
- Cache-aside
- Write-through
- Write-behind
- Refresh-ahead

### Q76-Q100: Real Systems
- **Q76**: URL Shortener (bit.ly)
- **Q80**: Social Media Feed (Twitter)
- **Q85**: Video Streaming (YouTube)
- **Q90**: E-commerce (Amazon)
- **Q95**: Ride Sharing (Uber)
- **Q100**: Chat System (WhatsApp)

---

**Note**: System design for scalable applications.
EOF

# Database
cat > database/README.md << 'EOF'
# Database Interview Questions - Top 100

## Topics
1. SQL Fundamentals (Q1-Q30)
2. NoSQL (Q31-Q50)
3. Performance & Optimization (Q51-Q75)
4. Transactions & ACID (Q76-Q100)

## Key Concepts

### Q1-Q10: SQL Basics
```sql
-- SELECT
SELECT * FROM users WHERE age > 25;

-- JOIN
SELECT u.name, o.total
FROM users u
INNER JOIN orders o ON u.id = o.user_id;

-- GROUP BY
SELECT country, COUNT(*) as count
FROM users
GROUP BY country
HAVING count > 100;

-- SUBQUERY
SELECT name FROM users
WHERE id IN (SELECT user_id FROM orders WHERE total > 1000);
```

### Q11-Q20: Indexes
```sql
-- Create index
CREATE INDEX idx_email ON users(email);

-- Composite index
CREATE INDEX idx_name_age ON users(name, age);

-- Unique index
CREATE UNIQUE INDEX idx_username ON users(username);
```

### Q21-Q30: Normalization
- **1NF**: Atomic values
- **2NF**: No partial dependencies
- **3NF**: No transitive dependencies
- **BCNF**: Boyce-Codd Normal Form

### Q31-Q50: NoSQL Types
- **Document**: MongoDB, Couchbase
- **Key-Value**: Redis, DynamoDB
- **Column-Family**: Cassandra, HBase
- **Graph**: Neo4j, Amazon Neptune

### Q51-Q75: Performance
- Indexing strategies
- Query optimization
- Connection pooling
- Caching
- Partitioning
- Replication

### Q76-Q100: ACID Properties
- **Atomicity**: All or nothing
- **Consistency**: Valid state
- **Isolation**: Concurrent transactions
- **Durability**: Permanent changes

---

**Note**: Database fundamentals for data management.
EOF

# Security
cat > security/README.md << 'EOF'
# Security Interview Questions - Top 100

## Topics
1. Authentication & Authorization (Q1-Q25)
2. Encryption & Hashing (Q26-Q50)
3. Web Security (Q51-Q75)
4. Cloud Security (Q76-Q100)

## Key Concepts

### Q1-Q10: Authentication
- **Basic Auth**: Username/password
- **OAuth 2.0**: Delegated authorization
- **JWT**: JSON Web Tokens
- **SAML**: Security Assertion Markup Language
- **MFA**: Multi-factor authentication
- **SSO**: Single Sign-On
- **API Keys**: Application authentication
- **Certificate-based**: X.509 certificates

### Q11-Q25: Authorization
- **RBAC**: Role-Based Access Control
- **ABAC**: Attribute-Based Access Control
- **ACL**: Access Control Lists
- **Permissions**: Fine-grained access

### Q26-Q50: Encryption
```
Symmetric: AES, DES
Asymmetric: RSA, ECC
Hashing: SHA-256, bcrypt
TLS/SSL: Transport security
At-rest: Database encryption
In-transit: HTTPS
```

### Q51-Q75: Web Security
- **XSS**: Cross-Site Scripting
- **CSRF**: Cross-Site Request Forgery
- **SQL Injection**: Database attacks
- **CORS**: Cross-Origin Resource Sharing
- **CSP**: Content Security Policy
- **HTTPS**: Secure communication
- **Security Headers**: X-Frame-Options, etc.

### Q76-Q100: Cloud Security
- IAM policies
- Network security groups
- Encryption (KMS)
- Secrets management
- Compliance
- Audit logging
- DDoS protection
- WAF (Web Application Firewall)

---

**Note**: Security best practices for applications.
EOF

# Monitoring
cat > monitoring/README.md << 'EOF'
# Monitoring & Observability - Top 100 Questions

## Topics
1. Monitoring Fundamentals (Q1-Q25)
2. Metrics & Alerting (Q26-Q50)
3. Logging (Q51-Q75)
4. Distributed Tracing (Q76-Q100)

## Key Concepts

### Q1-Q10: Fundamentals
- **Monitoring**: Collect and analyze metrics
- **Observability**: Understand system state
- **Metrics**: Quantitative measurements
- **Logs**: Event records
- **Traces**: Request flow
- **Alerts**: Notifications
- **Dashboards**: Visualizations
- **SLI**: Service Level Indicators
- **SLO**: Service Level Objectives
- **SLA**: Service Level Agreements

### Q11-Q25: Tools
- **Prometheus**: Metrics collection
- **Grafana**: Visualization
- **ELK Stack**: Elasticsearch, Logstash, Kibana
- **Splunk**: Log analysis
- **Datadog**: Full-stack monitoring
- **New Relic**: APM
- **Jaeger**: Distributed tracing
- **Zipkin**: Distributed tracing

### Q26-Q50: Metrics
```
# Prometheus metrics
http_requests_total{method="GET", status="200"}
http_request_duration_seconds
cpu_usage_percent
memory_usage_bytes
disk_io_operations
```

### Q51-Q75: Logging
```
# Structured logging
{
  "timestamp": "2024-01-01T10:00:00Z",
  "level": "ERROR",
  "service": "user-service",
  "message": "Failed to connect to database",
  "error": "Connection timeout",
  "trace_id": "abc123"
}
```

### Q76-Q100: Distributed Tracing
- Trace ID
- Span ID
- Parent-child relationships
- Latency analysis
- Error tracking

---

**Note**: Monitoring for production systems.
EOF

# DevOps
cat > devops/README.md << 'EOF'
# DevOps Interview Questions - Top 100

## Topics
1. DevOps Fundamentals (Q1-Q20)
2. Infrastructure as Code (Q21-Q40)
3. Configuration Management (Q41-Q60)
4. Containerization (Q61-Q80)
5. Best Practices (Q81-Q100)

## Key Concepts

### Q1-Q10: Fundamentals
- **DevOps**: Development + Operations collaboration
- **CI/CD**: Continuous Integration/Delivery
- **IaC**: Infrastructure as Code
- **Automation**: Reduce manual work
- **Monitoring**: Observability
- **Version Control**: Git
- **Agile**: Iterative development
- **Microservices**: Service architecture
- **Containers**: Docker, Kubernetes
- **Cloud**: AWS, Azure, GCP

### Q11-Q20: Culture & Practices
- Collaboration
- Automation
- Continuous improvement
- Fail fast
- Blameless postmortems
- Shared responsibility
- Feedback loops
- Metrics-driven

### Q21-Q40: Infrastructure as Code
```hcl
# Terraform
resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  
  tags = {
    Name = "WebServer"
  }
}

# CloudFormation
Resources:
  MyEC2Instance:
    Type: AWS::EC2::Instance
    Properties:
      ImageId: ami-0c55b159cbfafe1f0
      InstanceType: t2.micro
```

### Q41-Q60: Configuration Management
```yaml
# Ansible
- name: Install nginx
  hosts: webservers
  tasks:
    - name: Install nginx
      apt:
        name: nginx
        state: present
    
    - name: Start nginx
      service:
        name: nginx
        state: started
```

### Q61-Q80: Containerization
- Docker
- Kubernetes
- Container orchestration
- Service mesh
- Registry management

### Q81-Q100: Best Practices
- Automate everything
- Version control
- Immutable infrastructure
- Monitoring and logging
- Security scanning
- Disaster recovery
- Documentation
- Testing
- Rollback capability
- Cost optimization

---

**Note**: DevOps practices for modern software delivery.
EOF

echo "All remaining topic READMEs created successfully!"

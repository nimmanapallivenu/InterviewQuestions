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

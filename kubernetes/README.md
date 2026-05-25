# Kubernetes Interview Questions - Top 100

## Table of Contents
1. [Kubernetes Fundamentals (Q1-Q20)](#kubernetes-fundamentals)
2. [Pods & Workloads (Q21-Q35)](#pods--workloads)
3. [Services & Networking (Q36-Q50)](#services--networking)
4. [Storage & Configuration (Q51-Q65)](#storage--configuration)
5. [Security & RBAC (Q66-Q75)](#security--rbac)
6. [Monitoring & Troubleshooting (Q76-Q85)](#monitoring--troubleshooting)
7. [Advanced Topics (Q86-Q100)](#advanced-topics)

---

## Kubernetes Fundamentals

### Q1: What is Kubernetes?
**Answer:** Open-source container orchestration platform for automating deployment, scaling, and management of containerized applications.

**Key Features:**
- Auto-scaling
- Self-healing
- Load balancing
- Rolling updates
- Service discovery

### Q2: Kubernetes Architecture?
```
┌─────────────────────────────────────────┐
│           Control Plane                 │
│  ┌──────────────────────────────────┐  │
│  │  API Server (kube-apiserver)     │  │
│  │  Scheduler (kube-scheduler)      │  │
│  │  Controller Manager              │  │
│  │  etcd (key-value store)          │  │
│  └──────────────────────────────────┘  │
└─────────────────┬───────────────────────┘
                  │
    ┌─────────────┼─────────────┐
    ▼             ▼             ▼
┌────────┐   ┌────────┐   ┌────────┐
│ Node 1 │   │ Node 2 │   │ Node 3 │
│ kubelet│   │ kubelet│   │ kubelet│
│ kube-  │   │ kube-  │   │ kube-  │
│ proxy  │   │ proxy  │   │ proxy  │
│Container│  │Container│  │Container│
│Runtime │   │Runtime │   │Runtime │
└────────┘   └────────┘   └────────┘
```

### Q3: Control Plane Components?
- **API Server**: Frontend for Kubernetes control plane
- **etcd**: Distributed key-value store for cluster data
- **Scheduler**: Assigns pods to nodes
- **Controller Manager**: Runs controller processes
- **Cloud Controller Manager**: Cloud-specific control logic

### Q4: Node Components?
- **kubelet**: Agent running on each node
- **kube-proxy**: Network proxy
- **Container Runtime**: Docker, containerd, CRI-O

### Q5: Kubernetes Objects?
- **Pod**: Smallest deployable unit
- **Service**: Expose pods as network service
- **Deployment**: Manage replica sets
- **ConfigMap**: Configuration data
- **Secret**: Sensitive data
- **Volume**: Persistent storage

### Q6: Namespaces?
Logical cluster partitioning
```bash
kubectl get namespaces
kubectl create namespace dev
kubectl get pods -n dev
```

**Default Namespaces:**
- default
- kube-system
- kube-public
- kube-node-lease

### Q7: Labels and Selectors?
```yaml
metadata:
  labels:
    app: nginx
    env: prod
    tier: frontend

selector:
  matchLabels:
    app: nginx
```

### Q8: Annotations?
Non-identifying metadata
```yaml
metadata:
  annotations:
    description: "Production nginx server"
    version: "1.0.0"
```

### Q9: kubectl Commands?
```bash
# Get resources
kubectl get pods
kubectl get services
kubectl get deployments

# Describe
kubectl describe pod my-pod

# Create/Apply
kubectl create -f deployment.yaml
kubectl apply -f deployment.yaml

# Delete
kubectl delete pod my-pod

# Logs
kubectl logs my-pod
kubectl logs -f my-pod

# Execute
kubectl exec -it my-pod -- /bin/bash
```

### Q10: Declarative vs Imperative?
**Imperative:**
```bash
kubectl create deployment nginx --image=nginx
kubectl scale deployment nginx --replicas=3
```

**Declarative:**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
spec:
  replicas: 3
  template:
    spec:
      containers:
      - name: nginx
        image: nginx
```

### Q11-Q20: Quick Concepts
- **Q11**: Cluster - Set of nodes running containerized applications
- **Q12**: Context - Cluster + user + namespace configuration
- **Q13**: kubeconfig - Configuration file for kubectl
- **Q14**: Taints and Tolerations - Node scheduling constraints
- **Q15**: Node Affinity - Pod placement preferences
- **Q16**: Resource Requests/Limits - CPU and memory allocation
- **Q17**: Liveness Probe - Check if container is running
- **Q18**: Readiness Probe - Check if container is ready for traffic
- **Q19**: Init Containers - Run before app containers
- **Q20**: Sidecar Pattern - Helper container alongside main container

---

## Pods & Workloads

### Q21: What is a Pod?
Smallest deployable unit, one or more containers
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
spec:
  containers:
  - name: nginx
    image: nginx:1.21
    ports:
    - containerPort: 80
```

### Q22: Multi-container Pod?
```yaml
spec:
  containers:
  - name: app
    image: myapp:1.0
  - name: sidecar
    image: logging-agent:1.0
```

### Q23: Pod Lifecycle?
```
Pending → Running → Succeeded/Failed
```

**Phases:**
- Pending: Accepted but not running
- Running: At least one container running
- Succeeded: All containers terminated successfully
- Failed: At least one container failed
- Unknown: State cannot be determined

### Q24: Deployment?
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.21
```

### Q25: ReplicaSet?
Maintains stable set of replica pods
```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: nginx-rs
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    # Pod template
```

### Q26: StatefulSet?
For stateful applications
```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: mysql
spec:
  serviceName: mysql
  replicas: 3
  selector:
    matchLabels:
      app: mysql
  template:
    # Pod template
  volumeClaimTemplates:
  - metadata:
      name: data
    spec:
      accessModes: ["ReadWriteOnce"]
      resources:
        requests:
          storage: 10Gi
```

**Features:**
- Stable network identity
- Ordered deployment/scaling
- Persistent storage

### Q27: DaemonSet?
Runs pod on all (or selected) nodes
```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: fluentd
spec:
  selector:
    matchLabels:
      app: fluentd
  template:
    # Pod template
```

**Use Cases:**
- Log collection
- Monitoring agents
- Storage daemons

### Q28: Job?
Run to completion
```yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: batch-job
spec:
  completions: 5
  parallelism: 2
  template:
    spec:
      containers:
      - name: worker
        image: busybox
        command: ["echo", "Hello"]
      restartPolicy: Never
```

### Q29: CronJob?
Scheduled jobs
```yaml
apiVersion: batch/v1
kind: CronJob
metadata:
  name: backup
spec:
  schedule: "0 2 * * *"  # 2 AM daily
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: backup
            image: backup:1.0
          restartPolicy: OnFailure
```

### Q30: Rolling Update?
```bash
kubectl set image deployment/nginx nginx=nginx:1.22
kubectl rollout status deployment/nginx
kubectl rollout history deployment/nginx
kubectl rollout undo deployment/nginx
```

### Q31-Q35: Workload Patterns
- **Q31**: Blue-Green Deployment - Two identical environments
- **Q32**: Canary Deployment - Gradual rollout
- **Q33**: HPA (Horizontal Pod Autoscaler) - Auto-scale based on metrics
- **Q34**: VPA (Vertical Pod Autoscaler) - Adjust resource requests
- **Q35**: Pod Disruption Budget - Limit voluntary disruptions

---

## Services & Networking

### Q36: Service Types?
```yaml
# ClusterIP (default)
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  type: ClusterIP
  selector:
    app: nginx
  ports:
  - port: 80
    targetPort: 8080

# NodePort
spec:
  type: NodePort
  ports:
  - port: 80
    targetPort: 8080
    nodePort: 30080

# LoadBalancer
spec:
  type: LoadBalancer
  ports:
  - port: 80
    targetPort: 8080

# ExternalName
spec:
  type: ExternalName
  externalName: my.database.example.com
```

### Q37: Service Discovery?
- **DNS**: my-service.my-namespace.svc.cluster.local
- **Environment Variables**: MY_SERVICE_SERVICE_HOST

### Q38: Ingress?
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: my-ingress
spec:
  rules:
  - host: myapp.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: my-service
            port:
              number: 80
```

### Q39: Ingress Controller?
- **nginx-ingress**
- **traefik**
- **HAProxy**
- **AWS ALB Ingress Controller**

### Q40: Network Policies?
```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-frontend
spec:
  podSelector:
    matchLabels:
      app: backend
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app: frontend
    ports:
    - protocol: TCP
      port: 8080
```

### Q41-Q50: Networking Concepts
- **Q41**: CNI (Container Network Interface) - Calico, Flannel, Weave
- **Q42**: Service Mesh - Istio, Linkerd
- **Q43**: DNS - CoreDNS
- **Q44**: Endpoints - Backend pods for service
- **Q45**: Headless Service - No cluster IP
- **Q46**: ExternalIPs - Access service via external IP
- **Q47**: Session Affinity - Client IP based routing
- **Q48**: Port Forwarding - kubectl port-forward
- **Q49**: Proxy - kubectl proxy
- **Q50**: Network Plugins - Overlay vs underlay networks

---

## Storage & Configuration

### Q51: Volumes?
```yaml
spec:
  containers:
  - name: app
    volumeMounts:
    - name: data
      mountPath: /data
  volumes:
  - name: data
    emptyDir: {}
```

**Volume Types:**
- emptyDir
- hostPath
- persistentVolumeClaim
- configMap
- secret
- nfs
- awsElasticBlockStore

### Q52: PersistentVolume (PV)?
```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-1
spec:
  capacity:
    storage: 10Gi
  accessModes:
  - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: standard
  hostPath:
    path: /data
```

### Q53: PersistentVolumeClaim (PVC)?
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-1
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi
  storageClassName: standard
```

### Q54: StorageClass?
```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: fast
provisioner: kubernetes.io/aws-ebs
parameters:
  type: gp3
  iopsPerGB: "10"
```

### Q55: ConfigMap?
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  database_url: "postgres://db:5432"
  log_level: "info"
```

**Usage:**
```yaml
# As environment variable
env:
- name: DATABASE_URL
  valueFrom:
    configMapKeyRef:
      name: app-config
      key: database_url

# As volume
volumes:
- name: config
  configMap:
    name: app-config
```

### Q56: Secret?
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: db-secret
type: Opaque
data:
  username: YWRtaW4=  # base64 encoded
  password: cGFzc3dvcmQ=
```

**Usage:**
```yaml
env:
- name: DB_PASSWORD
  valueFrom:
    secretKeyRef:
      name: db-secret
      key: password
```

### Q57-Q65: Storage Concepts
- **Q57**: Access Modes - ReadWriteOnce, ReadOnlyMany, ReadWriteMany
- **Q58**: Reclaim Policy - Retain, Delete, Recycle
- **Q59**: Dynamic Provisioning - Automatic PV creation
- **Q60**: Volume Snapshots - Backup and restore
- **Q61**: CSI (Container Storage Interface) - Standard for storage
- **Q62**: Ephemeral Volumes - Temporary storage
- **Q63**: Projected Volumes - Combine multiple sources
- **Q64**: DownwardAPI - Pod/container metadata
- **Q65**: Resource Quotas - Limit resource usage per namespace

---

## Security & RBAC

### Q66: RBAC (Role-Based Access Control)?
```yaml
# Role
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: pod-reader
  namespace: default
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list", "watch"]

# RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: read-pods
  namespace: default
subjects:
- kind: User
  name: jane
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: pod-reader
  apiGroup: rbac.authorization.k8s.io
```

### Q67: ClusterRole vs Role?
**Role**: Namespace-scoped
**ClusterRole**: Cluster-wide

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: cluster-admin
rules:
- apiGroups: ["*"]
  resources: ["*"]
  verbs: ["*"]
```

### Q68: ServiceAccount?
```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: my-sa
  namespace: default
---
# Use in Pod
spec:
  serviceAccountName: my-sa
```

### Q69: Security Context?
```yaml
spec:
  securityContext:
    runAsUser: 1000
    runAsGroup: 3000
    fsGroup: 2000
  containers:
  - name: app
    securityContext:
      allowPrivilegeEscalation: false
      readOnlyRootFilesystem: true
      capabilities:
        drop:
        - ALL
```

### Q70: Pod Security Standards?
- **Privileged**: Unrestricted
- **Baseline**: Minimally restrictive
- **Restricted**: Heavily restricted

### Q71-Q75: Security Best Practices
- **Q71**: Network Policies - Restrict pod communication
- **Q72**: Image Scanning - Vulnerability detection
- **Q73**: Admission Controllers - Validate/mutate requests
- **Q74**: OPA (Open Policy Agent) - Policy enforcement
- **Q75**: Secrets Encryption - Encrypt etcd data

---

## Monitoring & Troubleshooting

### Q76: Monitoring Stack?
```
Prometheus → Metrics collection
Grafana → Visualization
AlertManager → Alerting
```

### Q77: Metrics Server?
```bash
kubectl top nodes
kubectl top pods
```

### Q78: Logging?
```bash
kubectl logs pod-name
kubectl logs -f pod-name
kubectl logs pod-name -c container-name
kubectl logs --previous pod-name
```

### Q79: Events?
```bash
kubectl get events
kubectl describe pod pod-name
```

### Q80: Debugging Pods?
```bash
# Check pod status
kubectl get pods
kubectl describe pod pod-name

# Check logs
kubectl logs pod-name

# Execute commands
kubectl exec -it pod-name -- /bin/bash

# Port forward
kubectl port-forward pod-name 8080:80

# Debug with ephemeral container
kubectl debug pod-name -it --image=busybox
```

### Q81-Q85: Troubleshooting Scenarios
- **Q81**: CrashLoopBackOff - Container keeps crashing
- **Q82**: ImagePullBackOff - Cannot pull image
- **Q83**: Pending Pods - Insufficient resources
- **Q84**: Node NotReady - Node issues
- **Q85**: Service Not Accessible - Network/selector issues

---

## Advanced Topics

### Q86: Helm?
Package manager for Kubernetes
```bash
helm install myapp ./mychart
helm upgrade myapp ./mychart
helm rollback myapp 1
helm uninstall myapp
```

### Q87: Operators?
Extend Kubernetes API
- Custom Resource Definitions (CRDs)
- Custom Controllers
- Operator Pattern

### Q88: Custom Resources?
```yaml
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  name: databases.example.com
spec:
  group: example.com
  versions:
  - name: v1
    served: true
    storage: true
  scope: Namespaced
  names:
    plural: databases
    singular: database
    kind: Database
```

### Q89: Admission Webhooks?
- **Validating**: Validate requests
- **Mutating**: Modify requests

### Q90: Federation?
Manage multiple clusters

### Q91: Multi-tenancy?
- Namespaces
- Resource Quotas
- Network Policies
- RBAC

### Q92: GitOps?
- ArgoCD
- Flux
- Declarative configuration in Git

### Q93: Service Mesh?
**Istio Features:**
- Traffic management
- Security (mTLS)
- Observability
- Policy enforcement

### Q94: Cluster Autoscaler?
Automatically adjust cluster size

### Q95: Pod Priority and Preemption?
```yaml
apiVersion: scheduling.k8s.io/v1
kind: PriorityClass
metadata:
  name: high-priority
value: 1000
globalDefault: false
```

### Q96-Q100: Production Best Practices
- **Q96**: High Availability - Multi-master, multi-AZ
- **Q97**: Backup and Restore - etcd backups
- **Q98**: Upgrade Strategy - Rolling upgrades
- **Q99**: Resource Management - Requests and limits
- **Q100**: Cost Optimization - Right-sizing, spot instances

---

## Quick Reference

### Common kubectl Commands
```bash
# Context
kubectl config get-contexts
kubectl config use-context my-context

# Resources
kubectl get all
kubectl get pods -o wide
kubectl get pods --show-labels

# Apply/Delete
kubectl apply -f manifest.yaml
kubectl delete -f manifest.yaml

# Scale
kubectl scale deployment nginx --replicas=5

# Expose
kubectl expose deployment nginx --port=80 --type=LoadBalancer

# Rollout
kubectl rollout restart deployment/nginx
kubectl rollout status deployment/nginx
kubectl rollout undo deployment/nginx
```

### Resource Abbreviations
```
po  - pods
svc - services
deploy - deployments
rs - replicasets
cm - configmaps
ns - namespaces
pv - persistentvolumes
pvc - persistentvolumeclaims
```

---

**Note**: Master these Kubernetes concepts for Principal-level container orchestration and cloud-native application deployment.

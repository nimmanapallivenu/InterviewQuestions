# AWS Cloud Interview Questions - Top 100

## Table of Contents
1. [AWS Fundamentals (Q1-Q15)](#aws-fundamentals)
2. [Compute Services (Q16-Q30)](#compute-services)
3. [Storage Services (Q31-Q40)](#storage-services)
4. [Database Services (Q41-Q50)](#database-services)
5. [Networking & Content Delivery (Q51-Q60)](#networking--content-delivery)
6. [Security & Identity (Q61-Q70)](#security--identity)
7. [Monitoring & Management (Q71-Q80)](#monitoring--management)
8. [Serverless & Containers (Q81-Q90)](#serverless--containers)
9. [DevOps & CI/CD (Q91-Q95)](#devops--cicd)
10. [Best Practices & Architecture (Q96-Q100)](#best-practices--architecture)

---

## AWS Fundamentals

### Q1: What is AWS and its benefits?
**Answer:** Amazon Web Services - cloud computing platform
- **Benefits**: Scalability, Cost-effective, Global reach, Security, Reliability, Flexibility

### Q2: AWS Global Infrastructure?
**Answer:**
- **Regions**: Geographic areas (us-east-1, eu-west-1)
- **Availability Zones**: Isolated data centers within region
- **Edge Locations**: CDN endpoints for CloudFront
- **Local Zones**: Extensions for low-latency

### Q3: AWS Shared Responsibility Model?
```
AWS Responsibility (Security OF the Cloud):
- Physical infrastructure
- Hardware, software, networking
- Managed services

Customer Responsibility (Security IN the Cloud):
- Data encryption
- IAM
- OS patches
- Network configuration
- Application security
```

### Q4: AWS Well-Architected Framework?
**5 Pillars:**
1. **Operational Excellence**: Run and monitor systems
2. **Security**: Protect information and systems
3. **Reliability**: Recover from failures
4. **Performance Efficiency**: Use resources efficiently
5. **Cost Optimization**: Avoid unnecessary costs

### Q5: AWS Service Categories?
- Compute: EC2, Lambda, ECS, EKS
- Storage: S3, EBS, EFS
- Database: RDS, DynamoDB, Aurora
- Networking: VPC, Route53, CloudFront
- Security: IAM, KMS, WAF
- Management: CloudWatch, CloudTrail, Config

### Q6: AWS Free Tier?
- **Always Free**: Lambda (1M requests/month), DynamoDB (25GB)
- **12 Months Free**: EC2 t2.micro (750 hours/month), S3 (5GB)
- **Trials**: SageMaker, Inspector

### Q7: AWS Pricing Models?
- **On-Demand**: Pay per use
- **Reserved**: 1-3 year commitment (up to 75% discount)
- **Spot**: Bid for unused capacity (up to 90% discount)
- **Savings Plans**: Flexible pricing

### Q8: AWS Support Plans?
- **Basic**: Free, documentation, forums
- **Developer**: $29/month, business hours support
- **Business**: $100/month, 24/7 support, < 1 hour response
- **Enterprise**: $15,000/month, TAM, < 15 min response

### Q9: AWS CLI vs SDK vs Console?
- **Console**: Web-based GUI
- **CLI**: Command-line interface
- **SDK**: Programming language libraries (Java, Python, Node.js)

### Q10: AWS CloudFormation?
Infrastructure as Code (IaC) - JSON/YAML templates
```yaml
Resources:
  MyEC2Instance:
    Type: AWS::EC2::Instance
    Properties:
      ImageId: ami-0c55b159cbfafe1f0
      InstanceType: t2.micro
```

### Q11: AWS Organizations?
Centrally manage multiple AWS accounts
- **SCPs**: Service Control Policies
- **Consolidated Billing**
- **OU**: Organizational Units

### Q12: AWS Resource Tags?
Key-value pairs for resource organization
```
Environment: Production
Project: MyApp
CostCenter: Engineering
```

### Q13: AWS ARN (Amazon Resource Name)?
Unique identifier for AWS resources
```
arn:aws:s3:::my-bucket/object.txt
arn:aws:ec2:us-east-1:123456789012:instance/i-1234567890abcdef0
```

### Q14: AWS Service Limits?
- Soft limits: Can be increased (EC2 instances)
- Hard limits: Cannot be increased (S3 bucket names)

### Q15: AWS Compliance?
- **Certifications**: SOC, PCI DSS, HIPAA, ISO 27001
- **AWS Artifact**: Compliance reports

---

## Compute Services

### Q16: Amazon EC2 (Elastic Compute Cloud)?
Virtual servers in the cloud
- **Instance Types**: General (t3), Compute (c5), Memory (r5), Storage (i3), GPU (p3)
- **Pricing**: On-Demand, Reserved, Spot, Dedicated

### Q17: EC2 Instance Types?
```
t3.micro   - 2 vCPU, 1 GB RAM (burstable)
m5.large   - 2 vCPU, 8 GB RAM (general purpose)
c5.xlarge  - 4 vCPU, 8 GB RAM (compute optimized)
r5.2xlarge - 8 vCPU, 64 GB RAM (memory optimized)
```

### Q18: EC2 User Data?
Bootstrap script executed at instance launch
```bash
#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
```

### Q19: EC2 Instance Metadata?
Access instance information from within instance
```bash
curl http://169.254.169.254/latest/meta-data/
curl http://169.254.169.254/latest/meta-data/instance-id
```

### Q20: Amazon AMI (Amazon Machine Image)?
Template for EC2 instances
- **Public AMIs**: AWS-provided
- **Custom AMIs**: Your own images
- **Marketplace AMIs**: Third-party

### Q21: EC2 Placement Groups?
- **Cluster**: Low latency, same AZ
- **Spread**: Different hardware, max 7 instances per AZ
- **Partition**: Distributed across partitions

### Q22: EC2 Auto Scaling?
Automatically adjust capacity
```
Launch Configuration/Template
→ Auto Scaling Group
→ Scaling Policies (Target Tracking, Step, Simple)
```

### Q23: Elastic Load Balancer (ELB)?
**Types:**
- **ALB**: Application Load Balancer (HTTP/HTTPS, Layer 7)
- **NLB**: Network Load Balancer (TCP/UDP, Layer 4)
- **CLB**: Classic Load Balancer (Legacy)
- **GWLB**: Gateway Load Balancer (Layer 3)

### Q24: ALB vs NLB?
**ALB:**
- HTTP/HTTPS
- Path-based routing
- Host-based routing
- WebSocket support

**NLB:**
- TCP/UDP
- Ultra-low latency
- Static IP
- Millions of requests/sec

### Q25: Target Groups?
Route requests to registered targets
- EC2 instances
- IP addresses
- Lambda functions
- ALB

### Q26: Health Checks?
Monitor target health
```
Healthy Threshold: 2
Unhealthy Threshold: 3
Timeout: 5 seconds
Interval: 30 seconds
```

### Q27: AWS Lambda?
Serverless compute service
- **Triggers**: API Gateway, S3, DynamoDB, CloudWatch Events
- **Runtime**: Node.js, Python, Java, Go, .NET
- **Pricing**: Requests + Duration
- **Limits**: 15 min timeout, 10GB memory

### Q28: Lambda Layers?
Share code and dependencies
```
/opt/nodejs/node_modules
/opt/python/lib
/opt/java/lib
```

### Q29: Lambda Environment Variables?
```python
import os
db_host = os.environ['DB_HOST']
```

### Q30: AWS Elastic Beanstalk?
PaaS for deploying applications
- Supports: Java, .NET, PHP, Node.js, Python, Ruby, Go, Docker
- Handles: Capacity provisioning, load balancing, auto-scaling, monitoring

---

## Storage Services

### Q31: Amazon S3 (Simple Storage Service)?
Object storage service
- **Buckets**: Containers for objects
- **Objects**: Files (up to 5TB)
- **Durability**: 99.999999999% (11 9's)
- **Availability**: 99.99%

### Q32: S3 Storage Classes?
```
S3 Standard          - Frequent access
S3 Intelligent-Tiering - Auto-tiering
S3 Standard-IA       - Infrequent access
S3 One Zone-IA       - Single AZ
S3 Glacier Instant   - Archive, instant retrieval
S3 Glacier Flexible  - Archive, 1-5 min retrieval
S3 Glacier Deep      - Archive, 12 hours retrieval
```

### Q33: S3 Versioning?
Keep multiple versions of objects
```
Enabled → Suspended (cannot disable)
Version ID: unique identifier
```

### Q34: S3 Lifecycle Policies?
Automate transitions and expiration
```yaml
Transition to IA after 30 days
Transition to Glacier after 90 days
Delete after 365 days
```

### Q35: S3 Replication?
- **CRR**: Cross-Region Replication
- **SRR**: Same-Region Replication
- Requires versioning enabled

### Q36: S3 Security?
- **Bucket Policies**: Resource-based
- **IAM Policies**: User-based
- **ACLs**: Legacy
- **Encryption**: SSE-S3, SSE-KMS, SSE-C, Client-side

### Q37: S3 Pre-signed URLs?
Temporary access to private objects
```python
s3_client.generate_presigned_url(
    'get_object',
    Params={'Bucket': 'my-bucket', 'Key': 'file.txt'},
    ExpiresIn=3600
)
```

### Q38: Amazon EBS (Elastic Block Store)?
Block storage for EC2
- **Types**: gp3 (SSD), io2 (Provisioned IOPS), st1 (HDD), sc1 (Cold HDD)
- **Snapshots**: Incremental backups to S3
- **Encryption**: At rest and in transit

### Q39: EBS vs Instance Store?
**EBS:**
- Persistent
- Can detach/attach
- Snapshots

**Instance Store:**
- Ephemeral
- High performance
- Lost on stop/terminate

### Q40: Amazon EFS (Elastic File System)?
Managed NFS file system
- **Use Cases**: Shared storage, content management
- **Performance Modes**: General Purpose, Max I/O
- **Throughput Modes**: Bursting, Provisioned

---

## Database Services

### Q41: Amazon RDS (Relational Database Service)?
Managed relational databases
- **Engines**: MySQL, PostgreSQL, MariaDB, Oracle, SQL Server, Aurora
- **Features**: Automated backups, Multi-AZ, Read replicas

### Q42: RDS Multi-AZ vs Read Replicas?
**Multi-AZ:**
- High availability
- Synchronous replication
- Automatic failover
- Same region

**Read Replicas:**
- Read scalability
- Asynchronous replication
- Manual promotion
- Cross-region support

### Q43: Amazon Aurora?
MySQL/PostgreSQL-compatible database
- **Performance**: 5x MySQL, 3x PostgreSQL
- **Storage**: Auto-scaling up to 128TB
- **Replicas**: Up to 15 read replicas
- **Global Database**: Cross-region replication

### Q44: Aurora Serverless?
On-demand, auto-scaling Aurora
- **Use Cases**: Infrequent, intermittent, unpredictable workloads
- **Pricing**: Pay per second

### Q45: Amazon DynamoDB?
NoSQL key-value database
- **Performance**: Single-digit millisecond latency
- **Scaling**: Automatic
- **Pricing**: On-demand or provisioned capacity

### Q46: DynamoDB Indexes?
- **GSI**: Global Secondary Index (different partition key)
- **LSI**: Local Secondary Index (same partition key, different sort key)

### Q47: DynamoDB Streams?
Capture table modifications
- **Use Cases**: Replication, analytics, notifications
- **Retention**: 24 hours

### Q48: Amazon ElastiCache?
In-memory caching
- **Redis**: Advanced data structures, persistence, replication
- **Memcached**: Simple, multi-threaded

### Q49: Amazon Redshift?
Data warehouse
- **Use Cases**: OLAP, analytics, BI
- **Performance**: Columnar storage, parallel processing
- **Scaling**: Resize cluster

### Q50: AWS Database Migration Service (DMS)?
Migrate databases to AWS
- **Homogeneous**: Oracle to Oracle
- **Heterogeneous**: Oracle to Aurora (with Schema Conversion Tool)
- **Continuous Replication**: CDC (Change Data Capture)

---

## Networking & Content Delivery

### Q51: Amazon VPC (Virtual Private Cloud)?
Isolated network in AWS
```
VPC → Subnets → Route Tables → Internet Gateway
    → NAT Gateway → Security Groups → NACLs
```

### Q52: VPC Components?
- **Subnets**: Public (IGW route), Private (no IGW route)
- **Route Tables**: Control traffic routing
- **Internet Gateway**: Connect to internet
- **NAT Gateway**: Outbound internet for private subnets
- **VPC Peering**: Connect VPCs

### Q53: Security Groups vs NACLs?
**Security Groups:**
- Stateful
- Instance level
- Allow rules only
- Evaluate all rules

**NACLs:**
- Stateless
- Subnet level
- Allow and deny rules
- Process rules in order

### Q54: VPC Endpoints?
Private connection to AWS services
- **Interface Endpoint**: ENI with private IP (powered by PrivateLink)
- **Gateway Endpoint**: Route table entry (S3, DynamoDB)

### Q55: AWS Direct Connect?
Dedicated network connection to AWS
- **Benefits**: Consistent performance, reduced costs, private connectivity
- **Virtual Interfaces**: Public VIF, Private VIF, Transit VIF

### Q56: Amazon Route 53?
DNS web service
- **Routing Policies**: Simple, Weighted, Latency, Failover, Geolocation, Geoproximity, Multi-value
- **Health Checks**: Monitor endpoints

### Q57: Route 53 Routing Policies?
```
Simple: Single resource
Weighted: Traffic distribution (A: 70%, B: 30%)
Latency: Lowest latency
Failover: Active-passive
Geolocation: Based on user location
```

### Q58: Amazon CloudFront?
CDN (Content Delivery Network)
- **Origins**: S3, EC2, ELB, custom HTTP
- **Edge Locations**: 400+ worldwide
- **Features**: HTTPS, geo-restriction, signed URLs

### Q59: CloudFront vs S3 Transfer Acceleration?
**CloudFront:**
- Cache content at edge
- Dynamic and static content
- Custom origins

**S3 Transfer Acceleration:**
- Fast uploads to S3
- Uses CloudFront edge locations

### Q60: AWS Transit Gateway?
Connect VPCs and on-premises networks
- **Hub-and-spoke**: Central hub for connectivity
- **Routing**: Dynamic routing with BGP

---

## Security & Identity

### Q61: AWS IAM (Identity and Access Management)?
Manage access to AWS services
```
Users → Groups → Roles → Policies
```

### Q62: IAM Policies?
JSON documents defining permissions
```json
{
  "Version": "2012-10-17",
  "Statement": [{
    "Effect": "Allow",
    "Action": "s3:GetObject",
    "Resource": "arn:aws:s3:::my-bucket/*"
  }]
}
```

### Q63: IAM Roles?
Temporary credentials for AWS services
- **EC2 Instance Role**: Access AWS services from EC2
- **Lambda Execution Role**: Lambda permissions
- **Cross-Account Role**: Access resources in another account

### Q64: IAM Best Practices?
- Enable MFA
- Use roles instead of access keys
- Principle of least privilege
- Rotate credentials
- Use IAM Access Analyzer

### Q65: AWS STS (Security Token Service)?
Temporary security credentials
```
AssumeRole
AssumeRoleWithWebIdentity
AssumeRoleWithSAML
GetSessionToken
```

### Q66: AWS KMS (Key Management Service)?
Managed encryption keys
- **CMK**: Customer Master Key
- **Data Keys**: Encrypt data
- **Envelope Encryption**: Encrypt data keys with CMK

### Q67: AWS Secrets Manager?
Store and rotate secrets
- **Secrets**: Database credentials, API keys
- **Rotation**: Automatic rotation with Lambda

### Q68: AWS WAF (Web Application Firewall)?
Protect web applications
- **Rules**: IP sets, SQL injection, XSS
- **Rate Limiting**: Requests per IP

### Q69: AWS Shield?
DDoS protection
- **Standard**: Free, automatic
- **Advanced**: $3,000/month, 24/7 DDoS Response Team

### Q70: AWS GuardDuty?
Threat detection service
- **Data Sources**: VPC Flow Logs, CloudTrail, DNS logs
- **Findings**: Unauthorized access, compromised instances

---

## Monitoring & Management

### Q71: Amazon CloudWatch?
Monitoring and observability
- **Metrics**: CPU, Network, Disk, Custom
- **Alarms**: Trigger actions based on metrics
- **Logs**: Centralized logging
- **Events**: Respond to state changes

### Q72: CloudWatch Metrics?
```
EC2: CPUUtilization, NetworkIn, DiskReadOps
RDS: DatabaseConnections, ReadLatency
ELB: RequestCount, TargetResponseTime
Lambda: Invocations, Duration, Errors
```

### Q73: CloudWatch Alarms?
```
Metric: CPUUtilization
Threshold: > 80%
Period: 5 minutes
Actions: SNS notification, Auto Scaling
```

### Q74: CloudWatch Logs?
Centralized log management
- **Log Groups**: Container for log streams
- **Log Streams**: Sequence of log events
- **Metric Filters**: Extract metrics from logs
- **Insights**: Query and analyze logs

### Q75: AWS CloudTrail?
API activity logging
- **Events**: Management events, Data events, Insights events
- **Use Cases**: Compliance, security analysis, troubleshooting

### Q76: AWS Config?
Resource inventory and compliance
- **Configuration Items**: Resource configurations
- **Rules**: Compliance checks
- **Remediation**: Automatic fixes

### Q77: AWS Systems Manager?
Operational management
- **Session Manager**: Secure shell access
- **Parameter Store**: Configuration and secrets
- **Patch Manager**: Automate patching
- **Run Command**: Execute commands remotely

### Q78: AWS Trusted Advisor?
Best practice recommendations
- **Categories**: Cost optimization, Performance, Security, Fault tolerance, Service limits

### Q79: AWS X-Ray?
Distributed tracing
- **Traces**: End-to-end request path
- **Segments**: Work done by service
- **Subsegments**: Granular timing

### Q80: AWS Personal Health Dashboard?
Service health notifications
- **Events**: Scheduled maintenance, service issues
- **Affected Resources**: Your resources impacted

---

## Serverless & Containers

### Q81: AWS Lambda Best Practices?
- Keep functions small and focused
- Use environment variables
- Minimize cold starts (provisioned concurrency)
- Use layers for dependencies
- Monitor with CloudWatch

### Q82: Lambda Concurrency?
- **Reserved**: Guaranteed capacity
- **Provisioned**: Pre-warmed instances
- **Unreserved**: Shared pool (1000 default)

### Q83: AWS Step Functions?
Orchestrate Lambda functions
```
State Machine → States (Task, Choice, Parallel, Wait, Fail, Succeed)
```

### Q84: Amazon ECS (Elastic Container Service)?
Container orchestration
- **Launch Types**: EC2, Fargate
- **Components**: Cluster, Task Definition, Service, Task

### Q85: ECS vs EKS?
**ECS:**
- AWS-native
- Simpler
- Tight AWS integration

**EKS:**
- Kubernetes
- Portable
- Large ecosystem

### Q86: AWS Fargate?
Serverless compute for containers
- No EC2 management
- Pay per vCPU and memory
- Works with ECS and EKS

### Q87: Amazon ECR (Elastic Container Registry)?
Docker container registry
- Private repositories
- Integrated with ECS/EKS
- Image scanning

### Q88: AWS App Runner?
Deploy containerized web apps
- Automatic scaling
- Load balancing
- HTTPS

### Q89: Amazon API Gateway?
Create and manage APIs
- **Types**: REST, HTTP, WebSocket
- **Features**: Authentication, throttling, caching, CORS
- **Integration**: Lambda, HTTP, AWS services

### Q90: API Gateway Stages?
```
dev → test → prod
Stage variables for environment-specific config
```

---

## DevOps & CI/CD

### Q91: AWS CodeCommit?
Git repository hosting
- Private repositories
- Integrated with IAM
- Encrypted at rest and in transit

### Q92: AWS CodeBuild?
Build and test code
```yaml
version: 0.2
phases:
  install:
    commands:
      - npm install
  build:
    commands:
      - npm run build
artifacts:
  files:
    - '**/*'
```

### Q93: AWS CodeDeploy?
Automate deployments
- **Deployment Types**: In-place, Blue/Green
- **Targets**: EC2, Lambda, ECS, On-premises

### Q94: AWS CodePipeline?
CI/CD pipeline
```
Source (CodeCommit) → Build (CodeBuild) 
→ Test → Deploy (CodeDeploy)
```

### Q95: AWS CodeArtifact?
Artifact repository
- Maven, npm, PyPI, NuGet
- Upstream repositories

---

## Best Practices & Architecture

### Q96: High Availability Architecture?
```
Multi-AZ deployment
Auto Scaling
Load Balancing
RDS Multi-AZ
S3 cross-region replication
Route 53 health checks
```

### Q97: Disaster Recovery Strategies?
```
Backup & Restore: Lowest cost, highest RTO/RPO
Pilot Light: Core services running
Warm Standby: Scaled-down version
Multi-Site: Full capacity, lowest RTO/RPO
```

### Q98: Cost Optimization?
- Right-sizing instances
- Reserved Instances / Savings Plans
- Spot Instances
- S3 Intelligent-Tiering
- Delete unused resources
- Use AWS Cost Explorer
- Set up billing alarms

### Q99: Security Best Practices?
- Enable MFA
- Use IAM roles
- Encrypt data (at rest and in transit)
- Enable CloudTrail
- Use VPC
- Security Groups (least privilege)
- Regular security audits
- AWS Config rules

### Q100: Well-Architected Review?
Regular architecture assessment
- **Tools**: AWS Well-Architected Tool
- **Process**: Define workload, answer questions, review findings
- **Outcome**: Improvement plan

---

## Architecture Patterns

### Three-Tier Web Application
```
┌─────────────────────────────────────┐
│         Route 53 (DNS)              │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│      CloudFront (CDN)               │
└──────────────┬──────────────────────┘
               │
┌──────────────▼──────────────────────┐
│   Application Load Balancer         │
└──────────────┬──────────────────────┘
               │
    ┌──────────┼──────────┐
    ▼          ▼          ▼
┌────────┐ ┌────────┐ ┌────────┐
│  EC2   │ │  EC2   │ │  EC2   │
│  AZ-1  │ │  AZ-2  │ │  AZ-3  │
└───┬────┘ └───┬────┘ └───┬────┘
    └──────────┼──────────┘
               ▼
    ┌──────────────────────┐
    │   RDS Multi-AZ       │
    │  Primary + Standby   │
    └──────────────────────┘
```

### Serverless Architecture
```
┌──────────┐    ┌──────────────┐    ┌──────────┐
│  Client  │───▶│ API Gateway  │───▶│  Lambda  │
└──────────┘    └──────────────┘    └─────┬────┘
                                           │
                                    ┌──────▼──────┐
                                    │  DynamoDB   │
                                    └─────────────┘
```

### Microservices on ECS
```
┌─────────────────────────────────────────┐
│         Application Load Balancer       │
└──────────────┬──────────────────────────┘
               │
    ┌──────────┼──────────┐
    ▼          ▼          ▼
┌────────┐ ┌────────┐ ┌────────┐
│Service │ │Service │ │Service │
│   A    │ │   B    │ │   C    │
│  ECS   │ │  ECS   │ │  ECS   │
└───┬────┘ └───┬────┘ └───┬────┘
    └──────────┼──────────┘
               ▼
    ┌──────────────────────┐
    │   RDS / DynamoDB     │
    └──────────────────────┘
```

---

## Quick Reference

### Common AWS CLI Commands
```bash
# S3
aws s3 ls
aws s3 cp file.txt s3://bucket/
aws s3 sync . s3://bucket/

# EC2
aws ec2 describe-instances
aws ec2 start-instances --instance-ids i-1234567890abcdef0
aws ec2 stop-instances --instance-ids i-1234567890abcdef0

# IAM
aws iam list-users
aws iam create-user --user-name john

# CloudFormation
aws cloudformation create-stack --stack-name my-stack --template-body file://template.yaml
aws cloudformation describe-stacks --stack-name my-stack
```

### AWS Service Limits (Default)
- EC2 instances: 20 per region
- S3 buckets: 100 per account
- VPCs: 5 per region
- EBS volumes: 5000 per region
- Lambda concurrent executions: 1000 per region

---

**Note**: This guide covers essential AWS Cloud interview questions for Principal-level engineers working with cloud-native applications, microservices, and DevOps practices.

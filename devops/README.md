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

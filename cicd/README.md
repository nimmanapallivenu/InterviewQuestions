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

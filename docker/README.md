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

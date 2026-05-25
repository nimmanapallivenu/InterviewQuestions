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

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

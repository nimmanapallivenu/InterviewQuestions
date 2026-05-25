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

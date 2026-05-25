# Java & Spring Boot Interview Questions - Top 100

## Table of Contents
1. [Core Java (Q1-Q20)](#core-java)
2. [Java 8+ Features (Q21-Q35)](#java-8-features)
3. [Spring Core (Q36-Q50)](#spring-core)
4. [Spring Boot (Q51-Q65)](#spring-boot)
5. [Spring Data JPA (Q66-Q75)](#spring-data-jpa)
6. [Spring Security (Q76-Q85)](#spring-security)
7. [Microservices (Q86-Q95)](#microservices)
8. [Best Practices (Q96-Q100)](#best-practices)

---

## Core Java

### Q1: JDK vs JRE vs JVM?
**Answer:** JVM executes bytecode, JRE = JVM + libraries, JDK = JRE + dev tools

### Q2: OOP Principles?
**Answer:** Encapsulation, Inheritance, Polymorphism, Abstraction

### Q3: == vs equals()?
**Answer:** == compares references, equals() compares content

### Q4: String vs StringBuilder vs StringBuffer?
**Answer:** String immutable, StringBuilder mutable/not thread-safe, StringBuffer mutable/thread-safe

### Q5: HashMap vs ConcurrentHashMap?
**Answer:** HashMap not thread-safe, ConcurrentHashMap thread-safe with segment locking

### Q6: ArrayList vs LinkedList?
**Answer:** ArrayList: fast random access, LinkedList: fast insertion/deletion

### Q7: Comparable vs Comparator?
**Answer:** Comparable: natural ordering, Comparator: custom ordering

### Q8: Fail-fast vs Fail-safe?
**Answer:** Fail-fast throws exception on modification, Fail-safe works on copy

### Q9: Java Memory Model?
**Answer:** Stack (method calls, local vars), Heap (objects, GC managed)

### Q10: Exception Hierarchy?
**Answer:** Throwable → Error/Exception → RuntimeException (unchecked) / Checked exceptions

### Q11: final, finally, finalize?
**Answer:** final: constant, finally: always executes, finalize: before GC (deprecated)

### Q12: Abstract class vs Interface?
**Answer:** Abstract: partial implementation, Interface: contract (Java 8+ allows default methods)

### Q13: Method Overloading vs Overriding?
**Answer:** Overloading: same name different params, Overriding: subclass redefines parent method

### Q14: Static vs Instance?
**Answer:** Static: class-level, Instance: object-level

### Q15: Serialization?
**Answer:** Converting object to byte stream, implements Serializable, transient keyword

### Q16: Reflection API?
**Answer:** Inspect/modify runtime behavior, Class.forName(), getDeclaredMethods()

### Q17: Generics?
**Answer:** Type safety at compile time, List<String>, bounded types <T extends Number>

### Q18: Enum?
**Answer:** Type-safe constants, can have methods/constructors

### Q19: Annotations?
**Answer:** Metadata, @Override, @Deprecated, custom annotations

### Q20: Garbage Collection?
**Answer:** Automatic memory management, Young Gen (Eden, Survivor), Old Gen, algorithms (G1GC, ZGC)

---

## Java 8+ Features

### Q21: Lambda Expressions?
```java
// Before
Runnable r = new Runnable() { public void run() { } };
// After
Runnable r = () -> { };
```

### Q22: Functional Interfaces?
```java
Predicate<Integer> isEven = n -> n % 2 == 0;
Function<String, Integer> length = String::length;
Consumer<String> print = System.out::println;
Supplier<Double> random = Math::random;
```

### Q23: Stream API?
```java
list.stream()
    .filter(n -> n > 5)
    .map(n -> n * 2)
    .collect(Collectors.toList());
```

### Q24: Optional?
```java
Optional<String> opt = Optional.ofNullable(value);
opt.orElse("default");
opt.ifPresent(System.out::println);
```

### Q25: Method References?
```java
list.forEach(System.out::println);  // Static
list.sort(String::compareToIgnoreCase);  // Instance
```

### Q26: Default Methods in Interfaces?
```java
interface Vehicle {
    default void start() { }
    static void check() { }
}
```

### Q27: Date-Time API?
```java
LocalDate.now();
LocalDateTime.of(2024, 1, 1, 10, 30);
ZonedDateTime.now(ZoneId.of("America/New_York"));
```

### Q28: CompletableFuture?
```java
CompletableFuture.supplyAsync(() -> "Hello")
    .thenApply(String::toUpperCase)
    .thenAccept(System.out::println);
```

### Q29: Records (Java 14+)?
```java
public record Person(String name, int age) { }
```

### Q30: Sealed Classes (Java 17+)?
```java
public sealed class Shape permits Circle, Rectangle { }
```

### Q31: Pattern Matching (Java 16+)?
```java
if (obj instanceof String s) {
    System.out.println(s.toUpperCase());
}
```

### Q32: Text Blocks (Java 15+)?
```java
String json = """
    {
        "name": "John"
    }
    """;
```

### Q33: Switch Expressions (Java 14+)?
```java
String result = switch(day) {
    case MONDAY, FRIDAY -> "Work";
    case SATURDAY, SUNDAY -> "Weekend";
    default -> "Other";
};
```

### Q34: var Keyword (Java 10+)?
```java
var list = new ArrayList<String>();
var map = Map.of("key", "value");
```

### Q35: Stream Enhancements?
```java
Stream.ofNullable(value);
list.stream().takeWhile(n -> n < 5);
list.stream().dropWhile(n -> n < 5);
```

---

## Spring Core

### Q36: Dependency Injection?
```java
@Service
public class UserService {
    private final UserRepository repo;
    
    @Autowired
    public UserService(UserRepository repo) {
        this.repo = repo;
    }
}
```

### Q37: Bean Scopes?
- Singleton (default), Prototype, Request, Session, Application

### Q38: Bean Lifecycle?
Instantiation → Properties → Aware interfaces → @PostConstruct → Ready → @PreDestroy

### Q39: @Component vs @Service vs @Repository?
All are stereotypes, semantic differences for layers

### Q40: @Autowired vs @Qualifier vs @Primary?
```java
@Autowired @Qualifier("specific") 
private Service service;

@Primary // Default bean
```

### Q41: Spring AOP?
```java
@Aspect
@Component
public class LoggingAspect {
    @Before("execution(* com.example..*(..))")
    public void logBefore(JoinPoint jp) { }
    
    @Around("@annotation(Monitored)")
    public Object monitor(ProceedingJoinPoint pjp) { }
}
```

### Q42: @Transactional?
```java
@Transactional(
    propagation = Propagation.REQUIRED,
    isolation = Isolation.READ_COMMITTED,
    rollbackFor = Exception.class
)
```

### Q43: Spring Profiles?
```java
@Profile("dev")
@Configuration
public class DevConfig { }
```

### Q44: @Value vs @ConfigurationProperties?
```java
@Value("${app.name}")
private String name;

@ConfigurationProperties(prefix = "app")
public class AppProps { }
```

### Q45: Spring Events?
```java
@EventListener
public void handle(UserRegisteredEvent event) { }

publisher.publishEvent(new UserRegisteredEvent(user));
```

### Q46: Spring Caching?
```java
@Cacheable("users")
public User getUser(Long id) { }

@CacheEvict(value = "users", allEntries = true)
```

### Q47: Spring Scheduling?
```java
@Scheduled(fixedRate = 5000)
@Scheduled(cron = "0 0 * * * *")
```

### Q48: Spring Async?
```java
@Async
public CompletableFuture<String> asyncMethod() { }
```

### Q49: Spring Validation?
```java
@NotNull @Size(min=2, max=50)
private String name;

@Valid @RequestBody UserDTO user
```

### Q50: BeanPostProcessor?
```java
public class CustomBeanPostProcessor implements BeanPostProcessor {
    public Object postProcessBeforeInitialization(Object bean, String name) { }
}
```

---

## Spring Boot

### Q51: What is Spring Boot?
Auto-configuration, embedded servers, starter dependencies, production-ready

### Q52: @SpringBootApplication?
Combines @Configuration, @EnableAutoConfiguration, @ComponentScan

### Q53: Spring Boot Starters?
```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
</dependency>
```

### Q54: Auto-Configuration?
```java
@ConditionalOnClass(DataSource.class)
@ConditionalOnMissingBean
@ConditionalOnProperty(name = "feature.enabled")
```

### Q55: Spring Boot Actuator?
Health, metrics, info, env endpoints - /actuator/health

### Q56: application.properties vs application.yml?
```properties
server.port=8080
spring.datasource.url=jdbc:postgresql://localhost/db
```

### Q57: Profile-specific Configuration?
application-dev.properties, application-prod.properties

### Q58: CommandLineRunner vs ApplicationRunner?
```java
@Component
public class StartupRunner implements CommandLineRunner {
    public void run(String... args) { }
}
```

### Q59: Exception Handling?
```java
@RestControllerAdvice
public class GlobalExceptionHandler {
    @ExceptionHandler(ResourceNotFoundException.class)
    public ResponseEntity<ErrorResponse> handle(Exception ex) { }
}
```

### Q60: Spring Boot Testing?
```java
@SpringBootTest
@AutoConfigureMockMvc
public class IntegrationTest { }

@WebMvcTest(UserController.class)
@DataJpaTest
```

### Q61: Embedded Servers?
Tomcat (default), Jetty, Undertow

### Q62: Externalized Configuration?
Properties, YAML, environment variables, command-line args

### Q63: Spring Boot DevTools?
Auto-restart, LiveReload, property defaults

### Q64: Custom Auto-Configuration?
```java
@Configuration
@ConditionalOnClass(MyService.class)
@EnableConfigurationProperties(MyProperties.class)
public class MyAutoConfiguration { }
```

### Q65: Spring Boot Logging?
Logback (default), Log4j2, SLF4J facade

---

## Spring Data JPA

### Q66: What is Spring Data JPA?
Abstraction over JPA, reduces boilerplate

### Q67: Repository Hierarchy?
Repository → CrudRepository → PagingAndSortingRepository → JpaRepository

### Q68: Query Methods?
```java
List<User> findByName(String name);
List<User> findByAgeGreaterThan(int age);
List<User> findByNameAndEmail(String name, String email);
```

### Q69: @Query Annotation?
```java
@Query("SELECT u FROM User u WHERE u.email = ?1")
User findByEmail(String email);

@Query(value = "SELECT * FROM users WHERE age > ?1", nativeQuery = true)
```

### Q70: Pagination and Sorting?
```java
Page<User> findAll(Pageable pageable);
List<User> findAll(Sort sort);

// Usage
PageRequest.of(0, 10, Sort.by("name").ascending());
```

### Q71: Entity Relationships?
```java
@OneToOne
@OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
@ManyToOne
@ManyToMany
```

### Q72: Lazy vs Eager Loading?
```java
@OneToMany(fetch = FetchType.LAZY)  // Default for collections
@ManyToOne(fetch = FetchType.EAGER)  // Default for single
```

### Q73: Entity Lifecycle?
New → Managed → Detached → Removed

### Q74: @EntityGraph?
```java
@EntityGraph(attributePaths = {"orders", "address"})
User findById(Long id);
```

### Q75: Specifications?
```java
public class UserSpecifications {
    public static Specification<User> hasName(String name) {
        return (root, query, cb) -> cb.equal(root.get("name"), name);
    }
}
```

---

## Spring Security

### Q76: What is Spring Security?
Authentication and authorization framework

### Q77: Authentication vs Authorization?
Authentication: who you are, Authorization: what you can do

### Q78: Basic Configuration?
```java
@Configuration
@EnableWebSecurity
public class SecurityConfig {
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) {
        http.authorizeHttpRequests(auth -> auth
            .requestMatchers("/public/**").permitAll()
            .anyRequest().authenticated()
        ).formLogin();
        return http.build();
    }
}
```

### Q79: UserDetailsService?
```java
@Service
public class CustomUserDetailsService implements UserDetailsService {
    public UserDetails loadUserByUsername(String username) {
        User user = userRepository.findByUsername(username);
        return new org.springframework.security.core.userdetails.User(
            user.getUsername(), user.getPassword(), authorities);
    }
}
```

### Q80: Password Encoding?
```java
@Bean
public PasswordEncoder passwordEncoder() {
    return new BCryptPasswordEncoder();
}
```

### Q81: JWT Authentication?
```java
@Component
public class JwtTokenProvider {
    public String generateToken(Authentication auth) {
        return Jwts.builder()
            .setSubject(auth.getName())
            .signWith(key)
            .compact();
    }
}
```

### Q82: Method Security?
```java
@EnableMethodSecurity
@PreAuthorize("hasRole('ADMIN')")
@PostAuthorize("returnObject.owner == authentication.name")
@Secured("ROLE_USER")
```

### Q83: CORS Configuration?
```java
@Bean
public CorsConfigurationSource corsConfigurationSource() {
    CorsConfiguration config = new CorsConfiguration();
    config.setAllowedOrigins(Arrays.asList("http://localhost:3000"));
    config.setAllowedMethods(Arrays.asList("GET", "POST"));
    return source;
}
```

### Q84: OAuth2?
```java
@EnableOAuth2Client
spring.security.oauth2.client.registration.google.client-id=xxx
```

### Q85: CSRF Protection?
```java
http.csrf().disable();  // For stateless REST APIs
http.csrf().csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse());
```

---

## Microservices

### Q86: Microservices Architecture?
Independently deployable services, decentralized data, API communication

### Q87: Spring Cloud Config?
```java
@EnableConfigServer
spring.cloud.config.server.git.uri=https://github.com/config-repo
```

### Q88: Service Discovery (Eureka)?
```java
@EnableEurekaServer  // Server
@EnableEurekaClient  // Client
```

### Q89: Load Balancing?
```java
@LoadBalanced
@Bean
public RestTemplate restTemplate() { }
```

### Q90: Circuit Breaker (Resilience4j)?
```java
@CircuitBreaker(name = "userService", fallbackMethod = "fallback")
public User getUser(Long id) { }

public User fallback(Long id, Exception ex) {
    return new User("default");
}
```

### Q91: API Gateway?
```java
@EnableZuulProxy  // Zuul
// Or Spring Cloud Gateway
spring.cloud.gateway.routes[0].uri=http://user-service
```

### Q92: Distributed Tracing?
```java
@EnableZipkinServer
spring.zipkin.base-url=http://localhost:9411
```

### Q93: Feign Client?
```java
@FeignClient(name = "user-service")
public interface UserClient {
    @GetMapping("/users/{id}")
    User getUser(@PathVariable Long id);
}
```

### Q94: Event-Driven Architecture?
```java
@EnableBinding(Source.class)
public class EventPublisher {
    @Autowired
    private MessageChannel output;
    
    public void publish(Event event) {
        output.send(MessageBuilder.withPayload(event).build());
    }
}
```

### Q95: Saga Pattern?
Choreography (events) vs Orchestration (coordinator)

---

## Best Practices

### Q96: RESTful API Design?
- Use HTTP methods correctly (GET, POST, PUT, DELETE)
- Resource-based URLs (/users/{id})
- Proper status codes (200, 201, 404, 500)
- Versioning (/api/v1/)
- HATEOAS

### Q97: Exception Handling Best Practices?
- Global exception handler
- Custom exceptions
- Proper HTTP status codes
- Consistent error response format

### Q98: Logging Best Practices?
```java
private static final Logger log = LoggerFactory.getLogger(MyClass.class);
log.info("User {} logged in", username);
log.error("Error processing order", exception);
```

### Q99: Performance Optimization?
- Use caching (@Cacheable)
- Database indexing
- Connection pooling (HikariCP)
- Async processing (@Async)
- Pagination for large datasets
- N+1 query problem (use @EntityGraph)

### Q100: Security Best Practices?
- Never store passwords in plain text
- Use HTTPS
- Validate input
- Implement rate limiting
- Use security headers
- Keep dependencies updated
- Principle of least privilege

---

## Architecture Diagrams

### Spring Boot Application Architecture
```
┌─────────────────────────────────────────┐
│         Presentation Layer              │
│    @RestController / @Controller        │
├─────────────────────────────────────────┤
│          Service Layer                  │
│            @Service                     │
├─────────────────────────────────────────┤
│       Data Access Layer                 │
│    @Repository / Spring Data JPA        │
├─────────────────────────────────────────┤
│           Database                      │
└─────────────────────────────────────────┘
```

### Microservices Architecture
```
┌──────────┐    ┌──────────┐    ┌──────────┐
│  Client  │───▶│   API    │───▶│ Service  │
│          │    │ Gateway  │    │Discovery │
└──────────┘    └──────────┘    └──────────┘
                      │
        ┌─────────────┼─────────────┐
        ▼             ▼             ▼
   ┌────────┐   ┌────────┐   ┌────────┐
   │Service │   │Service │   │Service │
   │   A    │   │   B    │   │   C    │
   └────────┘   └────────┘   └────────┘
        │             │             │
        └─────────────┼─────────────┘
                      ▼
              ┌──────────────┐
              │Config Server │
              └──────────────┘
```

### Spring Security Filter Chain
```
Request → SecurityContextPersistenceFilter
       → UsernamePasswordAuthenticationFilter
       → ExceptionTranslationFilter
       → FilterSecurityInterceptor
       → Controller
```

---

## Quick Reference

### Common Annotations
- **@SpringBootApplication**: Main application class
- **@RestController**: REST API controller
- **@Service**: Business logic layer
- **@Repository**: Data access layer
- **@Autowired**: Dependency injection
- **@Transactional**: Transaction management
- **@Cacheable**: Caching
- **@Async**: Asynchronous execution
- **@Scheduled**: Scheduled tasks
- **@Valid**: Validation

### HTTP Status Codes
- **200 OK**: Success
- **201 Created**: Resource created
- **204 No Content**: Success, no body
- **400 Bad Request**: Invalid input
- **401 Unauthorized**: Authentication required
- **403 Forbidden**: No permission
- **404 Not Found**: Resource not found
- **500 Internal Server Error**: Server error

### JPA Annotations
- **@Entity**: JPA entity
- **@Table**: Table mapping
- **@Id**: Primary key
- **@GeneratedValue**: Auto-generated ID
- **@Column**: Column mapping
- **@OneToMany, @ManyToOne**: Relationships
- **@JoinColumn**: Foreign key

---

**Note**: This guide covers the most important Java and Spring Boot interview questions for Principal-level engineers. Practice implementing these concepts in real projects for better understanding.

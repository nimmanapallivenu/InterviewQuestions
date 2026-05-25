# Comprehensive Interview Question Template

## Format Structure

Each question should include:
1. **Question Title** - Clear, specific question
2. **Difficulty Level** - Junior/Mid/Senior/Principal
3. **Real-World Context** - When/why this matters
4. **Detailed Answer** - Comprehensive explanation
5. **Code Examples** - Working, production-ready code
6. **Diagrams** - Visual representations (ASCII art, flowcharts)
7. **Common Pitfalls** - What to avoid
8. **Best Practices** - Industry standards
9. **Interview Tips** - How to answer effectively
10. **Follow-up Questions** - Related topics

---

## Example: Comprehensive Question Format

### Q1: How does Spring Boot Auto-Configuration work internally?

**Difficulty:** Senior/Principal  
**Category:** Spring Boot Core Concepts  
**Real-World Scenario:** Understanding auto-configuration is crucial when debugging startup issues, customizing configurations, or creating custom starters for enterprise applications.

#### Detailed Answer

Spring Boot auto-configuration automatically configures your Spring application based on the dependencies present on the classpath. It uses conditional annotations to determine which beans should be created.

**How It Works:**

```
Application Startup
       ↓
@SpringBootApplication
       ↓
@EnableAutoConfiguration
       ↓
SpringFactoriesLoader reads META-INF/spring.factories
       ↓
Loads all AutoConfiguration classes
       ↓
Evaluates @Conditional annotations
       ↓
Creates beans if conditions are met
       ↓
Application Ready
```

#### Architecture Diagram

```
┌─────────────────────────────────────────────────────────┐
│                  @SpringBootApplication                  │
│  ┌────────────────────────────────────────────────┐    │
│  │         @EnableAutoConfiguration               │    │
│  │  ┌──────────────────────────────────────┐     │    │
│  │  │   SpringFactoriesLoader              │     │    │
│  │  │   reads spring.factories             │     │    │
│  │  └──────────────┬───────────────────────┘     │    │
│  └─────────────────┼─────────────────────────────┘    │
└────────────────────┼──────────────────────────────────┘
                     ↓
    ┌────────────────┴────────────────┐
    │                                  │
    ▼                                  ▼
┌─────────────────┐          ┌─────────────────┐
│ DataSource      │          │ Web MVC         │
│ AutoConfig      │          │ AutoConfig      │
│                 │          │                 │
│ @Conditional    │          │ @Conditional    │
│ OnClass         │          │ OnClass         │
│ (DataSource)    │          │ (DispatcherServlet)│
└────────┬────────┘          └────────┬────────┘
         │                            │
         ▼                            ▼
    [Creates Beans]            [Creates Beans]
```

#### Code Example: Custom Auto-Configuration

```java
// 1. Create Auto-Configuration Class
@Configuration
@ConditionalOnClass(MyService.class)
@ConditionalOnMissingBean(MyService.class)
@EnableConfigurationProperties(MyServiceProperties.class)
public class MyServiceAutoConfiguration {
    
    @Autowired
    private MyServiceProperties properties;
    
    @Bean
    @ConditionalOnProperty(
        prefix = "myservice",
        name = "enabled",
        havingValue = "true",
        matchIfMissing = true
    )
    public MyService myService() {
        return new MyService(properties.getUrl(), properties.getTimeout());
    }
    
    @Bean
    @ConditionalOnMissingBean
    public MyServiceHealthIndicator myServiceHealthIndicator(MyService myService) {
        return new MyServiceHealthIndicator(myService);
    }
}

// 2. Configuration Properties
@ConfigurationProperties(prefix = "myservice")
public class MyServiceProperties {
    
    /**
     * Enable/disable MyService
     */
    private boolean enabled = true;
    
    /**
     * Service URL
     */
    private String url = "http://localhost:8080";
    
    /**
     * Connection timeout in milliseconds
     */
    private int timeout = 5000;
    
    // Getters and setters
    public boolean isEnabled() { return enabled; }
    public void setEnabled(boolean enabled) { this.enabled = enabled; }
    
    public String getUrl() { return url; }
    public void setUrl(String url) { this.url = url; }
    
    public int getTimeout() { return timeout; }
    public void setTimeout(int timeout) { this.timeout = timeout; }
}

// 3. Register in META-INF/spring.factories
// org.springframework.boot.autoconfigure.EnableAutoConfiguration=\
// com.example.autoconfigure.MyServiceAutoConfiguration

// 4. Usage in application.properties
// myservice.enabled=true
// myservice.url=https://api.example.com
// myservice.timeout=10000
```

#### Conditional Annotations Explained

```java
// Class-based conditions
@ConditionalOnClass(DataSource.class)        // If class exists on classpath
@ConditionalOnMissingClass("com.example.Foo") // If class doesn't exist

// Bean-based conditions
@ConditionalOnBean(DataSource.class)         // If bean exists
@ConditionalOnMissingBean(DataSource.class)  // If bean doesn't exist

// Property-based conditions
@ConditionalOnProperty(
    prefix = "app",
    name = "feature.enabled",
    havingValue = "true",
    matchIfMissing = false
)

// Resource-based conditions
@ConditionalOnResource(resources = "classpath:config.properties")

// Expression-based conditions
@ConditionalOnExpression("${app.feature.enabled:false} and ${app.env} == 'prod'")

// Web application conditions
@ConditionalOnWebApplication(type = Type.SERVLET)
@ConditionalOnNotWebApplication
```

#### Flowchart: Auto-Configuration Decision Process

```
Start
  ↓
Is @ConditionalOnClass satisfied?
  ↓ Yes                    ↓ No
  ↓                        Skip Configuration
Is @ConditionalOnBean satisfied?
  ↓ Yes                    ↓ No
  ↓                        Skip Configuration
Is @ConditionalOnProperty satisfied?
  ↓ Yes                    ↓ No
  ↓                        Skip Configuration
Is @ConditionalOnMissingBean satisfied?
  ↓ Yes                    ↓ No
  ↓                        Skip Configuration
Create Bean
  ↓
Register in ApplicationContext
  ↓
End
```

#### Common Pitfalls

1. **Circular Dependencies**
   ```java
   // ❌ BAD: Can cause circular dependency
   @Bean
   public ServiceA serviceA(ServiceB serviceB) {
       return new ServiceA(serviceB);
   }
   
   @Bean
   public ServiceB serviceB(ServiceA serviceA) {
       return new ServiceB(serviceA);
   }
   
   // ✅ GOOD: Use @Lazy or refactor
   @Bean
   public ServiceA serviceA(@Lazy ServiceB serviceB) {
       return new ServiceA(serviceB);
   }
   ```

2. **Order of Auto-Configuration**
   ```java
   // Use @AutoConfigureBefore or @AutoConfigureAfter
   @Configuration
   @AutoConfigureBefore(DataSourceAutoConfiguration.class)
   public class MyDataSourceAutoConfiguration {
       // This runs before DataSourceAutoConfiguration
   }
   ```

3. **Overriding Auto-Configuration**
   ```java
   // ❌ BAD: Doesn't override properly
   @Bean
   public DataSource dataSource() {
       // Auto-configuration still creates its own
   }
   
   // ✅ GOOD: Exclude auto-configuration
   @SpringBootApplication(exclude = {DataSourceAutoConfiguration.class})
   public class Application {
       @Bean
       public DataSource dataSource() {
           // Your custom implementation
       }
   }
   ```

#### Best Practices

1. **Use @ConditionalOnMissingBean for Defaults**
   ```java
   @Bean
   @ConditionalOnMissingBean
   public MyService myService() {
       return new DefaultMyService();
   }
   ```

2. **Provide Configuration Properties**
   ```java
   @ConfigurationProperties(prefix = "myapp")
   @Validated
   public class MyAppProperties {
       @NotNull
       private String apiKey;
       
       @Min(1000)
       @Max(30000)
       private int timeout = 5000;
   }
   ```

3. **Document Your Auto-Configuration**
   ```java
   /**
    * Auto-configuration for MyService.
    * 
    * <p>This auto-configuration is activated when:
    * <ul>
    *   <li>{@link MyService} is on the classpath</li>
    *   <li>No {@link MyService} bean is already defined</li>
    *   <li>Property {@code myservice.enabled} is {@code true} (default)</li>
    * </ul>
    * 
    * <p>Configuration properties:
    * <ul>
    *   <li>{@code myservice.url} - Service URL (default: http://localhost:8080)</li>
    *   <li>{@code myservice.timeout} - Timeout in ms (default: 5000)</li>
    * </ul>
    */
   @Configuration
   @ConditionalOnClass(MyService.class)
   public class MyServiceAutoConfiguration {
       // ...
   }
   ```

#### Debugging Auto-Configuration

```bash
# Enable debug logging
java -jar app.jar --debug

# Or in application.properties
debug=true

# View auto-configuration report
# Shows:
# - Positive matches (configurations that were applied)
# - Negative matches (configurations that were not applied and why)
# - Exclusions
# - Unconditional classes
```

**Sample Debug Output:**
```
============================
CONDITIONS EVALUATION REPORT
============================

Positive matches:
-----------------
DataSourceAutoConfiguration matched:
  - @ConditionalOnClass found required classes 'javax.sql.DataSource', 'org.springframework.jdbc.datasource.embedded.EmbeddedDatabaseType'

Negative matches:
-----------------
RabbitAutoConfiguration:
  Did not match:
    - @ConditionalOnClass did not find required class 'com.rabbitmq.client.Channel'
```

#### Interview Tips

**How to Answer:**
1. Start with the high-level concept
2. Explain the mechanism (SpringFactoriesLoader, @Conditional)
3. Provide a concrete example
4. Discuss when you'd create custom auto-configuration
5. Mention debugging techniques

**Sample Answer:**
> "Spring Boot auto-configuration works by scanning the classpath for specific classes and automatically configuring beans based on what it finds. When the application starts, @EnableAutoConfiguration triggers SpringFactoriesLoader to read all META-INF/spring.factories files and load the auto-configuration classes listed there.
>
> Each auto-configuration class uses @Conditional annotations to determine whether it should be applied. For example, DataSourceAutoConfiguration only creates a DataSource bean if the DataSource class is on the classpath and no DataSource bean has been manually defined.
>
> In my previous project, we created a custom auto-configuration for our internal monitoring service. We used @ConditionalOnProperty to allow teams to enable/disable it via configuration, and @ConditionalOnMissingBean to allow custom implementations. This made it easy for teams to adopt our monitoring without any code changes - just add the dependency and configure properties."

#### Follow-up Questions

1. **Q:** How would you debug why an auto-configuration isn't being applied?
   **A:** Use `--debug` flag or `debug=true` in properties to see the conditions evaluation report. Check for missing classes, conflicting beans, or property conditions not being met.

2. **Q:** What's the difference between @ConditionalOnBean and @ConditionalOnClass?
   **A:** @ConditionalOnClass checks if a class exists on the classpath (compile-time), while @ConditionalOnBean checks if a bean instance exists in the ApplicationContext (runtime).

3. **Q:** How do you exclude specific auto-configurations?
   **A:** Use `@SpringBootApplication(exclude = {ClassName.class})` or `spring.autoconfigure.exclude` property.

4. **Q:** What's the order of auto-configuration execution?
   **A:** Use @AutoConfigureBefore, @AutoConfigureAfter, or @AutoConfigureOrder to control the order.

#### Real-World Use Cases

1. **Multi-Tenant Database Configuration**
   ```java
   @Configuration
   @ConditionalOnProperty(name = "app.multi-tenant.enabled", havingValue = "true")
   public class MultiTenantAutoConfiguration {
       @Bean
       public DataSource dataSource() {
           return new TenantRoutingDataSource();
       }
   }
   ```

2. **Feature Flags**
   ```java
   @Configuration
   @ConditionalOnProperty(name = "features.new-checkout.enabled")
   public class NewCheckoutAutoConfiguration {
       @Bean
       public CheckoutService checkoutService() {
           return new NewCheckoutService();
       }
   }
   ```

3. **Environment-Specific Configurations**
   ```java
   @Configuration
   @Profile("production")
   @ConditionalOnClass(CloudWatchClient.class)
   public class ProductionMonitoringAutoConfiguration {
       @Bean
       public MetricsPublisher cloudWatchPublisher() {
           return new CloudWatchMetricsPublisher();
       }
   }
   ```

#### Related Topics
- Spring Boot Starters
- Spring Profiles
- Configuration Properties
- Bean Lifecycle
- Dependency Injection
- Spring Boot Actuator

---

## Summary

This comprehensive format ensures:
- ✅ Clear, detailed explanations
- ✅ Visual diagrams and flowcharts
- ✅ Production-ready code examples
- ✅ Common pitfalls and solutions
- ✅ Best practices
- ✅ Interview preparation tips
- ✅ Real-world scenarios
- ✅ Follow-up questions

Each question should be self-contained yet connected to related topics, providing a complete learning resource.
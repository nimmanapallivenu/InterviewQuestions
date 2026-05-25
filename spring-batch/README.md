# Spring Batch & ETL - 100 Solution Architect Interview Questions
## Comprehensive Guide with Diagrams, Flowcharts & Real-World Solutions

---

## 📚 Table of Contents

### Part 1: Spring Batch Fundamentals (20 Questions)
1. [Spring Batch Architecture](#1-spring-batch-architecture)
2. [Job vs Step vs Tasklet](#2-job-vs-step-vs-tasklet)
3. [ItemReader, ItemProcessor, ItemWriter](#3-itemreader-itemprocessor-itemwriter)
4. [Chunk-Oriented Processing](#4-chunk-oriented-processing)
5. [Job Repository & Metadata](#5-job-repository--metadata)
6. [Job Launcher & Execution](#6-job-launcher--execution)
7. [Step Execution Context](#7-step-execution-context)
8. [Job Parameters](#8-job-parameters)
9. [Job Restart & Recovery](#9-job-restart--recovery)
10. [Skip & Retry Logic](#10-skip--retry-logic)
11. [Listeners & Callbacks](#11-listeners--callbacks)
12. [Partitioning](#12-partitioning)
13. [Remote Chunking](#13-remote-chunking)
14. [Parallel Processing](#14-parallel-processing)
15. [Transaction Management](#15-transaction-management)
16. [Error Handling Strategies](#16-error-handling-strategies)
17. [Job Scheduling](#17-job-scheduling)
18. [Testing Batch Jobs](#18-testing-batch-jobs)
19. [Performance Optimization](#19-performance-optimization)
20. [Monitoring & Metrics](#20-monitoring--metrics)

### Part 2: ETL Design Patterns (20 Questions)
21-40: Extract, Transform, Load patterns and best practices

### Part 3: Advanced Batch Processing (20 Questions)
41-60: Complex scenarios and enterprise solutions

### Part 4: Integration & Scalability (20 Questions)
61-80: Cloud, Kubernetes, distributed processing

### Part 5: Real-World Scenarios (20 Questions)
81-100: Banking, Finance, Insurance use cases

---

## Part 1: Spring Batch Fundamentals

### 1. Spring Batch Architecture

**Question:** Explain the complete Spring Batch architecture and how components interact in an enterprise batch processing system.

**Answer:**

#### Architecture Overview

```
┌─────────────────────────────────────────────────────────────┐
│                  SPRING BATCH ARCHITECTURE                  │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌──────────────────────────────────────────────────────┐  │
│  │              Application Layer                       │  │
│  │  ┌────────────┐  ┌────────────┐  ┌────────────┐   │  │
│  │  │Job Launcher│  │   Job      │  │   Step     │   │  │
│  │  └─────┬──────┘  └─────┬──────┘  └─────┬──────┘   │  │
│  └────────┼───────────────┼───────────────┼──────────┘  │
│           │               │               │              │
│  ┌────────▼───────────────▼───────────────▼──────────┐  │
│  │              Core Framework                       │  │
│  │  ┌──────────────────────────────────────────┐   │  │
│  │  │         Job Repository                   │   │  │
│  │  │  - Job Execution Metadata                │   │  │
│  │  │  - Step Execution Metadata               │   │  │
│  │  │  - Execution Context                     │   │  │
│  │  └──────────────────────────────────────────┘   │  │
│  └──────────────────────────────────────────────────┘  │
│                                                         │
│  ┌──────────────────────────────────────────────────┐  │
│  │         Infrastructure Layer                     │  │
│  │  ┌──────────┐  ┌──────────┐  ┌──────────┐     │  │
│  │  │ItemReader│  │Processor │  │ItemWriter│     │  │
│  │  └──────────┘  └──────────┘  └──────────┘     │  │
│  └──────────────────────────────────────────────────┘  │
│                                                         │
│  ┌──────────────────────────────────────────────────┐  │
│  │              Data Sources                        │  │
│  │  [Database] [Files] [JMS] [REST APIs]           │  │
│  └──────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
```

#### Component Interaction Flow

```
Job Launch Request
    │
    ▼
┌─────────────────┐
│  Job Launcher   │
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  Job Instance   │ (Unique combination of Job + Parameters)
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Job Execution   │ (Single attempt to run Job Instance)
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Step Execution  │ (Execution of individual Step)
└────────┬────────┘
         │
         ▼
┌─────────────────────────────────┐
│  Chunk-Oriented Processing      │
│  ┌──────────────────────────┐  │
│  │ Read → Process → Write   │  │
│  │   ↓       ↓        ↓     │  │
│  │ [Chunk Size = 100]       │  │
│  └──────────────────────────┘  │
└─────────────────────────────────┘
```

#### Complete Java Implementation

```java
/**
 * Spring Batch Configuration - Enterprise Setup
 */
@Configuration
@EnableBatchProcessing
public class BatchConfiguration {
    
    @Autowired
    private JobBuilderFactory jobBuilderFactory;
    
    @Autowired
    private StepBuilderFactory stepBuilderFactory;
    
    @Autowired
    private DataSource dataSource;
    
    /**
     * Job Definition
     * A Job is composed of one or more Steps
     */
    @Bean
    public Job importUserJob(Step step1, JobExecutionListener listener) {
        return jobBuilderFactory.get("importUserJob")
            .incrementer(new RunIdIncrementer())
            .listener(listener)
            .flow(step1)
            .end()
            .build();
    }
    
    /**
     * Step Definition
     * Chunk-oriented processing: Read-Process-Write
     */
    @Bean
    public Step step1(ItemReader<User> reader,
                     ItemProcessor<User, User> processor,
                     ItemWriter<User> writer) {
        return stepBuilderFactory.get("step1")
            .<User, User>chunk(100)  // Commit interval
            .reader(reader)
            .processor(processor)
            .writer(writer)
            .faultTolerant()
            .skipLimit(10)
            .skip(Exception.class)
            .retryLimit(3)
            .retry(DeadlockLoserDataAccessException.class)
            .listener(new StepExecutionListener())
            .build();
    }
    
    /**
     * ItemReader - Read from CSV file
     */
    @Bean
    public FlatFileItemReader<User> reader() {
        return new FlatFileItemReaderBuilder<User>()
            .name("userItemReader")
            .resource(new ClassPathResource("users.csv"))
            .delimited()
            .names("firstName", "lastName", "email")
            .fieldSetMapper(new BeanWrapperFieldSetMapper<>() {{
                setTargetType(User.class);
            }})
            .build();
    }
    
    /**
     * ItemProcessor - Transform data
     */
    @Bean
    public ItemProcessor<User, User> processor() {
        return user -> {
            // Business logic transformation
            String firstName = user.getFirstName().toUpperCase();
            String lastName = user.getLastName().toUpperCase();
            
            User transformedUser = new User(firstName, lastName, user.getEmail());
            
            // Validation
            if (!isValidEmail(transformedUser.getEmail())) {
                throw new ValidationException("Invalid email");
            }
            
            return transformedUser;
        };
    }
    
    /**
     * ItemWriter - Write to database
     */
    @Bean
    public JdbcBatchItemWriter<User> writer() {
        return new JdbcBatchItemWriterBuilder<User>()
            .itemSqlParameterSourceProvider(new BeanPropertyItemSqlParameterSourceProvider<>())
            .sql("INSERT INTO users (first_name, last_name, email) VALUES (:firstName, :lastName, :email)")
            .dataSource(dataSource)
            .build();
    }
    
    /**
     * Job Execution Listener
     */
    @Bean
    public JobExecutionListener listener() {
        return new JobExecutionListener() {
            @Override
            public void beforeJob(JobExecution jobExecution) {
                log.info("Job Started: {}", jobExecution.getJobInstance().getJobName());
            }
            
            @Override
            public void afterJob(JobExecution jobExecution) {
                if (jobExecution.getStatus() == BatchStatus.COMPLETED) {
                    log.info("Job Completed Successfully");
                } else if (jobExecution.getStatus() == BatchStatus.FAILED) {
                    log.error("Job Failed");
                }
            }
        };
    }
    
    private boolean isValidEmail(String email) {
        return email != null && email.contains("@");
    }
}

/**
 * Domain Model
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {
    private String firstName;
    private String lastName;
    private String email;
}
```

#### Job Repository Configuration

```java
/**
 * Job Repository - Stores batch metadata
 */
@Configuration
public class JobRepositoryConfiguration {
    
    @Bean
    public JobRepository jobRepository(DataSource dataSource,
                                      PlatformTransactionManager transactionManager) 
            throws Exception {
        JobRepositoryFactoryBean factory = new JobRepositoryFactoryBean();
        factory.setDataSource(dataSource);
        factory.setTransactionManager(transactionManager);
        factory.setIsolationLevelForCreate("ISOLATION_SERIALIZABLE");
        factory.setTablePrefix("BATCH_");
        factory.setMaxVarCharLength(1000);
        return factory.getObject();
    }
    
    @Bean
    public JobLauncher jobLauncher(JobRepository jobRepository) throws Exception {
        SimpleJobLauncher jobLauncher = new SimpleJobLauncher();
        jobLauncher.setJobRepository(jobRepository);
        jobLauncher.setTaskExecutor(new SimpleAsyncTaskExecutor());
        jobLauncher.afterPropertiesSet();
        return jobLauncher;
    }
}
```

#### Database Schema

```sql
-- Spring Batch Metadata Tables

-- Job Instance: Unique job + parameters
CREATE TABLE BATCH_JOB_INSTANCE (
    JOB_INSTANCE_ID BIGINT PRIMARY KEY,
    VERSION BIGINT,
    JOB_NAME VARCHAR(100) NOT NULL,
    JOB_KEY VARCHAR(32) NOT NULL,
    CONSTRAINT JOB_INST_UN UNIQUE (JOB_NAME, JOB_KEY)
);

-- Job Execution: Each run attempt
CREATE TABLE BATCH_JOB_EXECUTION (
    JOB_EXECUTION_ID BIGINT PRIMARY KEY,
    VERSION BIGINT,
    JOB_INSTANCE_ID BIGINT NOT NULL,
    CREATE_TIME TIMESTAMP NOT NULL,
    START_TIME TIMESTAMP,
    END_TIME TIMESTAMP,
    STATUS VARCHAR(10),
    EXIT_CODE VARCHAR(2500),
    EXIT_MESSAGE VARCHAR(2500),
    LAST_UPDATED TIMESTAMP,
    CONSTRAINT JOB_INST_EXEC_FK FOREIGN KEY (JOB_INSTANCE_ID)
        REFERENCES BATCH_JOB_INSTANCE(JOB_INSTANCE_ID)
);

-- Step Execution: Each step run
CREATE TABLE BATCH_STEP_EXECUTION (
    STEP_EXECUTION_ID BIGINT PRIMARY KEY,
    VERSION BIGINT NOT NULL,
    STEP_NAME VARCHAR(100) NOT NULL,
    JOB_EXECUTION_ID BIGINT NOT NULL,
    START_TIME TIMESTAMP NOT NULL,
    END_TIME TIMESTAMP,
    STATUS VARCHAR(10),
    COMMIT_COUNT BIGINT,
    READ_COUNT BIGINT,
    FILTER_COUNT BIGINT,
    WRITE_COUNT BIGINT,
    READ_SKIP_COUNT BIGINT,
    WRITE_SKIP_COUNT BIGINT,
    PROCESS_SKIP_COUNT BIGINT,
    ROLLBACK_COUNT BIGINT,
    EXIT_CODE VARCHAR(2500),
    EXIT_MESSAGE VARCHAR(2500),
    LAST_UPDATED TIMESTAMP,
    CONSTRAINT JOB_EXEC_STEP_FK FOREIGN KEY (JOB_EXECUTION_ID)
        REFERENCES BATCH_JOB_EXECUTION(JOB_EXECUTION_ID)
);
```

**Key Architectural Principles:**

1. **Separation of Concerns**: Clear separation between business logic and infrastructure
2. **Metadata Management**: Complete audit trail of all executions
3. **Restart Capability**: Can restart failed jobs from point of failure
4. **Scalability**: Support for parallel processing and partitioning
5. **Transaction Management**: Chunk-based commits for optimal performance

---

### 2. Job vs Step vs Tasklet

**Question:** What are the differences between Job, Step, and Tasklet? When should you use each?

**Answer:**

#### Conceptual Hierarchy

```
Job (Business Process)
  │
  ├── Step 1 (Extract Data)
  │   └── Chunk-Oriented Processing
  │       ├── ItemReader
  │       ├── ItemProcessor
  │       └── ItemWriter
  │
  ├── Step 2 (Transform Data)
  │   └── Tasklet (Custom Logic)
  │
  └── Step 3 (Load Data)
      └── Chunk-Oriented Processing
```

#### Detailed Comparison

```java
/**
 * JOB: Represents entire batch process
 * - Container for Steps
 * - Defines execution flow
 * - Manages job-level configuration
 */
@Bean
public Job dataProcessingJob() {
    return jobBuilderFactory.get("dataProcessingJob")
        .start(extractStep())
        .next(transformStep())
        .next(loadStep())
        .build();
}

/**
 * STEP: Unit of work within a Job
 * - Can be chunk-oriented or tasklet-based
 * - Has its own transaction boundary
 * - Can be restarted independently
 */
@Bean
public Step extractStep() {
    return stepBuilderFactory.get("extractStep")
        .<InputData, OutputData>chunk(1000)
        .reader(reader())
        .processor(processor())
        .writer(writer())
        .build();
}

/**
 * TASKLET: Simple, single-operation step
 * - Used for non-chunk operations
 * - Executes once per step
 * - Good for setup/cleanup tasks
 */
@Bean
public Step cleanupStep() {
    return stepBuilderFactory.get("cleanupStep")
        .tasklet((contribution, chunkContext) -> {
            // Custom logic
            cleanupTempFiles();
            return RepeatStatus.FINISHED;
        })
        .build();
}
```

#### When to Use Each

**Use Chunk-Oriented Step when:**
- Processing large volumes of data
- Need transaction management per chunk
- Want automatic retry/skip logic
- Reading from one source, writing to another

**Use Tasklet when:**
- Single operation (delete files, call stored procedure)
- Setup/cleanup tasks
- Calling external services
- Custom business logic that doesn't fit chunk model

#### Complete Example

```java
/**
 * Comprehensive Job with Multiple Step Types
 */
@Configuration
public class CompleteJobConfiguration {
    
    /**
     * Main Job Definition
     */
    @Bean
    public Job fileProcessingJob() {
        return jobBuilderFactory.get("fileProcessingJob")
            .start(validateInputStep())      // Tasklet
            .next(processDataStep())         // Chunk-oriented
            .next(generateReportStep())      // Tasklet
            .next(notifyStep())              // Tasklet
            .build();
    }
    
    /**
     * Step 1: Validate Input (Tasklet)
     */
    @Bean
    public Step validateInputStep() {
        return stepBuilderFactory.get("validateInputStep")
            .tasklet(new Tasklet() {
                @Override
                public RepeatStatus execute(StepContribution contribution,
                                          ChunkContext chunkContext) {
                    String inputFile = chunkContext.getStepContext()
                        .getJobParameters()
                        .get("inputFile")
                        .toString();
                    
                    if (!new File(inputFile).exists()) {
                        throw new FileNotFoundException("Input file not found");
                    }
                    
                    log.info("Input file validated: {}", inputFile);
                    return RepeatStatus.FINISHED;
                }
            })
            .build();
    }
    
    /**
     * Step 2: Process Data (Chunk-Oriented)
     */
    @Bean
    public Step processDataStep() {
        return stepBuilderFactory.get("processDataStep")
            .<Transaction, ProcessedTransaction>chunk(500)
            .reader(transactionReader())
            .processor(transactionProcessor())
            .writer(transactionWriter())
            .faultTolerant()
            .skipLimit(100)
            .skip(ValidationException.class)
            .retryLimit(3)
            .retry(DeadlockLoserDataAccessException.class)
            .listener(new ItemReadListener<Transaction>() {
                @Override
                public void beforeRead() {
                    // Pre-read logic
                }
                
                @Override
                public void afterRead(Transaction item) {
                    log.debug("Read transaction: {}", item.getId());
                }
                
                @Override
                public void onReadError(Exception ex) {
                    log.error("Read error", ex);
                }
            })
            .build();
    }
    
    /**
     * Step 3: Generate Report (Tasklet)
     */
    @Bean
    public Step generateReportStep() {
        return stepBuilderFactory.get("generateReportStep")
            .tasklet((contribution, chunkContext) -> {
                ExecutionContext jobContext = chunkContext.getStepContext()
                    .getStepExecution()
                    .getJobExecution()
                    .getExecutionContext();
                
                int processedCount = jobContext.getInt("processedCount", 0);
                int errorCount = jobContext.getInt("errorCount", 0);
                
                // Generate report
                Report report = new Report();
                report.setProcessedRecords(processedCount);
                report.setErrorRecords(errorCount);
                report.setTimestamp(LocalDateTime.now());
                
                reportService.generateReport(report);
                
                log.info("Report generated: {} processed, {} errors",
                    processedCount, errorCount);
                
                return RepeatStatus.FINISHED;
            })
            .build();
    }
    
    /**
     * Step 4: Send Notification (Tasklet)
     */
    @Bean
    public Step notifyStep() {
        return stepBuilderFactory.get("notifyStep")
            .tasklet((contribution, chunkContext) -> {
                JobExecution jobExecution = chunkContext.getStepContext()
                    .getStepExecution()
                    .getJobExecution();
                
                if (jobExecution.getStatus() == BatchStatus.COMPLETED) {
                    notificationService.sendSuccessEmail(jobExecution);
                } else {
                    notificationService.sendFailureEmail(jobExecution);
                }
                
                return RepeatStatus.FINISHED;
            })
            .build();
    }
}
```

#### Flow Control

```java
/**
 * Conditional Flow Based on Step Outcome
 */
@Bean
public Job conditionalJob() {
    return jobBuilderFactory.get("conditionalJob")
        .start(step1())
        .on("COMPLETED").to(step2())
        .from(step1())
        .on("FAILED").to(errorHandlingStep())
        .from(step2())
        .on("*").to(step3())
        .end()
        .build();
}

/**
 * Parallel Steps
 */
@Bean
public Job parallelJob() {
    Flow flow1 = new FlowBuilder<Flow>("flow1")
        .start(step1())
        .build();
    
    Flow flow2 = new FlowBuilder<Flow>("flow2")
        .start(step2())
        .build();
    
    return jobBuilderFactory.get("parallelJob")
        .start(flow1)
        .split(new SimpleAsyncTaskExecutor())
        .add(flow2)
        .end()
        .build();
}
```

---

This is the beginning of the Spring Batch guide. Would you like me to continue with more questions covering chunk-oriented processing, partitioning, error handling, and real-world scenarios?

### Quick Reference: All 100 Spring Batch Questions

#### Part 1: Fundamentals (1-20)
1. ✅ Spring Batch Architecture - Complete architecture with diagrams
2. ✅ Job vs Step vs Tasklet - Detailed comparison with examples
3. ItemReader, ItemProcessor, ItemWriter - Read-Process-Write pattern
4. Chunk-Oriented Processing - Transaction boundaries and commit intervals
5. Job Repository & Metadata - Database schema and metadata management
6. Job Launcher & Execution - Synchronous vs Asynchronous execution
7. Step Execution Context - Sharing data between steps
8. Job Parameters - Runtime parameters and validation
9. Job Restart & Recovery - Restart strategies and checkpointing
10. Skip & Retry Logic - Fault tolerance patterns
11. Listeners & Callbacks - Job and Step listeners
12. Partitioning - Parallel processing with partitions
13. Remote Chunking - Distributed processing architecture
14. Parallel Processing - Multi-threading strategies
15. Transaction Management - Chunk-level transactions
16. Error Handling Strategies - Exception handling patterns
17. Job Scheduling - Quartz, Cron, and Spring Scheduler integration
18. Testing Batch Jobs - Unit and integration testing
19. Performance Optimization - Tuning chunk size and threading
20. Monitoring & Metrics - Spring Boot Actuator and custom metrics

#### Part 2: ETL Design Patterns (21-40)
21. Extract Patterns - File, Database, API extraction
22. Transform Patterns - Data cleansing and enrichment
23. Load Patterns - Bulk insert and upsert strategies
24. CDC (Change Data Capture) - Real-time data synchronization
25. Incremental Load - Delta processing strategies
26. Full Load vs Incremental - When to use each
27. Data Validation - Validation frameworks and patterns
28. Data Quality - Quality checks and metrics
29. Data Lineage - Tracking data flow
30. Slowly Changing Dimensions - SCD Type 1, 2, 3
31. Lookup and Reference Data - Caching strategies
32. Aggregation Patterns - Summarization and rollup
33. Data Deduplication - Identifying and removing duplicates
34. Data Masking - PII protection in non-prod
35. Data Archival - Historical data management
36. Multi-Source Integration - Combining data from multiple sources
37. Data Reconciliation - Ensuring data consistency
38. Error Records Handling - Dead letter queue patterns
39. Audit Trail - Tracking all data changes
40. Data Versioning - Managing data versions

#### Part 3: Advanced Batch Processing (41-60)
41. Conditional Flow - Decision-based job flow
42. Dynamic Job Configuration - Runtime job creation
43. Job Chaining - Sequential job execution
44. Job Orchestration - Complex workflow management
45. Asynchronous Processing - Non-blocking execution
46. Event-Driven Batch - Triggering jobs from events
47. Batch + REST API - Exposing batch operations via API
48. Batch + Messaging - JMS/Kafka integration
49. File Processing Patterns - CSV, XML, JSON, Fixed-width
50. Database to Database - ETL between databases
51. Mainframe Integration - COBOL copybook processing
52. Legacy System Integration - Connecting to old systems
53. Multi-Tenant Batch - Tenant isolation strategies
54. Batch Security - Authentication and authorization
55. Encryption in Batch - Data encryption at rest and in transit
56. Compression Strategies - File compression techniques
57. Large File Processing - Handling GB/TB files
58. Streaming vs Batch - When to use each
59. Hybrid Processing - Combining batch and streaming
60. Batch Analytics - Processing for analytics workloads

#### Part 4: Integration & Scalability (61-80)
61. Cloud Batch Processing - AWS Batch, Azure Batch
62. Kubernetes Batch Jobs - CronJob and Job resources
63. Docker Containerization - Containerizing batch jobs
64. Horizontal Scaling - Scaling out batch processing
65. Vertical Scaling - Scaling up resources
66. Load Balancing - Distributing batch workload
67. High Availability - Ensuring batch job availability
68. Disaster Recovery - Backup and recovery strategies
69. Multi-Region Deployment - Geographic distribution
70. Service Mesh Integration - Istio with batch jobs
71. API Gateway Integration - Exposing batch via gateway
72. Message Queue Integration - RabbitMQ, ActiveMQ
73. Kafka Integration - Event-driven batch processing
74. Redis Integration - Caching and state management
75. Elasticsearch Integration - Indexing batch results
76. S3 Integration - Reading/writing to object storage
77. Database Sharding - Partitioning data across databases
78. Connection Pooling - Optimizing database connections
79. Resource Management - CPU, memory, disk optimization
80. Cost Optimization - Reducing cloud costs

#### Part 5: Real-World Scenarios (81-100)
81. Banking: Daily Transaction Processing - EOD batch jobs
82. Banking: Regulatory Reporting - Compliance reports
83. Banking: Interest Calculation - Account interest processing
84. Banking: Statement Generation - Monthly statements
85. Insurance: Policy Renewal - Automated renewals
86. Insurance: Claims Processing - Batch claims adjudication
87. Insurance: Premium Calculation - Risk-based pricing
88. Insurance: Commission Calculation - Agent commissions
89. Finance: Portfolio Valuation - Mark-to-market
90. Finance: Risk Calculation - VaR, stress testing
91. Finance: Trade Settlement - T+2 settlement
92. Finance: Reconciliation - Trade reconciliation
93. Retail: Inventory Sync - Store inventory updates
94. Retail: Price Updates - Bulk price changes
95. Retail: Sales Reporting - Daily sales aggregation
96. Healthcare: Claims Processing - Medical claims
97. Healthcare: Patient Data Migration - System migrations
98. Telecom: CDR Processing - Call detail records
99. Telecom: Billing - Monthly billing cycles
100. E-commerce: Order Processing - Bulk order fulfillment

---

## Detailed Solutions for Key Questions

### 3. ItemReader, ItemProcessor, ItemWriter

**Question:** Explain the Read-Process-Write pattern and provide examples for different data sources.

**Answer:**

#### Pattern Overview

```
┌──────────────────────────────────────────────────────┐
│         Chunk-Oriented Processing                    │
├──────────────────────────────────────────────────────┤
│                                                      │
│  ┌────────────┐    ┌────────────┐    ┌──────────┐ │
│  │ItemReader  │───>│ItemProcessor│───>│ItemWriter│ │
│  └────────────┘    └────────────┘    └──────────┘ │
│       │                  │                  │       │
│       ▼                  ▼                  ▼       │
│   Read Item         Transform          Write Chunk │
│   (One at a time)   (One at a time)   (Batch)     │
│                                                      │
│  Repeat until no more items                         │
│  Commit after each chunk                            │
└──────────────────────────────────────────────────────┘
```

#### Multiple ItemReader Examples

```java
/**
 * 1. FlatFileItemReader - CSV Files
 */
@Bean
public FlatFileItemReader<Customer> csvReader() {
    return new FlatFileItemReaderBuilder<Customer>()
        .name("customerReader")
        .resource(new FileSystemResource("customers.csv"))
        .delimited()
        .delimiter(",")
        .names("id", "name", "email", "phone")
        .linesToSkip(1)  // Skip header
        .fieldSetMapper(new BeanWrapperFieldSetMapper<>() {{
            setTargetType(Customer.class);
        }})
        .build();
}

/**
 * 2. JdbcCursorItemReader - Database
 */
@Bean
public JdbcCursorItemReader<Order> databaseReader() {
    return new JdbcCursorItemReaderBuilder<Order>()
        .name("orderReader")
        .dataSource(dataSource)
        .sql("SELECT order_id, customer_id, amount, order_date FROM orders WHERE status = 'PENDING'")
        .rowMapper(new BeanPropertyRowMapper<>(Order.class))
        .build();
}

/**
 * 3. JpaPagingItemReader - JPA Entities
 */
@Bean
public JpaPagingItemReader<Product> jpaReader() {
    return new JpaPagingItemReaderBuilder<Product>()
        .name("productReader")
        .entityManagerFactory(entityManagerFactory)
        .queryString("SELECT p FROM Product p WHERE p.active = true")
        .pageSize(100)
        .build();
}

/**
 * 4. JsonItemReader - JSON Files
 */
@Bean
public JsonItemReader<Transaction> jsonReader() {
    return new JsonItemReaderBuilder<Transaction>()
        .name("transactionReader")
        .resource(new FileSystemResource("transactions.json"))
        .jsonObjectReader(new JacksonJsonObjectReader<>(Transaction.class))
        .build();
}

/**
 * 5. Custom ItemReader - REST API
 */
@Component
public class RestApiItemReader implements ItemReader<ApiData> {
    
    private final RestTemplate restTemplate;
    private int currentPage = 0;
    private List<ApiData> currentBatch;
    private int currentIndex = 0;
    
    @Override
    public ApiData read() {
        if (currentBatch == null || currentIndex >= currentBatch.size()) {
            currentBatch = fetchNextBatch();
            currentIndex = 0;
            currentPage++;
            
            if (currentBatch == null || currentBatch.isEmpty()) {
                return null;  // End of data
            }
        }
        
        return currentBatch.get(currentIndex++);
    }
    
    private List<ApiData> fetchNextBatch() {
        String url = String.format("https://api.example.com/data?page=%d&size=100", currentPage);
        ApiResponse response = restTemplate.getForObject(url, ApiResponse.class);
        return response != null ? response.getData() : Collections.emptyList();
    }
}
```

#### ItemProcessor Examples

```java
/**
 * 1. Simple Transformation Processor
 */
@Component
public class CustomerProcessor implements ItemProcessor<Customer, EnrichedCustomer> {
    
    @Override
    public EnrichedCustomer process(Customer customer) {
        EnrichedCustomer enriched = new EnrichedCustomer();
        enriched.setId(customer.getId());
        enriched.setName(customer.getName().toUpperCase());
        enriched.setEmail(customer.getEmail().toLowerCase());
        
        // Add computed fields
        enriched.setFullName(customer.getFirstName() + " " + customer.getLastName());
        enriched.setAccountAge(calculateAccountAge(customer.getCreatedDate()));
        
        return enriched;
    }
}

/**
 * 2. Validation Processor
 */
@Component
public class ValidationProcessor implements ItemProcessor<Order, Order> {
    
    @Override
    public Order process(Order order) {
        // Validate
        if (order.getAmount() <= 0) {
            throw new ValidationException("Invalid amount");
        }
        
        if (order.getCustomerId() == null) {
            return null;  // Filter out invalid records
        }
        
        return order;
    }
}

/**
 * 3. Composite Processor - Chain multiple processors
 */
@Bean
public CompositeItemProcessor<Customer, EnrichedCustomer> compositeProcessor() {
    CompositeItemProcessor<Customer, EnrichedCustomer> processor = 
        new CompositeItemProcessor<>();
    
    List<ItemProcessor<?, ?>> delegates = Arrays.asList(
        validationProcessor(),
        enrichmentProcessor(),
        transformationProcessor()
    );
    
    processor.setDelegates(delegates);
    return processor;
}
```

#### ItemWriter Examples

```java
/**
 * 1. JdbcBatchItemWriter - Database Insert
 */
@Bean
public JdbcBatchItemWriter<Customer> databaseWriter() {
    return new JdbcBatchItemWriterBuilder<Customer>()
        .dataSource(dataSource)
        .sql("INSERT INTO customers (id, name, email) VALUES (:id, :name, :email)")
        .itemSqlParameterSourceProvider(new BeanPropertyItemSqlParameterSourceProvider<>())
        .build();
}

/**
 * 2. JpaItemWriter - JPA Entities
 */
@Bean
public JpaItemWriter<Product> jpaWriter() {
    JpaItemWriter<Product> writer = new JpaItemWriter<>();
    writer.setEntityManagerFactory(entityManagerFactory);
    return writer;
}

/**
 * 3. FlatFileItemWriter - CSV Output
 */
@Bean
public FlatFileItemWriter<Report> csvWriter() {
    return new FlatFileItemWriterBuilder<Report>()
        .name("reportWriter")
        .resource(new FileSystemResource("output/report.csv"))
        .delimited()
        .delimiter(",")
        .names("id", "name", "amount", "date")
        .headerCallback(writer -> writer.write("ID,Name,Amount,Date"))
        .build();
}

/**
 * 4. Custom ItemWriter - Multiple Destinations
 */
@Component
public class MultiDestinationWriter implements ItemWriter<ProcessedData> {
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    @Autowired
    private KafkaTemplate<String, ProcessedData> kafkaTemplate;
    
    @Override
    public void write(List<? extends ProcessedData> items) {
        // Write to database
        jdbcTemplate.batchUpdate(
            "INSERT INTO processed_data VALUES (?, ?, ?)",
            new BatchPreparedStatementSetter() {
                @Override
                public void setValues(PreparedStatement ps, int i) throws SQLException {
                    ProcessedData data = items.get(i);
                    ps.setLong(1, data.getId());
                    ps.setString(2, data.getName());
                    ps.setDouble(3, data.getAmount());
                }
                
                @Override
                public int getBatchSize() {
                    return items.size();
                }
            }
        );
        
        // Send to Kafka
        items.forEach(item -> 
            kafkaTemplate.send("processed-data-topic", item.getId().toString(), item)
        );
    }
}
```

---

### 12. Partitioning

**Question:** How do you implement partitioning in Spring Batch for parallel processing?

**Answer:**

#### Partitioning Architecture

```
Master Step
    │
    ├─> Partition 1 (Worker)
    │   └─> Process Records 1-1000
    │
    ├─> Partition 2 (Worker)
    │   └─> Process Records 1001-2000
    │
    ├─> Partition 3 (Worker)
    │   └─> Process Records 2001-3000
    │
    └─> Partition 4 (Worker)
        └─> Process Records 3001-4000

All partitions run in parallel
Master waits for all to complete
```

#### Complete Implementation

```java
/**
 * Partitioning Configuration
 */
@Configuration
public class PartitioningConfiguration {
    
    /**
     * Master Step - Coordinates partitions
     */
    @Bean
    public Step masterStep() {
        return stepBuilderFactory.get("masterStep")
            .partitioner("workerStep", partitioner())
            .step(workerStep())
            .gridSize(4)  // Number of partitions
            .taskExecutor(taskExecutor())
            .build();
    }
    
    /**
     * Partitioner - Divides work
     */
    @Bean
    public Partitioner partitioner() {
        return new Partitioner() {
            @Override
            public Map<String, ExecutionContext> partition(int gridSize) {
                Map<String, ExecutionContext> partitions = new HashMap<>();
                
                int totalRecords = getTotalRecordCount();
                int recordsPerPartition = totalRecords / gridSize;
                
                for (int i = 0; i < gridSize; i++) {
                    ExecutionContext context = new ExecutionContext();
                    context.putInt("minValue", i * recordsPerPartition);
                    context.putInt("maxValue", (i + 1) * recordsPerPartition);
                    context.putInt("partitionNumber", i);
                    
                    partitions.put("partition" + i, context);
                }
                
                return partitions;
            }
        };
    }
    
    /**
     * Worker Step - Processes partition
     */
    @Bean
    @StepScope
    public Step workerStep() {
        return stepBuilderFactory.get("workerStep")
            .<Customer, Customer>chunk(100)
            .reader(partitionReader(null, null))
            .processor(processor())
            .writer(writer())
            .build();
    }
    
    /**
     * Partition-aware Reader
     */
    @Bean
    @StepScope
    public JdbcPagingItemReader<Customer> partitionReader(
            @Value("#{stepExecutionContext[minValue]}") Integer minValue,
            @Value("#{stepExecutionContext[maxValue]}") Integer maxValue) {
        
        Map<String, Object> parameters = new HashMap<>();
        parameters.put("minValue", minValue);
        parameters.put("maxValue", maxValue);
        
        return new JdbcPagingItemReaderBuilder<Customer>()
            .name("partitionReader")
            .dataSource(dataSource)
            .queryProvider(queryProvider())
            .parameterValues(parameters)
            .pageSize(100)
            .rowMapper(new BeanPropertyRowMapper<>(Customer.class))
            .build();
    }
    
    /**
     * Task Executor for parallel execution
     */
    @Bean
    public TaskExecutor taskExecutor() {
        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
        executor.setCorePoolSize(4);
        executor.setMaxPoolSize(4);
        executor.setQueueCapacity(100);
        executor.setThreadNamePrefix("partition-");
        executor.initialize();
        return executor;
    }
}
```

This provides a comprehensive foundation. The guide includes detailed architecture, code examples, and covers all 100 questions in the quick reference. Would you like me to now create the Spring Kafka guide?

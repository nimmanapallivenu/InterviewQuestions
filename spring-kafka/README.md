# Spring Kafka - 100 Solution Architect Interview Questions
## Comprehensive Guide with Diagrams, Architecture & Real-World Solutions

---

## 📚 Table of Contents

### Part 1: Kafka Fundamentals (20 Questions)
1. [Kafka Architecture & Components](#1-kafka-architecture--components)
2. [Topics, Partitions & Replication](#2-topics-partitions--replication)
3. [Producers & Message Publishing](#3-producers--message-publishing)
4. [Consumers & Consumer Groups](#4-consumers--consumer-groups)
5. [Offset Management](#5-offset-management)
6. [Kafka Brokers & Cluster](#6-kafka-brokers--cluster)
7. [ZooKeeper vs KRaft](#7-zookeeper-vs-kraft)
8. [Message Serialization](#8-message-serialization)
9. [Partitioning Strategies](#9-partitioning-strategies)
10. [Replication & ISR](#10-replication--isr)
11. [Leader Election](#11-leader-election)
12. [Consumer Rebalancing](#12-consumer-rebalancing)
13. [Kafka Connect](#13-kafka-connect)
14. [Schema Registry](#14-schema-registry)
15. [Message Compression](#15-message-compression)
16. [Retention Policies](#16-retention-policies)
17. [Log Compaction](#17-log-compaction)
18. [Kafka Security](#18-kafka-security)
19. [Monitoring & Metrics](#19-monitoring--metrics)
20. [Performance Tuning](#20-performance-tuning)

### Part 2: Spring Kafka Integration (20 Questions)
21-40: Spring Boot Kafka configuration and patterns

### Part 3: Advanced Patterns (20 Questions)
41-60: Exactly-once semantics, transactions, stream processing

### Part 4: Enterprise Architecture (20 Questions)
61-80: Scalability, high availability, disaster recovery

### Part 5: Real-World Scenarios (20 Questions)
81-100: Banking, Finance, Insurance use cases

---

## Part 1: Kafka Fundamentals

### 1. Kafka Architecture & Components

**Question:** Explain the complete Apache Kafka architecture and how all components interact in an enterprise event-driven system.

**Answer:**

#### High-Level Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                    KAFKA CLUSTER ARCHITECTURE                   │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │                    Producers                             │  │
│  │  [App 1] [App 2] [App 3] [Microservices]               │  │
│  └────────────────────┬─────────────────────────────────────┘  │
│                       │                                         │
│                       ▼                                         │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │                  Kafka Brokers                           │  │
│  │  ┌──────────┐  ┌──────────┐  ┌──────────┐             │  │
│  │  │ Broker 1 │  │ Broker 2 │  │ Broker 3 │             │  │
│  │  │          │  │          │  │          │             │  │
│  │  │ Topic A  │  │ Topic A  │  │ Topic B  │             │  │
│  │  │ P0 (L)   │  │ P1 (L)   │  │ P0 (L)   │             │  │
│  │  │ P1 (F)   │  │ P0 (F)   │  │ P1 (F)   │             │  │
│  │  └──────────┘  └──────────┘  └──────────┘             │  │
│  │  L = Leader, F = Follower                              │  │
│  └────────────────────┬─────────────────────────────────────┘  │
│                       │                                         │
│                       ▼                                         │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │                 Consumer Groups                          │  │
│  │  ┌─────────────────────────────────────────────────┐   │  │
│  │  │ Group 1: [C1] [C2] [C3]                         │   │  │
│  │  │ Group 2: [C1] [C2]                              │   │  │
│  │  └─────────────────────────────────────────────────┘   │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                 │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │              ZooKeeper / KRaft                           │  │
│  │  - Cluster Coordination                                  │  │
│  │  - Leader Election                                       │  │
│  │  - Configuration Management                              │  │
│  └──────────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────────┘
```

#### Component Interaction Flow

```
Producer                Broker                  Consumer
   │                       │                        │
   │  1. Send Message      │                        │
   │──────────────────────>│                        │
   │                       │                        │
   │  2. Ack (Leader)      │                        │
   │<──────────────────────│                        │
   │                       │                        │
   │                       │  3. Replicate          │
   │                       │────────────>           │
   │                       │  (to Followers)        │
   │                       │                        │
   │                       │  4. Poll Request       │
   │                       │<───────────────────────│
   │                       │                        │
   │                       │  5. Return Messages    │
   │                       │───────────────────────>│
   │                       │                        │
   │                       │  6. Commit Offset      │
   │                       │<───────────────────────│
```

#### Spring Boot Kafka Configuration

```java
/**
 * Complete Kafka Configuration for Enterprise Application
 */
@Configuration
@EnableKafka
public class KafkaConfiguration {
    
    @Value("${spring.kafka.bootstrap-servers}")
    private String bootstrapServers;
    
    /**
     * Producer Configuration
     */
    @Bean
    public ProducerFactory<String, Object> producerFactory() {
        Map<String, Object> config = new HashMap<>();
        
        // Connection
        config.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, bootstrapServers);
        
        // Serialization
        config.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, 
            StringSerializer.class);
        config.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, 
            JsonSerializer.class);
        
        // Reliability
        config.put(ProducerConfig.ACKS_CONFIG, "all");  // Wait for all replicas
        config.put(ProducerConfig.RETRIES_CONFIG, 3);
        config.put(ProducerConfig.MAX_IN_FLIGHT_REQUESTS_PER_CONNECTION, 1);
        config.put(ProducerConfig.ENABLE_IDEMPOTENCE_CONFIG, true);
        
        // Performance
        config.put(ProducerConfig.BATCH_SIZE_CONFIG, 16384);
        config.put(ProducerConfig.LINGER_MS_CONFIG, 10);
        config.put(ProducerConfig.COMPRESSION_TYPE_CONFIG, "snappy");
        config.put(ProducerConfig.BUFFER_MEMORY_CONFIG, 33554432);
        
        return new DefaultKafkaProducerFactory<>(config);
    }
    
    @Bean
    public KafkaTemplate<String, Object> kafkaTemplate() {
        return new KafkaTemplate<>(producerFactory());
    }
    
    /**
     * Consumer Configuration
     */
    @Bean
    public ConsumerFactory<String, Object> consumerFactory() {
        Map<String, Object> config = new HashMap<>();
        
        // Connection
        config.put(ConsumerConfig.BOOTSTRAP_SERVERS_CONFIG, bootstrapServers);
        
        // Deserialization
        config.put(ConsumerConfig.KEY_DESERIALIZER_CLASS_CONFIG, 
            StringDeserializer.class);
        config.put(ConsumerConfig.VALUE_DESERIALIZER_CLASS_CONFIG, 
            JsonDeserializer.class);
        config.put(JsonDeserializer.TRUSTED_PACKAGES, "*");
        
        // Consumer Group
        config.put(ConsumerConfig.GROUP_ID_CONFIG, "transaction-processor-group");
        
        // Offset Management
        config.put(ConsumerConfig.AUTO_OFFSET_RESET_CONFIG, "earliest");
        config.put(ConsumerConfig.ENABLE_AUTO_COMMIT_CONFIG, false);
        
        // Performance
        config.put(ConsumerConfig.MAX_POLL_RECORDS_CONFIG, 500);
        config.put(ConsumerConfig.FETCH_MIN_BYTES_CONFIG, 1024);
        config.put(ConsumerConfig.FETCH_MAX_WAIT_MS_CONFIG, 500);
        
        // Session Management
        config.put(ConsumerConfig.SESSION_TIMEOUT_MS_CONFIG, 30000);
        config.put(ConsumerConfig.HEARTBEAT_INTERVAL_MS_CONFIG, 3000);
        config.put(ConsumerConfig.MAX_POLL_INTERVAL_MS_CONFIG, 300000);
        
        return new DefaultKafkaConsumerFactory<>(config);
    }
    
    @Bean
    public ConcurrentKafkaListenerContainerFactory<String, Object> 
            kafkaListenerContainerFactory() {
        ConcurrentKafkaListenerContainerFactory<String, Object> factory = 
            new ConcurrentKafkaListenerContainerFactory<>();
        factory.setConsumerFactory(consumerFactory());
        factory.setConcurrency(3);  // Number of consumer threads
        factory.getContainerProperties()
            .setAckMode(ContainerProperties.AckMode.MANUAL_IMMEDIATE);
        return factory;
    }
    
    /**
     * Admin Configuration - Topic Management
     */
    @Bean
    public KafkaAdmin kafkaAdmin() {
        Map<String, Object> config = new HashMap<>();
        config.put(AdminClientConfig.BOOTSTRAP_SERVERS_CONFIG, bootstrapServers);
        return new KafkaAdmin(config);
    }
    
    @Bean
    public NewTopic transactionTopic() {
        return TopicBuilder.name("transactions")
            .partitions(6)
            .replicas(3)
            .config(TopicConfig.RETENTION_MS_CONFIG, "604800000")  // 7 days
            .config(TopicConfig.COMPRESSION_TYPE_CONFIG, "snappy")
            .config(TopicConfig.MIN_IN_SYNC_REPLICAS_CONFIG, "2")
            .build();
    }
}
```

#### Producer Implementation

```java
/**
 * Kafka Producer Service
 */
@Service
@Slf4j
public class KafkaProducerService {
    
    @Autowired
    private KafkaTemplate<String, Object> kafkaTemplate;
    
    /**
     * Send message with key (for partitioning)
     */
    public void sendMessage(String topic, String key, Object message) {
        ListenableFuture<SendResult<String, Object>> future = 
            kafkaTemplate.send(topic, key, message);
        
        future.addCallback(
            result -> {
                log.info("Message sent successfully: topic={}, partition={}, offset={}", 
                    topic, 
                    result.getRecordMetadata().partition(),
                    result.getRecordMetadata().offset());
            },
            ex -> {
                log.error("Failed to send message: topic={}, key={}", topic, key, ex);
            }
        );
    }
    
    /**
     * Send message with headers
     */
    public void sendMessageWithHeaders(String topic, String key, Object message, 
                                      Map<String, String> headers) {
        ProducerRecord<String, Object> record = new ProducerRecord<>(topic, key, message);
        
        // Add headers
        headers.forEach((headerKey, headerValue) -> 
            record.headers().add(headerKey, headerValue.getBytes()));
        
        kafkaTemplate.send(record);
    }
    
    /**
     * Send message to specific partition
     */
    public void sendToPartition(String topic, int partition, String key, Object message) {
        kafkaTemplate.send(topic, partition, key, message);
    }
    
    /**
     * Transactional send
     */
    @Transactional
    public void sendTransactional(String topic, List<Object> messages) {
        messages.forEach(message -> 
            kafkaTemplate.send(topic, message.toString(), message));
    }
}
```

#### Consumer Implementation

```java
/**
 * Kafka Consumer Service
 */
@Service
@Slf4j
public class KafkaConsumerService {
    
    /**
     * Simple Consumer
     */
    @KafkaListener(
        topics = "transactions",
        groupId = "transaction-processor-group"
    )
    public void consumeTransaction(
            @Payload Transaction transaction,
            @Header(KafkaHeaders.RECEIVED_PARTITION_ID) int partition,
            @Header(KafkaHeaders.OFFSET) long offset,
            Acknowledgment acknowledgment) {
        
        try {
            log.info("Received transaction: id={}, partition={}, offset={}", 
                transaction.getId(), partition, offset);
            
            // Process transaction
            processTransaction(transaction);
            
            // Manual commit
            acknowledgment.acknowledge();
            
        } catch (Exception e) {
            log.error("Error processing transaction", e);
            // Don't acknowledge - message will be reprocessed
        }
    }
    
    /**
     * Batch Consumer
     */
    @KafkaListener(
        topics = "orders",
        groupId = "order-processor-group",
        containerFactory = "batchKafkaListenerContainerFactory"
    )
    public void consumeOrderBatch(
            List<Order> orders,
            Acknowledgment acknowledgment) {
        
        log.info("Received batch of {} orders", orders.size());
        
        try {
            // Process batch
            orders.forEach(this::processOrder);
            acknowledgment.acknowledge();
        } catch (Exception e) {
            log.error("Error processing order batch", e);
        }
    }
    
    /**
     * Consumer with Error Handling
     */
    @KafkaListener(
        topics = "payments",
        groupId = "payment-processor-group"
    )
    public void consumePayment(
            ConsumerRecord<String, Payment> record,
            Acknowledgment acknowledgment) {
        
        try {
            Payment payment = record.value();
            
            // Validate
            if (!isValid(payment)) {
                sendToDeadLetterQueue(record);
                acknowledgment.acknowledge();
                return;
            }
            
            // Process
            processPayment(payment);
            acknowledgment.acknowledge();
            
        } catch (RetryableException e) {
            log.warn("Retryable error, will retry", e);
            throw e;  // Don't acknowledge, will be retried
        } catch (Exception e) {
            log.error("Non-retryable error", e);
            sendToDeadLetterQueue(record);
            acknowledgment.acknowledge();
        }
    }
    
    private void sendToDeadLetterQueue(ConsumerRecord<String, ?> record) {
        kafkaTemplate.send("payment-dlq", record.key(), record.value());
    }
}
```

#### Error Handling Configuration

```java
/**
 * Error Handling and Retry Configuration
 */
@Configuration
public class KafkaErrorHandlingConfiguration {
    
    @Bean
    public ConcurrentKafkaListenerContainerFactory<String, Object> 
            errorHandlingKafkaListenerContainerFactory(
                ConsumerFactory<String, Object> consumerFactory) {
        
        ConcurrentKafkaListenerContainerFactory<String, Object> factory = 
            new ConcurrentKafkaListenerContainerFactory<>();
        factory.setConsumerFactory(consumerFactory);
        
        // Error Handler
        factory.setCommonErrorHandler(new DefaultErrorHandler(
            new DeadLetterPublishingRecoverer(kafkaTemplate(),
                (record, ex) -> {
                    // Route to DLQ based on exception type
                    if (ex.getCause() instanceof ValidationException) {
                        return new TopicPartition("validation-dlq", 
                            record.partition());
                    }
                    return new TopicPartition("general-dlq", 
                        record.partition());
                }),
            new FixedBackOff(1000L, 3L)  // 3 retries with 1 second delay
        ));
        
        return factory;
    }
}
```

**Key Architectural Principles:**

1. **Distributed Architecture**: Horizontal scalability across multiple brokers
2. **Fault Tolerance**: Replication ensures no data loss
3. **High Throughput**: Optimized for millions of messages per second
4. **Durability**: Messages persisted to disk
5. **Ordering Guarantee**: Within a partition, messages are ordered

---

### 2. Topics, Partitions & Replication

**Question:** Explain Kafka topics, partitions, and replication strategy. How do you design partition strategy for high throughput?

**Answer:**

#### Topic Architecture

```
Topic: "transactions"
├── Partition 0 (Leader: Broker 1, Replicas: Broker 2, 3)
│   ├── Offset 0: {msg1}
│   ├── Offset 1: {msg2}
│   └── Offset 2: {msg3}
│
├── Partition 1 (Leader: Broker 2, Replicas: Broker 1, 3)
│   ├── Offset 0: {msg4}
│   ├── Offset 1: {msg5}
│   └── Offset 2: {msg6}
│
└── Partition 2 (Leader: Broker 3, Replicas: Broker 1, 2)
    ├── Offset 0: {msg7}
    ├── Offset 1: {msg8}
    └── Offset 2: {msg9}
```

#### Replication Flow

```
Producer sends message to Partition 0
         │
         ▼
┌─────────────────────┐
│  Broker 1 (Leader)  │
│  Partition 0        │
│  Write to log       │
└──────────┬──────────┘
           │
           ├──────────────────────┐
           │                      │
           ▼                      ▼
┌──────────────────┐    ┌──────────────────┐
│ Broker 2         │    │ Broker 3         │
│ (Follower)       │    │ (Follower)       │
│ Replicate        │    │ Replicate        │
└──────────────────┘    └──────────────────┘

ISR (In-Sync Replicas): [Broker 1, Broker 2, Broker 3]
```

#### Partition Strategy Implementation

```java
/**
 * Custom Partitioner for Business Logic
 */
public class CustomPartitioner implements Partitioner {
    
    @Override
    public int partition(String topic, Object key, byte[] keyBytes,
                        Object value, byte[] valueBytes, Cluster cluster) {
        
        List<PartitionInfo> partitions = cluster.partitionsForTopic(topic);
        int numPartitions = partitions.size();
        
        if (key == null) {
            // Round-robin for null keys
            return ThreadLocalRandom.current().nextInt(numPartitions);
        }
        
        // Custom logic based on key
        if (key instanceof String) {
            String keyStr = (String) key;
            
            // Route high-priority messages to specific partition
            if (keyStr.startsWith("PRIORITY_")) {
                return 0;  // Dedicated partition for priority messages
            }
            
            // Geographic routing
            if (keyStr.startsWith("US_")) {
                return 1;
            } else if (keyStr.startsWith("EU_")) {
                return 2;
            } else if (keyStr.startsWith("ASIA_")) {
                return 3;
            }
            
            // Default: hash-based partitioning
            return Math.abs(keyStr.hashCode()) % numPartitions;
        }
        
        return Math.abs(key.hashCode()) % numPartitions;
    }
    
    @Override
    public void close() {}
    
    @Override
    public void configure(Map<String, ?> configs) {}
}

/**
 * Configure Custom Partitioner
 */
@Configuration
public class PartitionerConfiguration {
    
    @Bean
    public ProducerFactory<String, Object> producerFactory() {
        Map<String, Object> config = new HashMap<>();
        config.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, bootstrapServers);
        config.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, 
            StringSerializer.class);
        config.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, 
            JsonSerializer.class);
        
        // Custom Partitioner
        config.put(ProducerConfig.PARTITIONER_CLASS_CONFIG, 
            CustomPartitioner.class);
        
        return new DefaultKafkaProducerFactory<>(config);
    }
}
```

#### Topic Management

```java
/**
 * Dynamic Topic Creation and Management
 */
@Service
public class TopicManagementService {
    
    @Autowired
    private KafkaAdmin kafkaAdmin;
    
    /**
     * Create topic with custom configuration
     */
    public void createTopic(String topicName, int partitions, short replicationFactor) {
        NewTopic topic = TopicBuilder.name(topicName)
            .partitions(partitions)
            .replicas(replicationFactor)
            .config(TopicConfig.RETENTION_MS_CONFIG, "604800000")  // 7 days
            .config(TopicConfig.SEGMENT_MS_CONFIG, "86400000")     // 1 day
            .config(TopicConfig.COMPRESSION_TYPE_CONFIG, "snappy")
            .config(TopicConfig.MIN_IN_SYNC_REPLICAS_CONFIG, "2")
            .config(TopicConfig.CLEANUP_POLICY_CONFIG, "delete")
            .build();
        
        kafkaAdmin.createOrModifyTopics(topic);
    }
    
    /**
     * Get topic metadata
     */
    public Map<String, TopicDescription> describeTopics(List<String> topicNames) {
        try (AdminClient adminClient = AdminClient.create(
                kafkaAdmin.getConfigurationProperties())) {
            
            DescribeTopicsResult result = adminClient.describeTopics(topicNames);
            return result.all().get();
        } catch (Exception e) {
            throw new RuntimeException("Failed to describe topics", e);
        }
    }
    
    /**
     * Increase partitions
     */
    public void increasePartitions(String topicName, int newPartitionCount) {
        try (AdminClient adminClient = AdminClient.create(
                kafkaAdmin.getConfigurationProperties())) {
            
            Map<String, NewPartitions> newPartitions = new HashMap<>();
            newPartitions.put(topicName, NewPartitions.increaseTo(newPartitionCount));
            
            adminClient.createPartitions(newPartitions).all().get();
        } catch (Exception e) {
            throw new RuntimeException("Failed to increase partitions", e);
        }
    }
}
```

#### Partition Assignment Strategy

```java
/**
 * Consumer Partition Assignment
 */
@Configuration
public class ConsumerPartitionConfiguration {
    
    @Bean
    public ConsumerFactory<String, Object> consumerFactory() {
        Map<String, Object> config = new HashMap<>();
        config.put(ConsumerConfig.BOOTSTRAP_SERVERS_CONFIG, bootstrapServers);
        
        // Partition Assignment Strategy
        // Options: RangeAssignor, RoundRobinAssignor, StickyAssignor, CooperativeStickyAssignor
        config.put(ConsumerConfig.PARTITION_ASSIGNMENT_STRATEGY_CONFIG,
            Arrays.asList(
                CooperativeStickyAssignor.class,
                RoundRobinAssignor.class
            ));
        
        return new DefaultKafkaConsumerFactory<>(config);
    }
}
```

**Partition Design Best Practices:**

1. **Number of Partitions**: Start with (desired throughput / partition throughput)
2. **Key Selection**: Choose keys that distribute evenly
3. **Replication Factor**: Typically 3 for production
4. **Min In-Sync Replicas**: Set to 2 for durability
5. **Partition Count**: Can only increase, never decrease

---

This is the beginning of the Spring Kafka guide. Would you like me to continue with more questions?

### Quick Reference: All 100 Spring Kafka Questions

#### Part 1: Kafka Fundamentals (1-20)
1. ✅ Kafka Architecture & Components - Complete architecture with diagrams
2. ✅ Topics, Partitions & Replication - Partition strategy and replication
3. Producers & Message Publishing - Producer patterns and best practices
4. Consumers & Consumer Groups - Consumer group coordination
5. Offset Management - Manual vs automatic offset management
6. Kafka Brokers & Cluster - Broker configuration and cluster setup
7. ZooKeeper vs KRaft - Metadata management comparison
8. Message Serialization - Avro, JSON, Protobuf serialization
9. Partitioning Strategies - Custom partitioners and key selection
10. Replication & ISR - In-Sync Replicas and durability
11. Leader Election - Partition leader election process
12. Consumer Rebalancing - Rebalance protocols and strategies
13. Kafka Connect - Source and sink connectors
14. Schema Registry - Schema evolution and compatibility
15. Message Compression - Compression algorithms and trade-offs
16. Retention Policies - Time-based and size-based retention
17. Log Compaction - Compacted topics for state management
18. Kafka Security - SSL, SASL, ACLs, encryption
19. Monitoring & Metrics - JMX metrics and monitoring tools
20. Performance Tuning - Throughput and latency optimization

#### Part 2: Spring Kafka Integration (21-40)
21. Spring Boot Auto-Configuration - Kafka starter configuration
22. KafkaTemplate - Sending messages with Spring
23. @KafkaListener - Consuming messages with annotations
24. Message Converters - JSON, Avro, custom converters
25. Error Handling - Retry, DLQ, error handlers
26. Batch Listeners - Processing messages in batches
27. Concurrent Consumers - Multi-threaded consumption
28. Manual Acknowledgment - Controlling offset commits
29. Kafka Streams with Spring - Stream processing integration
30. Testing Kafka Applications - EmbeddedKafka, Testcontainers
31. Kafka Health Indicators - Spring Boot Actuator integration
32. Custom Serializers - Implementing custom serialization
33. Header Management - Working with message headers
34. Filtering Messages - Message filtering strategies
35. Message Routing - Dynamic topic routing
36. Kafka Transactions - Transactional messaging
37. Request-Reply Pattern - Synchronous communication
38. Kafka Admin Operations - Topic management via Spring
39. Multiple Kafka Clusters - Multi-cluster configuration
40. Kafka Metrics - Micrometer integration

#### Part 3: Advanced Patterns (41-60)
41. Exactly-Once Semantics - Idempotent producers and transactions
42. Transactional Outbox - Database and Kafka consistency
43. Saga Pattern - Distributed transactions with Kafka
44. Event Sourcing - Event-driven architecture
45. CQRS with Kafka - Command Query Responsibility Segregation
46. Kafka Streams - Stream processing fundamentals
47. KTable and GlobalKTable - Stateful stream processing
48. Windowing Operations - Time-based aggregations
49. Joins in Kafka Streams - Stream-stream, stream-table joins
50. State Stores - Managing state in stream processing
51. Interactive Queries - Querying stream state
52. Kafka Streams Testing - TopologyTestDriver
53. Change Data Capture - CDC with Debezium
54. Dead Letter Queue - DLQ patterns and implementation
55. Retry Strategies - Exponential backoff, circuit breaker
56. Message Deduplication - Handling duplicate messages
57. Message Ordering - Maintaining order guarantees
58. Poison Pill Messages - Handling corrupted messages
59. Backpressure Handling - Flow control strategies
60. Multi-Tenancy - Tenant isolation in Kafka

#### Part 4: Enterprise Architecture (61-80)
61. High Availability Setup - Multi-AZ deployment
62. Disaster Recovery - Backup and recovery strategies
63. Cross-Region Replication - MirrorMaker 2.0
64. Kafka on Kubernetes - Strimzi operator
65. Kafka on AWS - MSK (Managed Streaming for Kafka)
66. Kafka on Azure - Event Hubs for Kafka
67. Kafka on GCP - Confluent Cloud
68. Capacity Planning - Sizing brokers and partitions
69. Network Optimization - Network topology and bandwidth
70. Storage Optimization - Disk I/O and retention
71. Security Architecture - End-to-end encryption
72. Authentication & Authorization - SASL, OAuth, mTLS
73. Audit Logging - Compliance and audit trails
74. Rate Limiting - Throttling producers and consumers
75. Quota Management - Bandwidth and request quotas
76. Monitoring Architecture - Prometheus, Grafana
77. Alerting Strategies - Critical alerts and thresholds
78. Performance Benchmarking - Load testing Kafka
79. Cost Optimization - Reducing infrastructure costs
80. Operational Best Practices - Production readiness

#### Part 5: Real-World Scenarios (81-100)
81. Banking: Real-Time Payments - Payment processing pipeline
82. Banking: Fraud Detection - Real-time fraud analysis
83. Banking: Transaction Monitoring - AML compliance
84. Banking: Account Aggregation - Multi-source data aggregation
85. Insurance: Claims Processing - Event-driven claims workflow
86. Insurance: Policy Updates - Real-time policy synchronization
87. Insurance: Risk Assessment - Streaming risk calculations
88. Finance: Trade Processing - High-frequency trading
89. Finance: Market Data - Real-time market data distribution
90. Finance: Portfolio Management - Real-time portfolio updates
91. Finance: Regulatory Reporting - Compliance data streaming
92. E-commerce: Order Processing - Order fulfillment pipeline
93. E-commerce: Inventory Management - Real-time inventory sync
94. E-commerce: Recommendation Engine - Real-time recommendations
95. Healthcare: Patient Data Sync - HIPAA-compliant streaming
96. Telecom: CDR Processing - Call detail record processing
97. IoT: Sensor Data - High-volume sensor data ingestion
98. Logistics: Shipment Tracking - Real-time tracking updates
99. Retail: Point of Sale - POS transaction streaming
100. Media: Content Delivery - Video streaming analytics

---

## Detailed Solutions for Key Questions

### 5. Offset Management

**Question:** Explain offset management strategies in Kafka. How do you implement manual offset management for exactly-once processing?

**Answer:**

#### Offset Management Architecture

```
Consumer Group: "payment-processors"
Topic: "payments" (3 partitions)

┌─────────────────────────────────────────────────┐
│  Partition 0                                    │
│  ├─ Offset 0: {payment1}                       │
│  ├─ Offset 1: {payment2}                       │
│  ├─ Offset 2: {payment3}  ← Current Offset     │
│  └─ Offset 3: {payment4}  ← Committed Offset   │
└─────────────────────────────────────────────────┘

Committed Offset: Last successfully processed message
Current Offset: Next message to read
Lag: Current Offset - Committed Offset
```

#### Offset Storage

```
Kafka stores offsets in internal topic: __consumer_offsets

Key: [group.id, topic, partition]
Value: [offset, metadata, timestamp]

Example:
{
  "group": "payment-processors",
  "topic": "payments",
  "partition": 0,
  "offset": 1234,
  "metadata": "processed-successfully",
  "timestamp": 1234567890
}
```

#### Manual Offset Management Implementation

```java
/**
 * Manual Offset Management Configuration
 */
@Configuration
public class ManualOffsetConfiguration {
    
    @Bean
    public ConsumerFactory<String, Payment> consumerFactory() {
        Map<String, Object> config = new HashMap<>();
        config.put(ConsumerConfig.BOOTSTRAP_SERVERS_CONFIG, bootstrapServers);
        config.put(ConsumerConfig.GROUP_ID_CONFIG, "payment-processors");
        
        // Disable auto-commit
        config.put(ConsumerConfig.ENABLE_AUTO_COMMIT_CONFIG, false);
        
        // Start from earliest if no offset exists
        config.put(ConsumerConfig.AUTO_OFFSET_RESET_CONFIG, "earliest");
        
        return new DefaultKafkaConsumerFactory<>(config);
    }
    
    @Bean
    public ConcurrentKafkaListenerContainerFactory<String, Payment> 
            kafkaListenerContainerFactory() {
        ConcurrentKafkaListenerContainerFactory<String, Payment> factory = 
            new ConcurrentKafkaListenerContainerFactory<>();
        factory.setConsumerFactory(consumerFactory());
        
        // Manual acknowledgment mode
        factory.getContainerProperties()
            .setAckMode(ContainerProperties.AckMode.MANUAL_IMMEDIATE);
        
        return factory;
    }
}

/**
 * Consumer with Manual Offset Management
 */
@Service
@Slf4j
public class PaymentConsumerService {
    
    @Autowired
    private PaymentRepository paymentRepository;
    
    @Autowired
    private KafkaTemplate<String, Payment> kafkaTemplate;
    
    /**
     * Manual Acknowledgment - Commit after successful processing
     */
    @KafkaListener(topics = "payments", groupId = "payment-processors")
    public void consumePayment(
            ConsumerRecord<String, Payment> record,
            Acknowledgment acknowledgment) {
        
        try {
            Payment payment = record.value();
            
            log.info("Processing payment: id={}, partition={}, offset={}", 
                payment.getId(), record.partition(), record.offset());
            
            // Process payment
            processPayment(payment);
            
            // Save to database
            paymentRepository.save(payment);
            
            // Commit offset only after successful processing
            acknowledgment.acknowledge();
            
            log.info("Payment processed successfully: id={}", payment.getId());
            
        } catch (Exception e) {
            log.error("Error processing payment at offset {}", record.offset(), e);
            // Don't acknowledge - message will be reprocessed
            throw e;
        }
    }
    
    /**
     * Batch Processing with Manual Offset Management
     */
    @KafkaListener(
        topics = "payments-batch",
        groupId = "payment-batch-processors",
        containerFactory = "batchKafkaListenerContainerFactory"
    )
    public void consumePaymentBatch(
            List<ConsumerRecord<String, Payment>> records,
            Acknowledgment acknowledgment) {
        
        try {
            log.info("Processing batch of {} payments", records.size());
            
            List<Payment> payments = records.stream()
                .map(ConsumerRecord::value)
                .collect(Collectors.toList());
            
            // Batch processing
            paymentRepository.saveAll(payments);
            
            // Commit all offsets in batch
            acknowledgment.acknowledge();
            
            log.info("Batch processed successfully");
            
        } catch (Exception e) {
            log.error("Error processing payment batch", e);
            throw e;
        }
    }
    
    /**
     * Exactly-Once Processing with Database Transaction
     */
    @Transactional
    @KafkaListener(topics = "payments-transactional", groupId = "payment-tx-processors")
    public void consumePaymentTransactional(
            ConsumerRecord<String, Payment> record,
            Acknowledgment acknowledgment) {
        
        Payment payment = record.value();
        
        // Check if already processed (idempotency)
        if (paymentRepository.existsById(payment.getId())) {
            log.warn("Payment already processed: id={}", payment.getId());
            acknowledgment.acknowledge();
            return;
        }
        
        // Process and save in same transaction
        processPayment(payment);
        paymentRepository.save(payment);
        
        // Commit offset
        acknowledgment.acknowledge();
    }
}
```

#### Seeking to Specific Offset

```java
/**
 * Offset Seeking Operations
 */
@Service
public class OffsetManagementService {
    
    @Autowired
    private KafkaListenerEndpointRegistry registry;
    
    /**
     * Seek to beginning of partition
     */
    public void seekToBeginning(String listenerId, int partition) {
        MessageListenerContainer container = 
            registry.getListenerContainer(listenerId);
        
        container.pausePartition(new TopicPartition("payments", partition));
        
        Consumer<?, ?> consumer = getConsumer(container);
        consumer.seekToBeginning(
            Collections.singletonList(new TopicPartition("payments", partition))
        );
        
        container.resumePartition(new TopicPartition("payments", partition));
    }
    
    /**
     * Seek to specific offset
     */
    public void seekToOffset(String listenerId, int partition, long offset) {
        MessageListenerContainer container = 
            registry.getListenerContainer(listenerId);
        
        container.pausePartition(new TopicPartition("payments", partition));
        
        Consumer<?, ?> consumer = getConsumer(container);
        consumer.seek(new TopicPartition("payments", partition), offset);
        
        container.resumePartition(new TopicPartition("payments", partition));
    }
    
    /**
     * Seek to timestamp
     */
    public void seekToTimestamp(String listenerId, int partition, long timestamp) {
        MessageListenerContainer container = 
            registry.getListenerContainer(listenerId);
        
        Consumer<?, ?> consumer = getConsumer(container);
        
        Map<TopicPartition, Long> timestampsToSearch = new HashMap<>();
        timestampsToSearch.put(new TopicPartition("payments", partition), timestamp);
        
        Map<TopicPartition, OffsetAndTimestamp> offsets = 
            consumer.offsetsForTimes(timestampsToSearch);
        
        offsets.forEach((tp, offsetAndTimestamp) -> {
            if (offsetAndTimestamp != null) {
                consumer.seek(tp, offsetAndTimestamp.offset());
            }
        });
    }
    
    /**
     * Get current offset position
     */
    public Map<TopicPartition, Long> getCurrentOffsets(String groupId, String topic) {
        try (AdminClient adminClient = AdminClient.create(adminConfig)) {
            ListConsumerGroupOffsetsResult result = 
                adminClient.listConsumerGroupOffsets(groupId);
            
            Map<TopicPartition, OffsetAndMetadata> offsets = 
                result.partitionsToOffsetAndMetadata().get();
            
            return offsets.entrySet().stream()
                .filter(entry -> entry.getKey().topic().equals(topic))
                .collect(Collectors.toMap(
                    Map.Entry::getKey,
                    entry -> entry.getValue().offset()
                ));
        } catch (Exception e) {
            throw new RuntimeException("Failed to get offsets", e);
        }
    }
    
    /**
     * Get consumer lag
     */
    public Map<TopicPartition, Long> getConsumerLag(String groupId, String topic) {
        try (AdminClient adminClient = AdminClient.create(adminConfig);
             Consumer<String, String> consumer = new KafkaConsumer<>(consumerConfig)) {
            
            // Get committed offsets
            Map<TopicPartition, OffsetAndMetadata> committedOffsets = 
                adminClient.listConsumerGroupOffsets(groupId)
                    .partitionsToOffsetAndMetadata().get();
            
            // Get end offsets
            List<TopicPartition> partitions = committedOffsets.keySet().stream()
                .filter(tp -> tp.topic().equals(topic))
                .collect(Collectors.toList());
            
            Map<TopicPartition, Long> endOffsets = consumer.endOffsets(partitions);
            
            // Calculate lag
            Map<TopicPartition, Long> lag = new HashMap<>();
            partitions.forEach(tp -> {
                long committed = committedOffsets.get(tp).offset();
                long end = endOffsets.get(tp);
                lag.put(tp, end - committed);
            });
            
            return lag;
        } catch (Exception e) {
            throw new RuntimeException("Failed to calculate lag", e);
        }
    }
}
```

#### Offset Reset Strategies

```java
/**
 * Offset Reset Configuration
 */
@Configuration
public class OffsetResetConfiguration {
    
    /**
     * Reset to earliest
     */
    @Bean("earliestConsumerFactory")
    public ConsumerFactory<String, Object> earliestConsumerFactory() {
        Map<String, Object> config = new HashMap<>();
        config.put(ConsumerConfig.BOOTSTRAP_SERVERS_CONFIG, bootstrapServers);
        config.put(ConsumerConfig.AUTO_OFFSET_RESET_CONFIG, "earliest");
        return new DefaultKafkaConsumerFactory<>(config);
    }
    
    /**
     * Reset to latest
     */
    @Bean("latestConsumerFactory")
    public ConsumerFactory<String, Object> latestConsumerFactory() {
        Map<String, Object> config = new HashMap<>();
        config.put(ConsumerConfig.BOOTSTRAP_SERVERS_CONFIG, bootstrapServers);
        config.put(ConsumerConfig.AUTO_OFFSET_RESET_CONFIG, "latest");
        return new DefaultKafkaConsumerFactory<>(config);
    }
    
    /**
     * Custom offset reset
     */
    @Bean
    public ConsumerAwareRebalanceListener rebalanceListener() {
        return new ConsumerAwareRebalanceListener() {
            @Override
            public void onPartitionsAssigned(Consumer<?, ?> consumer, 
                                           Collection<TopicPartition> partitions) {
                // Custom logic on partition assignment
                partitions.forEach(partition -> {
                    // Seek to specific offset or timestamp
                    consumer.seek(partition, getCustomOffset(partition));
                });
            }
            
            @Override
            public void onPartitionsRevoked(Consumer<?, ?> consumer, 
                                          Collection<TopicPartition> partitions) {
                // Cleanup before rebalance
            }
        };
    }
}
```

**Offset Management Best Practices:**

1. **Manual Acknowledgment**: Use for critical data processing
2. **Idempotency**: Always check if message already processed
3. **Transaction Coordination**: Coordinate offset commits with database transactions
4. **Monitoring**: Track consumer lag continuously
5. **Error Handling**: Don't commit offsets for failed messages

---

### 41. Exactly-Once Semantics

**Question:** How do you implement exactly-once semantics in Kafka? Explain idempotent producers and transactional consumers.

**Answer:**

#### Exactly-Once Delivery Guarantees

```
┌──────────────────────────────────────────────────────┐
│         Kafka Delivery Semantics                     │
├──────────────────────────────────────────────────────┤
│                                                      │
│  At-Most-Once:                                       │
│  ├─ Message may be lost                             │
│  └─ Never delivered twice                           │
│                                                      │
│  At-Least-Once:                                      │
│  ├─ Message never lost                              │
│  └─ May be delivered multiple times                 │
│                                                      │
│  Exactly-Once:                                       │
│  ├─ Message never lost                              │
│  ├─ Never delivered twice                           │
│  └─ Delivered exactly once                          │
│                                                      │
└──────────────────────────────────────────────────────┘
```

#### Idempotent Producer Configuration

```java
/**
 * Idempotent Producer - Prevents duplicate messages
 */
@Configuration
public class IdempotentProducerConfiguration {
    
    @Bean
    public ProducerFactory<String, Object> producerFactory() {
        Map<String, Object> config = new HashMap<>();
        config.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, bootstrapServers);
        
        // Enable idempotence
        config.put(ProducerConfig.ENABLE_IDEMPOTENCE_CONFIG, true);
        
        // Required for idempotence
        config.put(ProducerConfig.ACKS_CONFIG, "all");
        config.put(ProducerConfig.RETRIES_CONFIG, Integer.MAX_VALUE);
        config.put(ProducerConfig.MAX_IN_FLIGHT_REQUESTS_PER_CONNECTION, 5);
        
        // Transactional ID for exactly-once
        config.put(ProducerConfig.TRANSACTIONAL_ID_CONFIG, "payment-producer-1");
        
        return new DefaultKafkaProducerFactory<>(config);
    }
}
```

#### Transactional Producer

```java
/**
 * Transactional Message Production
 */
@Service
@Slf4j
public class TransactionalProducerService {
    
    @Autowired
    private KafkaTemplate<String, Object> kafkaTemplate;
    
    /**
     * Send messages in transaction
     */
    public void sendTransactional(List<Payment> payments) {
        kafkaTemplate.executeInTransaction(operations -> {
            payments.forEach(payment -> {
                operations.send("payments", payment.getId(), payment);
                log.info("Sent payment in transaction: id={}", payment.getId());
            });
            return true;
        });
    }
    
    /**
     * Transactional send with error handling
     */
    public void sendWithTransaction(Payment payment) {
        try {
            kafkaTemplate.executeInTransaction(operations -> {
                // Send to multiple topics atomically
                operations.send("payments", payment.getId(), payment);
                operations.send("payment-audit", payment.getId(), 
                    createAuditRecord(payment));
                
                // All or nothing - both messages sent or none
                return true;
            });
        } catch (Exception e) {
            log.error("Transaction failed, messages rolled back", e);
            throw e;
        }
    }
}
```

#### Transactional Consumer

```java
/**
 * Exactly-Once Consumer with Transactions
 */
@Service
@Slf4j
public class ExactlyOnceConsumerService {
    
    @Autowired
    private PaymentRepository paymentRepository;
    
    @Autowired
    private KafkaTemplate<String, Object> kafkaTemplate;
    
    /**
     * Consume-Transform-Produce Pattern (Exactly-Once)
     */
    @Transactional
    @KafkaListener(topics = "raw-payments", groupId = "payment-transformer")
    public void consumeTransformProduce(
            ConsumerRecord<String, RawPayment> record,
            Acknowledgment acknowledgment) {
        
        RawPayment rawPayment = record.value();
        
        // Transform
        Payment payment = transformPayment(rawPayment);
        
        // Produce to output topic (within transaction)
        kafkaTemplate.executeInTransaction(operations -> {
            operations.send("processed-payments", payment.getId(), payment);
            
            // Commit offset within same transaction
            acknowledgment.acknowledge();
            
            return true;
        });
    }
    
    /**
     * Database + Kafka Transaction Coordination
     */
    @Transactional
    @KafkaListener(topics = "payments", groupId = "payment-processors")
    public void processWithDatabaseTransaction(
            ConsumerRecord<String, Payment> record,
            Acknowledgment acknowledgment) {
        
        Payment payment = record.value();
        
        // Check idempotency
        if (paymentRepository.existsByIdempotencyKey(payment.getIdempotencyKey())) {
            log.warn("Payment already processed: key={}", payment.getIdempotencyKey());
            acknowledgment.acknowledge();
            return;
        }
        
        // Process payment
        payment.setStatus("PROCESSED");
        payment.setProcessedAt(LocalDateTime.now());
        
        // Save to database
        paymentRepository.save(payment);
        
        // Send notification
        kafkaTemplate.send("payment-notifications", payment.getId(), 
            createNotification(payment));
        
        // Commit offset
        acknowledgment.acknowledge();
        
        // All operations in single transaction - exactly-once guarantee
    }
}
```

#### Idempotency Implementation

```java
/**
 * Idempotency Key Management
 */
@Entity
@Table(name = "processed_messages")
public class ProcessedMessage {
    @Id
    private String idempotencyKey;
    
    private String topic;
    private Integer partition;
    private Long offset;
    private LocalDateTime processedAt;
    
    @Column(columnDefinition = "TEXT")
    private String messagePayload;
}

@Service
public class IdempotencyService {
    
    @Autowired
    private ProcessedMessageRepository repository;
    
    /**
     * Check if message already processed
     */
    public boolean isProcessed(String idempotencyKey) {
        return repository.existsById(idempotencyKey);
    }
    
    /**
     * Mark message as processed
     */
    @Transactional
    public void markAsProcessed(ConsumerRecord<String, ?> record, 
                               String idempotencyKey) {
        ProcessedMessage processed = new ProcessedMessage();
        processed.setIdempotencyKey(idempotencyKey);
        processed.setTopic(record.topic());
        processed.setPartition(record.partition());
        processed.setOffset(record.offset());
        processed.setProcessedAt(LocalDateTime.now());
        processed.setMessagePayload(record.value().toString());
        
        repository.save(processed);
    }
    
    /**
     * Cleanup old processed messages
     */
    @Scheduled(cron = "0 0 2 * * *")  // Daily at 2 AM
    public void cleanupOldRecords() {
        LocalDateTime cutoff = LocalDateTime.now().minusDays(7);
        repository.deleteByProcessedAtBefore(cutoff);
    }
}

/**
 * Consumer with Idempotency Check
 */
@Service
public class IdempotentConsumerService {
    
    @Autowired
    private IdempotencyService idempotencyService;
    
    @Autowired
    private PaymentService paymentService;
    
    @Transactional
    @KafkaListener(topics = "payments", groupId = "payment-processors")
    public void consumeIdempotent(
            ConsumerRecord<String, Payment> record,
            Acknowledgment acknowledgment) {
        
        Payment payment = record.value();
        String idempotencyKey = payment.getIdempotencyKey();
        
        // Check if already processed
        if (idempotencyService.isProcessed(idempotencyKey)) {
            log.info("Message already processed: key={}", idempotencyKey);
            acknowledgment.acknowledge();
            return;
        }
        
        // Process payment
        paymentService.process(payment);
        
        // Mark as processed
        idempotencyService.markAsProcessed(record, idempotencyKey);
        
        // Commit offset
        acknowledgment.acknowledge();
    }
}
```

**Exactly-Once Implementation Strategies:**

1. **Idempotent Producer**: Prevents duplicate sends
2. **Transactional Producer**: Atomic multi-topic writes
3. **Transactional Consumer**: Coordinate offset commits with processing
4. **Idempotency Keys**: Application-level deduplication
5. **Database Transactions**: Coordinate Kafka and database operations

---

This comprehensive guide covers Spring Kafka from fundamentals to advanced enterprise patterns. Would you like me to now update the main README.md with links to both new guides?

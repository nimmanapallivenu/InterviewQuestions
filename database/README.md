# Database Interview Questions - Top 100

## Topics
1. SQL Fundamentals (Q1-Q30)
2. NoSQL (Q31-Q50)
3. Performance & Optimization (Q51-Q75)
4. Transactions & ACID (Q76-Q100)

## Key Concepts

### Q1-Q10: SQL Basics
```sql
-- SELECT
SELECT * FROM users WHERE age > 25;

-- JOIN
SELECT u.name, o.total
FROM users u
INNER JOIN orders o ON u.id = o.user_id;

-- GROUP BY
SELECT country, COUNT(*) as count
FROM users
GROUP BY country
HAVING count > 100;

-- SUBQUERY
SELECT name FROM users
WHERE id IN (SELECT user_id FROM orders WHERE total > 1000);
```

### Q11-Q20: Indexes
```sql
-- Create index
CREATE INDEX idx_email ON users(email);

-- Composite index
CREATE INDEX idx_name_age ON users(name, age);

-- Unique index
CREATE UNIQUE INDEX idx_username ON users(username);
```

### Q21-Q30: Normalization
- **1NF**: Atomic values
- **2NF**: No partial dependencies
- **3NF**: No transitive dependencies
- **BCNF**: Boyce-Codd Normal Form

### Q31-Q50: NoSQL Types
- **Document**: MongoDB, Couchbase
- **Key-Value**: Redis, DynamoDB
- **Column-Family**: Cassandra, HBase
- **Graph**: Neo4j, Amazon Neptune

### Q51-Q75: Performance
- Indexing strategies
- Query optimization
- Connection pooling
- Caching
- Partitioning
- Replication

### Q76-Q100: ACID Properties
- **Atomicity**: All or nothing
- **Consistency**: Valid state
- **Isolation**: Concurrent transactions
- **Durability**: Permanent changes

---

**Note**: Database fundamentals for data management.

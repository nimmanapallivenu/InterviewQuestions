# Comprehensive Java & Spring Boot Interview Guide
## Enhanced Edition with Detailed Explanations, Diagrams & Flowcharts

---

## 📚 Table of Contents

### Part 1: Core Java Mastery
1. [Java Fundamentals & OOP](#java-fundamentals--oop)
2. [Collections Framework Deep Dive](#collections-framework-deep-dive)
3. [Concurrency & Multithreading](#concurrency--multithreading)
4. [Memory Management & JVM](#memory-management--jvm)
5. [Exception Handling](#exception-handling)

### Part 2: Modern Java Features
6. [Java 8 Features](#java-8-features)
7. [Java 9-17 Features](#java-9-17-features)
8. [Functional Programming](#functional-programming)

### Part 3: Spring Framework
9. [Spring Core Concepts](#spring-core-concepts)
10. [Spring Boot Essentials](#spring-boot-essentials)
11. [Spring Data & Persistence](#spring-data--persistence)
12. [Spring Security](#spring-security)
13. [Spring Cloud & Microservices](#spring-cloud--microservices)

### Part 4: Advanced Topics
14. [Design Patterns](#design-patterns)
15. [Performance Optimization](#performance-optimization)
16. [Testing Strategies](#testing-strategies)
17. [Best Practices](#best-practices)

---

## Java Fundamentals & OOP

### 1. Object-Oriented Programming Principles

#### Detailed Explanation

**The Four Pillars of OOP:**

```
┌─────────────────────────────────────────────────────────┐
│                    OOP PRINCIPLES                       │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  ┌──────────────┐  ┌──────────────┐                   │
│  │Encapsulation │  │ Inheritance  │                   │
│  │              │  │              │                   │
│  │ Hide data    │  │ Code reuse   │                   │
│  │ Expose API   │  │ IS-A relation│                   │
│  └──────────────┘  └──────────────┘                   │
│                                                         │
│  ┌──────────────┐  ┌──────────────┐                   │
│  │Polymorphism  │  │ Abstraction  │                   │
│  │              │  │              │                   │
│  │ Many forms   │  │ Hide complex │                   │
│  │ Override     │  │ Show simple  │                   │
│  └──────────────┘  └──────────────┘                   │
└─────────────────────────────────────────────────────────┘
```

#### 1.1 Encapsulation - Data Hiding

**Concept:** Bundle data and methods together, control access through modifiers.

```java
/**
 * Encapsulation Example: BankAccount
 * 
 * Key Points:
 * - Private fields prevent direct access
 * - Public methods provide controlled access
 * - Validation logic protects data integrity
 */
public class BankAccount {
    // Private fields - encapsulated data
    private String accountNumber;
    private double balance;
    private String accountHolder;
    
    // Constructor with validation
    public BankAccount(String accountNumber, String accountHolder, double initialBalance) {
        if (initialBalance < 0) {
            throw new IllegalArgumentException("Initial balance cannot be negative");
        }
        this.accountNumber = accountNumber;
        this.accountHolder = accountHolder;
        this.balance = initialBalance;
    }
    
    // Controlled access through public methods
    public void deposit(double amount) {
        if (amount <= 0) {
            throw new IllegalArgumentException("Deposit amount must be positive");
        }
        this.balance += amount;
        logTransaction("DEPOSIT", amount);
    }
    
    public boolean withdraw(double amount) {
        if (amount <= 0) {
            throw new IllegalArgumentException("Withdrawal amount must be positive");
        }
        if (amount > balance) {
            return false; // Insufficient funds
        }
        this.balance -= amount;
        logTransaction("WITHDRAWAL", amount);
        return true;
    }
    
    // Read-only access to balance
    public double getBalance() {
        return balance;
    }
    
    // Private helper method
    private void logTransaction(String type, double amount) {
        System.out.printf("%s: %.2f - New Balance: %.2f%n", type, amount, balance);
    }
}
```

**Benefits:**
- Data integrity through validation
- Flexibility to change implementation
- Easier maintenance and debugging
- Security through access control

#### 1.2 Inheritance - Code Reuse

**Concept:** Create new classes based on existing classes.

```java
/**
 * Inheritance Hierarchy
 * 
 * Flow:
 * Animal (Base) → Dog (Derived) → GermanShepherd (Further Derived)
 */

// Base class
public abstract class Animal {
    protected String name;
    protected int age;
    
    public Animal(String name, int age) {
        this.name = name;
        this.age = age;
    }
    
    // Abstract method - must be implemented by subclasses
    public abstract void makeSound();
    
    // Concrete method - inherited by all subclasses
    public void sleep() {
        System.out.println(name + " is sleeping");
    }
    
    // Template method pattern
    public final void dailyRoutine() {
        wakeUp();
        makeSound();
        eat();
        sleep();
    }
    
    protected void wakeUp() {
        System.out.println(name + " wakes up");
    }
    
    protected void eat() {
        System.out.println(name + " is eating");
    }
}

// Derived class
public class Dog extends Animal {
    private String breed;
    
    public Dog(String name, int age, String breed) {
        super(name, age); // Call parent constructor
        this.breed = breed;
    }
    
    @Override
    public void makeSound() {
        System.out.println(name + " barks: Woof! Woof!");
    }
    
    // Additional method specific to Dog
    public void fetch() {
        System.out.println(name + " is fetching the ball");
    }
}

// Further derived class
public class GermanShepherd extends Dog {
    private boolean isTrained;
    
    public GermanShepherd(String name, int age, boolean isTrained) {
        super(name, age, "German Shepherd");
        this.isTrained = isTrained;
    }
    
    @Override
    public void makeSound() {
        System.out.println(name + " barks loudly: WOOF! WOOF!");
    }
    
    public void guard() {
        if (isTrained) {
            System.out.println(name + " is guarding the house");
        }
    }
}
```

**Inheritance Flow Diagram:**
```
        ┌──────────┐
        │  Animal  │ (Abstract)
        │          │
        │ +name    │
        │ +age     │
        │ +sleep() │
        └────┬─────┘
             │ extends
        ┌────▼─────┐
        │   Dog    │
        │          │
        │ +breed   │
        │ +fetch() │
        └────┬─────┘
             │ extends
        ┌────▼──────────┐
        │GermanShepherd │
        │               │
        │ +isTrained    │
        │ +guard()      │
        └───────────────┘
```

#### 1.3 Polymorphism - Many Forms

**Types of Polymorphism:**

```
Polymorphism
    │
    ├── Compile-time (Static)
    │   ├── Method Overloading
    │   └── Operator Overloading (not in Java)
    │
    └── Runtime (Dynamic)
        ├── Method Overriding
        └── Interface Implementation
```

**Method Overloading Example:**
```java
public class Calculator {
    // Same method name, different parameters
    
    public int add(int a, int b) {
        return a + b;
    }
    
    public double add(double a, double b) {
        return a + b;
    }
    
    public int add(int a, int b, int c) {
        return a + b + c;
    }
    
    public String add(String a, String b) {
        return a + b;
    }
}
```

**Method Overriding Example:**
```java
/**
 * Runtime Polymorphism through Method Overriding
 */
public interface PaymentProcessor {
    boolean processPayment(double amount);
    String getPaymentMethod();
}

public class CreditCardProcessor implements PaymentProcessor {
    @Override
    public boolean processPayment(double amount) {
        System.out.println("Processing credit card payment: $" + amount);
        // Credit card specific logic
        return validateCard() && chargeCard(amount);
    }
    
    @Override
    public String getPaymentMethod() {
        return "Credit Card";
    }
    
    private boolean validateCard() { return true; }
    private boolean chargeCard(double amount) { return true; }
}

public class PayPalProcessor implements PaymentProcessor {
    @Override
    public boolean processPayment(double amount) {
        System.out.println("Processing PayPal payment: $" + amount);
        // PayPal specific logic
        return authenticateUser() && transferFunds(amount);
    }
    
    @Override
    public String getPaymentMethod() {
        return "PayPal";
    }
    
    private boolean authenticateUser() { return true; }
    private boolean transferFunds(double amount) { return true; }
}

// Usage - Polymorphic behavior
public class PaymentService {
    public void processOrder(PaymentProcessor processor, double amount) {
        System.out.println("Using: " + processor.getPaymentMethod());
        boolean success = processor.processPayment(amount);
        System.out.println("Payment " + (success ? "successful" : "failed"));
    }
    
    public static void main(String[] args) {
        PaymentService service = new PaymentService();
        
        // Same method call, different behavior
        service.processOrder(new CreditCardProcessor(), 100.00);
        service.processOrder(new PayPalProcessor(), 150.00);
    }
}
```

#### 1.4 Abstraction - Hiding Complexity

**Concept:** Show only essential features, hide implementation details.

```java
/**
 * Abstraction through Abstract Classes and Interfaces
 */

// Abstract class - partial abstraction
public abstract class Vehicle {
    protected String brand;
    protected String model;
    
    public Vehicle(String brand, String model) {
        this.brand = brand;
        this.model = model;
    }
    
    // Abstract methods - must be implemented
    public abstract void start();
    public abstract void stop();
    public abstract double calculateFuelEfficiency();
    
    // Concrete method - common implementation
    public void displayInfo() {
        System.out.println(brand + " " + model);
    }
}

// Interface - complete abstraction
public interface Maintainable {
    void performMaintenance();
    boolean needsMaintenance();
    LocalDate getLastMaintenanceDate();
}

// Concrete implementation
public class Car extends Vehicle implements Maintainable {
    private double fuelCapacity;
    private double mileage;
    private LocalDate lastMaintenance;
    
    public Car(String brand, String model, double fuelCapacity) {
        super(brand, model);
        this.fuelCapacity = fuelCapacity;
        this.lastMaintenance = LocalDate.now();
    }
    
    @Override
    public void start() {
        System.out.println("Car engine starting...");
        checkOilLevel();
        igniteEngine();
    }
    
    @Override
    public void stop() {
        System.out.println("Car engine stopping...");
        turnOffEngine();
    }
    
    @Override
    public double calculateFuelEfficiency() {
        return mileage / fuelCapacity;
    }
    
    @Override
    public void performMaintenance() {
        System.out.println("Performing car maintenance");
        changeOil();
        checkTires();
        this.lastMaintenance = LocalDate.now();
    }
    
    @Override
    public boolean needsMaintenance() {
        return ChronoUnit.MONTHS.between(lastMaintenance, LocalDate.now()) >= 6;
    }
    
    @Override
    public LocalDate getLastMaintenanceDate() {
        return lastMaintenance;
    }
    
    // Private implementation details - hidden from users
    private void checkOilLevel() { /* implementation */ }
    private void igniteEngine() { /* implementation */ }
    private void turnOffEngine() { /* implementation */ }
    private void changeOil() { /* implementation */ }
    private void checkTires() { /* implementation */ }
}
```

**Abstraction Levels:**
```
High Level (User View)
    │
    ├── Vehicle.start()
    │   └── Simple interface
    │
Mid Level (Abstract Class)
    │
    ├── Template methods
    │   └── Common behavior
    │
Low Level (Implementation)
    │
    └── checkOilLevel()
        igniteEngine()
        └── Complex details hidden
```

---

## Collections Framework Deep Dive

### 2. Collections Hierarchy & Internal Working

#### Complete Collections Framework

```
                    Iterable<E>
                        │
                   Collection<E>
                        │
        ┌───────────────┼───────────────┐
        │               │               │
      List<E>         Set<E>         Queue<E>
        │               │               │
    ┌───┴───┐       ┌───┴───┐       ┌───┴───┐
ArrayList Vector  HashSet TreeSet Priority Deque
LinkedList Stack  LinkedHashSet   Queue  ArrayDeque
                  SortedSet
                  
                    Map<K,V> (separate)
                        │
        ┌───────────────┼───────────────┐
    HashMap         TreeMap      LinkedHashMap
    Hashtable       SortedMap    ConcurrentHashMap
    WeakHashMap
```

#### 2.1 ArrayList Internal Implementation

**How ArrayList Works:**

```java
/**
 * Simplified ArrayList Implementation
 * Understanding internal mechanics
 */
public class MyArrayList<E> {
    private static final int DEFAULT_CAPACITY = 10;
    private Object[] elementData;
    private int size;
    
    public MyArrayList() {
        this.elementData = new Object[DEFAULT_CAPACITY];
        this.size = 0;
    }
    
    /**
     * Add operation - O(1) amortized
     * 
     * Flow:
     * 1. Check if array is full
     * 2. If full, grow array (copy to larger array)
     * 3. Add element at end
     * 4. Increment size
     */
    public boolean add(E element) {
        ensureCapacity();
        elementData[size++] = element;
        return true;
    }
    
    /**
     * Growth Strategy
     * New capacity = Old capacity * 1.5
     */
    private void ensureCapacity() {
        if (size == elementData.length) {
            int newCapacity = elementData.length + (elementData.length >> 1); // 1.5x
            elementData = Arrays.copyOf(elementData, newCapacity);
        }
    }
    
    /**
     * Get operation - O(1)
     * Direct array access
     */
    @SuppressWarnings("unchecked")
    public E get(int index) {
        if (index >= size || index < 0) {
            throw new IndexOutOfBoundsException("Index: " + index + ", Size: " + size);
        }
        return (E) elementData[index];
    }
    
    /**
     * Remove operation - O(n)
     * Requires shifting elements
     */
    public E remove(int index) {
        if (index >= size || index < 0) {
            throw new IndexOutOfBoundsException();
        }
        
        @SuppressWarnings("unchecked")
        E oldValue = (E) elementData[index];
        
        int numMoved = size - index - 1;
        if (numMoved > 0) {
            System.arraycopy(elementData, index + 1, elementData, index, numMoved);
        }
        elementData[--size] = null; // Clear reference
        
        return oldValue;
    }
}
```

**ArrayList Growth Visualization:**
```
Initial: [10 slots]
[_, _, _, _, _, _, _, _, _, _]

After 10 adds: [Full]
[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

11th add triggers growth:
New capacity = 10 + (10 >> 1) = 15

[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, _, _, _, _]
```

#### 2.2 HashMap Internal Implementation

**HashMap Structure:**

```
HashMap<K,V>
    │
    ├── Node<K,V>[] table (array of buckets)
    │   │
    │   ├── Bucket 0: Node → Node → Node (linked list)
    │   ├── Bucket 1: Node
    │   ├── Bucket 2: TreeNode (red-black tree if > 8 nodes)
    │   └── ...
    │
    ├── size (number of entries)
    ├── threshold (capacity * loadFactor)
    └── loadFactor (default 0.75)
```

**Detailed HashMap Implementation:**

```java
/**
 * Understanding HashMap Internals
 */
public class HashMapExplained<K, V> {
    
    /**
     * Node structure - building block of HashMap
     */
    static class Node<K, V> {
        final int hash;
        final K key;
        V value;
        Node<K, V> next; // For handling collisions
        
        Node(int hash, K key, V value, Node<K, V> next) {
            this.hash = hash;
            this.key = key;
            this.value = value;
            this.next = next;
        }
    }
    
    private Node<K, V>[] table;
    private int size;
    private static final int DEFAULT_CAPACITY = 16;
    private static final float LOAD_FACTOR = 0.75f;
    
    @SuppressWarnings("unchecked")
    public HashMapExplained() {
        table = (Node<K, V>[]) new Node[DEFAULT_CAPACITY];
    }
    
    /**
     * PUT Operation Flow:
     * 
     * 1. Calculate hash of key
     * 2. Find bucket index: hash & (table.length - 1)
     * 3. Check if bucket is empty
     *    - If empty: create new node
     *    - If not empty: handle collision
     * 4. If key exists: update value
     * 5. If key doesn't exist: add to chain
     * 6. Check if resize needed
     */
    public V put(K key, V value) {
        if (key == null) {
            return putForNullKey(value);
        }
        
        // Step 1: Calculate hash
        int hash = hash(key);
        
        // Step 2: Find bucket index
        int index = indexFor(hash, table.length);
        
        // Step 3-5: Handle collision and insertion
        for (Node<K, V> e = table[index]; e != null; e = e.next) {
            if (e.hash == hash && (e.key == key || key.equals(e.key))) {
                V oldValue = e.value;
                e.value = value;
                return oldValue; // Key exists, update value
            }
        }
        
        // Key doesn't exist, add new node
        addEntry(hash, key, value, index);
        return null;
    }
    
    /**
     * Hash function - crucial for distribution
     */
    private int hash(K key) {
        int h = key.hashCode();
        // Additional hashing to reduce collisions
        h ^= (h >>> 20) ^ (h >>> 12);
        return h ^ (h >>> 7) ^ (h >>> 4);
    }
    
    /**
     * Index calculation
     * Uses bitwise AND for efficiency (equivalent to modulo)
     */
    private int indexFor(int hash, int length) {
        return hash & (length - 1);
    }
    
    /**
     * Add new entry to bucket
     */
    private void addEntry(int hash, K key, V value, int bucketIndex) {
        Node<K, V> e = table[bucketIndex];
        table[bucketIndex] = new Node<>(hash, key, value, e);
        size++;
        
        // Check if resize needed
        if (size >= table.length * LOAD_FACTOR) {
            resize();
        }
    }
    
    /**
     * GET Operation Flow:
     * 
     * 1. Calculate hash
     * 2. Find bucket
     * 3. Search through chain
     * 4. Return value if found
     */
    public V get(K key) {
        if (key == null) {
            return getForNullKey();
        }
        
        int hash = hash(key);
        int index = indexFor(hash, table.length);
        
        for (Node<K, V> e = table[index]; e != null; e = e.next) {
            if (e.hash == hash && (e.key == key || key.equals(e.key))) {
                return e.value;
            }
        }
        return null;
    }
    
    /**
     * Resize operation - doubles capacity
     * Rehashes all entries
     */
    @SuppressWarnings("unchecked")
    private void resize() {
        Node<K, V>[] oldTable = table;
        int newCapacity = oldTable.length * 2;
        table = (Node<K, V>[]) new Node[newCapacity];
        
        // Rehash all entries
        for (Node<K, V> e : oldTable) {
            while (e != null) {
                Node<K, V> next = e.next;
                int index = indexFor(e.hash, newCapacity);
                e.next = table[index];
                table[index] = e;
                e = next;
            }
        }
    }
    
    private V putForNullKey(V value) { /* implementation */ return null; }
    private V getForNullKey() { /* implementation */ return null; }
}
```

**HashMap Put Operation Visualization:**

```
put("John", 25)
    │
    ├─> hash("John") = 2147483647
    │
    ├─> index = 2147483647 & 15 = 15
    │
    └─> table[15]
            │
            ├─> Empty? Create new Node
            │
            └─> Not empty? Check chain
                    │
                    ├─> Key exists? Update value
                    │
                    └─> Key doesn't exist? Add to chain
```

**Collision Handling:**

```
Bucket 5:
┌─────────────┐
│ hash: 101   │
│ key: "A"    │
│ value: 1    │
│ next: ─────┼──> ┌─────────────┐
└─────────────┘    │ hash: 229   │
                   │ key: "B"    │
                   │ value: 2    │
                   │ next: ─────┼──> ┌─────────────┐
                   └─────────────┘    │ hash: 357   │
                                      │ key: "C"    │
                                      │ value: 3    │
                                      │ next: null  │
                                      └─────────────┘
```

**When chain length > 8, converts to Red-Black Tree:**

```
Bucket with Tree:
        ┌─────┐
        │  D  │ (root)
        └──┬──┘
     ┌─────┴─────┐
  ┌──▼──┐     ┌──▼──┐
  │  B  │     │  F  │
  └──┬──┘     └──┬──┘
  ┌──▼──┐     ┌──▼──┐
  │  A  │     │  E  │
  └─────┘     └─────┘
```

---

This is the beginning of the enhanced guide. Would you like me to continue with more sections including:
- Concurrency & Multithreading with detailed thread lifecycle diagrams
- Memory Management with JVM architecture
- Spring Framework with dependency injection flows
- More detailed code examples and flowcharts?

The complete guide will be much more comprehensive than the current version. Should I proceed?

## Concurrency & Multithreading

### 3. Thread Lifecycle & Synchronization

#### Thread Lifecycle Diagram

```
                    ┌──────────┐
                    │   NEW    │
                    └────┬─────┘
                         │ start()
                    ┌────▼─────┐
              ┌────►│ RUNNABLE │◄────┐
              │     └────┬─────┘     │
              │          │            │
              │          │ Scheduler  │
              │          │            │
    notify()  │     ┌────▼─────┐     │ I/O complete
    notifyAll()│     │ RUNNING  │     │ sleep() ends
              │     └────┬─────┘     │ wait() ends
              │          │            │
              │          ├────────────┘
              │          │
              │          │ wait()
              │          │ sleep()
              │          │ I/O request
              │     ┌────▼─────┐
              └─────┤ BLOCKED/ │
                    │ WAITING  │
                    └────┬─────┘
                         │ completes
                    ┌────▼─────┐
                    │TERMINATED│
                    └──────────┘
```

#### 3.1 Creating Threads

**Three Ways to Create Threads:**

```java
/**
 * Method 1: Extending Thread class
 */
public class MyThread extends Thread {
    private String threadName;
    
    public MyThread(String name) {
        this.threadName = name;
    }
    
    @Override
    public void run() {
        System.out.println("Thread " + threadName + " is running");
        for (int i = 0; i < 5; i++) {
            System.out.println(threadName + ": " + i);
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                System.out.println(threadName + " interrupted");
            }
        }
        System.out.println(threadName + " finished");
    }
}

/**
 * Method 2: Implementing Runnable interface (Preferred)
 */
public class MyRunnable implements Runnable {
    private String taskName;
    
    public MyRunnable(String name) {
        this.taskName = name;
    }
    
    @Override
    public void run() {
        System.out.println("Task " + taskName + " is running");
        // Task logic here
    }
}

/**
 * Method 3: Using Lambda (Java 8+)
 */
public class ThreadExample {
    public static void main(String[] args) {
        // Method 1: Thread class
        MyThread thread1 = new MyThread("Thread-1");
        thread1.start();
        
        // Method 2: Runnable interface
        Thread thread2 = new Thread(new MyRunnable("Task-1"));
        thread2.start();
        
        // Method 3: Lambda expression
        Thread thread3 = new Thread(() -> {
            System.out.println("Lambda thread running");
        });
        thread3.start();
        
        // Method 4: Executor Service (Best Practice)
        ExecutorService executor = Executors.newFixedThreadPool(3);
        executor.submit(() -> System.out.println("Executor task"));
        executor.shutdown();
    }
}
```

#### 3.2 Synchronization Mechanisms

**Problem: Race Condition**

```java
/**
 * Race Condition Example
 * Multiple threads accessing shared resource
 */
public class Counter {
    private int count = 0;
    
    // NOT thread-safe
    public void increment() {
        count++; // This is actually 3 operations:
                 // 1. Read count
                 // 2. Add 1
                 // 3. Write count
    }
    
    public int getCount() {
        return count;
    }
}

// Race condition demonstration
public class RaceConditionDemo {
    public static void main(String[] args) throws InterruptedException {
        Counter counter = new Counter();
        
        // Create 1000 threads, each incrementing 1000 times
        Thread[] threads = new Thread[1000];
        for (int i = 0; i < 1000; i++) {
            threads[i] = new Thread(() -> {
                for (int j = 0; j < 1000; j++) {
                    counter.increment();
                }
            });
            threads[i].start();
        }
        
        // Wait for all threads to complete
        for (Thread thread : threads) {
            thread.join();
        }
        
        // Expected: 1,000,000
        // Actual: Less than 1,000,000 (due to race condition)
        System.out.println("Final count: " + counter.getCount());
    }
}
```

**Solution 1: Synchronized Method**

```java
public class SynchronizedCounter {
    private int count = 0;
    
    // Thread-safe using synchronized method
    public synchronized void increment() {
        count++;
    }
    
    public synchronized int getCount() {
        return count;
    }
}
```

**Solution 2: Synchronized Block**

```java
public class SynchronizedBlockCounter {
    private int count = 0;
    private final Object lock = new Object();
    
    public void increment() {
        synchronized(lock) {
            count++;
        }
    }
    
    public int getCount() {
        synchronized(lock) {
            return count;
        }
    }
}
```

**Solution 3: Atomic Classes**

```java
import java.util.concurrent.atomic.AtomicInteger;

public class AtomicCounter {
    private AtomicInteger count = new AtomicInteger(0);
    
    // Thread-safe without explicit synchronization
    public void increment() {
        count.incrementAndGet();
    }
    
    public int getCount() {
        return count.get();
    }
}
```

**Solution 4: ReentrantLock**

```java
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class LockCounter {
    private int count = 0;
    private final Lock lock = new ReentrantLock();
    
    public void increment() {
        lock.lock();
        try {
            count++;
        } finally {
            lock.unlock(); // Always unlock in finally block
        }
    }
    
    public int getCount() {
        lock.lock();
        try {
            return count;
        } finally {
            lock.unlock();
        }
    }
}
```

#### 3.3 Producer-Consumer Pattern

**Classic Implementation with wait() and notify():**

```java
/**
 * Producer-Consumer using wait/notify
 * 
 * Flow:
 * Producer → produce() → add to queue → notify()
 * Consumer → consume() → remove from queue → notify()
 */
public class ProducerConsumerExample {
    
    static class SharedQueue {
        private Queue<Integer> queue = new LinkedList<>();
        private int capacity;
        
        public SharedQueue(int capacity) {
            this.capacity = capacity;
        }
        
        public synchronized void produce(int item) throws InterruptedException {
            // Wait if queue is full
            while (queue.size() == capacity) {
                System.out.println("Queue full, producer waiting...");
                wait();
            }
            
            queue.add(item);
            System.out.println("Produced: " + item);
            
            // Notify consumer that item is available
            notifyAll();
        }
        
        public synchronized int consume() throws InterruptedException {
            // Wait if queue is empty
            while (queue.isEmpty()) {
                System.out.println("Queue empty, consumer waiting...");
                wait();
            }
            
            int item = queue.poll();
            System.out.println("Consumed: " + item);
            
            // Notify producer that space is available
            notifyAll();
            
            return item;
        }
    }
    
    static class Producer implements Runnable {
        private SharedQueue queue;
        
        public Producer(SharedQueue queue) {
            this.queue = queue;
        }
        
        @Override
        public void run() {
            try {
                for (int i = 1; i <= 10; i++) {
                    queue.produce(i);
                    Thread.sleep(100);
                }
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }
    }
    
    static class Consumer implements Runnable {
        private SharedQueue queue;
        
        public Consumer(SharedQueue queue) {
            this.queue = queue;
        }
        
        @Override
        public void run() {
            try {
                for (int i = 1; i <= 10; i++) {
                    queue.consume();
                    Thread.sleep(200);
                }
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }
    }
    
    public static void main(String[] args) {
        SharedQueue queue = new SharedQueue(5);
        
        Thread producer = new Thread(new Producer(queue));
        Thread consumer = new Thread(new Consumer(queue));
        
        producer.start();
        consumer.start();
    }
}
```

**Modern Implementation with BlockingQueue:**

```java
import java.util.concurrent.*;

/**
 * Producer-Consumer using BlockingQueue
 * Simpler and more efficient
 */
public class ModernProducerConsumer {
    
    static class Producer implements Runnable {
        private BlockingQueue<Integer> queue;
        
        public Producer(BlockingQueue<Integer> queue) {
            this.queue = queue;
        }
        
        @Override
        public void run() {
            try {
                for (int i = 1; i <= 10; i++) {
                    queue.put(i); // Blocks if queue is full
                    System.out.println("Produced: " + i);
                    Thread.sleep(100);
                }
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }
    }
    
    static class Consumer implements Runnable {
        private BlockingQueue<Integer> queue;
        
        public Consumer(BlockingQueue<Integer> queue) {
            this.queue = queue;
        }
        
        @Override
        public void run() {
            try {
                for (int i = 1; i <= 10; i++) {
                    int item = queue.take(); // Blocks if queue is empty
                    System.out.println("Consumed: " + item);
                    Thread.sleep(200);
                }
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
            }
        }
    }
    
    public static void main(String[] args) {
        BlockingQueue<Integer> queue = new ArrayBlockingQueue<>(5);
        
        ExecutorService executor = Executors.newFixedThreadPool(2);
        executor.submit(new Producer(queue));
        executor.submit(new Consumer(queue));
        
        executor.shutdown();
    }
}
```

#### 3.4 Thread Pool & Executor Framework

**Thread Pool Architecture:**

```
ExecutorService
    │
    ├── ThreadPoolExecutor
    │   │
    │   ├── Core Pool Size (minimum threads)
    │   ├── Maximum Pool Size
    │   ├── Keep Alive Time
    │   ├── Work Queue (BlockingQueue)
    │   └── Thread Factory
    │
    └── ScheduledThreadPoolExecutor
        └── For scheduled/periodic tasks
```

**Comprehensive Thread Pool Example:**

```java
import java.util.concurrent.*;
import java.util.List;
import java.util.ArrayList;

/**
 * Thread Pool Best Practices
 */
public class ThreadPoolExample {
    
    /**
     * Different types of thread pools
     */
    public static void demonstrateThreadPools() {
        
        // 1. Fixed Thread Pool - Fixed number of threads
        ExecutorService fixedPool = Executors.newFixedThreadPool(5);
        
        // 2. Cached Thread Pool - Creates threads as needed
        ExecutorService cachedPool = Executors.newCachedThreadPool();
        
        // 3. Single Thread Executor - Only one thread
        ExecutorService singleThread = Executors.newSingleThreadExecutor();
        
        // 4. Scheduled Thread Pool - For scheduled tasks
        ScheduledExecutorService scheduledPool = 
            Executors.newScheduledThreadPool(3);
        
        // 5. Custom Thread Pool (Recommended for production)
        ThreadPoolExecutor customPool = new ThreadPoolExecutor(
            5,                      // Core pool size
            10,                     // Maximum pool size
            60L,                    // Keep alive time
            TimeUnit.SECONDS,       // Time unit
            new LinkedBlockingQueue<>(100), // Work queue
            new ThreadPoolExecutor.CallerRunsPolicy() // Rejection policy
        );
    }
    
    /**
     * Using Thread Pool with Callable (returns result)
     */
    public static void callableExample() throws Exception {
        ExecutorService executor = Executors.newFixedThreadPool(3);
        
        // Create tasks that return results
        List<Callable<Integer>> tasks = new ArrayList<>();
        for (int i = 1; i <= 5; i++) {
            final int taskId = i;
            tasks.add(() -> {
                Thread.sleep(1000);
                return taskId * taskId;
            });
        }
        
        // Submit all tasks and get futures
        List<Future<Integer>> futures = executor.invokeAll(tasks);
        
        // Get results
        for (Future<Integer> future : futures) {
            System.out.println("Result: " + future.get());
        }
        
        executor.shutdown();
    }
    
    /**
     * CompletableFuture - Modern async programming
     */
    public static void completableFutureExample() {
        // Async task
        CompletableFuture<String> future = CompletableFuture.supplyAsync(() -> {
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                throw new RuntimeException(e);
            }
            return "Hello";
        });
        
        // Chain operations
        CompletableFuture<String> result = future
            .thenApply(s -> s + " World")
            .thenApply(String::toUpperCase)
            .exceptionally(ex -> "Error: " + ex.getMessage());
        
        // Get result (blocks)
        try {
            System.out.println(result.get());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    /**
     * Parallel Stream - Simplest parallel processing
     */
    public static void parallelStreamExample() {
        List<Integer> numbers = List.of(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
        
        // Parallel processing
        int sum = numbers.parallelStream()
            .map(n -> n * n)
            .reduce(0, Integer::sum);
        
        System.out.println("Sum of squares: " + sum);
    }
}
```

**Thread Pool Flow Diagram:**

```
Task Submission
    │
    ▼
┌─────────────────┐
│  Work Queue     │
│  [T1][T2][T3]   │
└────────┬────────┘
         │
    ┌────┴────┐
    │ Threads │
    ├─────────┤
    │Thread 1 │──> Executing Task
    │Thread 2 │──> Executing Task
    │Thread 3 │──> Idle
    │Thread 4 │──> Idle
    │Thread 5 │──> Idle
    └─────────┘
```

---

## Memory Management & JVM

### 4. JVM Architecture & Garbage Collection

#### 4.1 JVM Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    JVM ARCHITECTURE                     │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  ┌──────────────────────────────────────────────────┐  │
│  │           Class Loader Subsystem                 │  │
│  │  ┌──────────┐  ┌──────────┐  ┌──────────┐      │  │
│  │  │Bootstrap │→ │Extension │→ │Application│      │  │
│  │  │ Loader   │  │  Loader  │  │  Loader   │      │  │
│  │  └──────────┘  └──────────┘  └──────────┘      │  │
│  └──────────────────────────────────────────────────┘  │
│                                                         │
│  ┌──────────────────────────────────────────────────┐  │
│  │              Runtime Data Areas                  │  │
│  │                                                  │  │
│  │  ┌────────────────────────────────────────────┐ │  │
│  │  │         Method Area (Metaspace)            │ │  │
│  │  │  - Class metadata                          │ │  │
│  │  │  - Static variables                        │ │  │
│  │  │  - Constant pool                           │ │  │
│  │  └────────────────────────────────────────────┘ │  │
│  │                                                  │  │
│  │  ┌────────────────────────────────────────────┐ │  │
│  │  │              Heap Memory                   │ │  │
│  │  │  ┌──────────────┐  ┌──────────────┐       │ │  │
│  │  │  │ Young Gen    │  │  Old Gen     │       │ │  │
│  │  │  │ ┌──┐┌──┐┌──┐│  │              │       │ │  │
│  │  │  │ │E │S0│S1││  │              │       │ │  │
│  │  │  │ └──┘└──┘└──┘│  │              │       │ │  │
│  │  │  └──────────────┘  └──────────────┘       │ │  │
│  │  └────────────────────────────────────────────┘ │  │
│  │                                                  │  │
│  │  ┌────────────┐  ┌────────────┐  ┌───────────┐ │  │
│  │  │   Stack    │  │   PC Reg   │  │  Native   │ │  │
│  │  │  (Thread)  │  │  (Thread)  │  │  Method   │ │  │
│  │  └────────────┘  └────────────┘  └───────────┘ │  │
│  └──────────────────────────────────────────────────┘  │
│                                                         │
│  ┌──────────────────────────────────────────────────┐  │
│  │           Execution Engine                       │  │
│  │  ┌──────────┐  ┌──────────┐  ┌──────────┐      │  │
│  │  │Interpreter│  │   JIT    │  │ Garbage  │      │  │
│  │  │          │  │ Compiler │  │Collector │      │  │
│  │  └──────────┘  └──────────┘  └──────────┘      │  │
│  └──────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
```

#### 4.2 Memory Areas Explained

**Stack Memory:**
```java
/**
 * Stack Memory Example
 * - Stores local variables and method calls
 * - Thread-specific
 * - LIFO structure
 */
public class StackExample {
    public static void main(String[] args) {
        int x = 10;           // Stored in stack
        String name = "John"; // Reference in stack, object in heap
        
        method1(x);
    }
    
    public static void method1(int a) {
        int b = 20;
        method2(b);
    }
    
    public static void method2(int c) {
        int d = 30;
        // Stack at this point:
        // | d = 30      | method2
        // | c = 20      | method2
        // | b = 20      | method1
        // | a = 10      | method1
        // | x = 10      | main
        // | name ref    | main
    }
}
```

**Heap Memory:**
```java
/**
 * Heap Memory Example
 * - Stores objects and arrays
 * - Shared among all threads
 * - Garbage collected
 */
public class HeapExample {
    public static void main(String[] args) {
        // Object created in heap
        Person person = new Person("John", 30);
        
        // Array created in heap
        int[] numbers = new int[100];
        
        // String pool (special area in heap)
        String s1 = "Hello";  // In string pool
        String s2 = "Hello";  // Same reference as s1
        String s3 = new String("Hello"); // New object in heap
    }
}

class Person {
    String name;  // Reference in object, actual string in heap
    int age;      // Primitive in object
    
    public Person(String name, int age) {
        this.name = name;
        this.age = age;
    }
}
```

#### 4.3 Garbage Collection

**Garbage Collection Process:**

```
Young Generation (Minor GC)
    │
    ├── Eden Space
    │   └── New objects created here
    │
    ├── Survivor Space 0 (S0)
    │   └── Objects that survived 1 GC
    │
    └── Survivor Space 1 (S1)
        └── Objects that survived multiple GCs
        
Old Generation (Major GC)
    └── Long-lived objects promoted here
    
Permanent Generation / Metaspace
    └── Class metadata
```

**GC Algorithm Flow:**

```
1. Object Creation
   ↓
   Eden Space
   ↓
2. Eden Full → Minor GC
   ↓
   Surviving objects → S0
   ↓
3. Next Minor GC
   ↓
   Eden + S0 → S1
   ↓
4. Age threshold reached
   ↓
   Promote to Old Generation
   ↓
5. Old Generation Full → Major GC
   ↓
   Full GC (Stop-the-World)
```

**Garbage Collection Example:**

```java
/**
 * Understanding GC behavior
 */
public class GCExample {
    
    /**
     * Objects eligible for GC
     */
    public static void demonstrateGC() {
        // Object 1 - will be eligible for GC
        Person p1 = new Person("John");
        
        // Object 2 - will be eligible for GC
        Person p2 = new Person("Jane");
        
        // Make p1 eligible for GC
        p1 = null;
        
        // Suggest JVM to run GC (not guaranteed)
        System.gc();
        
        // Object 3 - still referenced, not eligible
        Person p3 = new Person("Bob");
        
        // p2 goes out of scope after method ends
    }
    
    /**
     * finalize() method - called before GC (deprecated in Java 9+)
     */
    static class Person {
        String name;
        
        public Person(String name) {
            this.name = name;
        }
        
        @Override
        protected void finalize() throws Throwable {
            System.out.println(name + " is being garbage collected");
            super.finalize();
        }
    }
    
    /**
     * Memory leak example - objects not eligible for GC
     */
    public static void memoryLeakExample() {
        List<byte[]> list = new ArrayList<>();
        
        while (true) {
            // Creates objects that are never released
            byte[] data = new byte[1024 * 1024]; // 1 MB
            list.add(data);
            
            // Eventually causes OutOfMemoryError
        }
    }
    
    /**
     * Proper resource management with try-with-resources
     */
    public static void properResourceManagement() {
        // AutoCloseable resources are automatically closed
        try (FileInputStream fis = new FileInputStream("file.txt");
             BufferedReader reader = new BufferedReader(
                 new InputStreamReader(fis))) {
            
            String line = reader.readLine();
            System.out.println(line);
            
        } catch (IOException e) {
            e.printStackTrace();
        }
        // Resources automatically closed here
    }
}
```

**Types of Garbage Collectors:**

```
1. Serial GC
   - Single-threaded
   - For small applications
   - Flag: -XX:+UseSerialGC

2. Parallel GC (Throughput Collector)
   - Multiple threads for young generation
   - For multi-core systems
   - Flag: -XX:+UseParallelGC

3. CMS (Concurrent Mark Sweep)
   - Low pause times
   - Deprecated in Java 9
   - Flag: -XX:+UseConcMarkSweepGC

4. G1 GC (Garbage First)
   - Default in Java 9+
   - Predictable pause times
   - Flag: -XX:+UseG1GC

5. ZGC (Z Garbage Collector)
   - Ultra-low latency
   - Java 11+
   - Flag: -XX:+UseZGC

6. Shenandoah GC
   - Low pause times
   - Java 12+
   - Flag: -XX:+UseShenandoahGC
```

**JVM Tuning Parameters:**

```java
/**
 * Common JVM flags for memory tuning
 */
public class JVMTuning {
    /*
     * Heap Size:
     * -Xms2g          Initial heap size (2GB)
     * -Xmx4g          Maximum heap size (4GB)
     * 
     * Young Generation:
     * -Xmn1g          Young generation size (1GB)
     * -XX:NewRatio=2  Old/Young ratio
     * 
     * Garbage Collection:
     * -XX:+UseG1GC                Use G1 collector
     * -XX:MaxGCPauseMillis=200    Target pause time
     * -XX:+PrintGCDetails         Print GC logs
     * -XX:+PrintGCDateStamps      Add timestamps
     * 
     * Metaspace:
     * -XX:MetaspaceSize=256m      Initial metaspace
     * -XX:MaxMetaspaceSize=512m   Max metaspace
     * 
     * Thread Stack:
     * -Xss1m          Stack size per thread (1MB)
     * 
     * Example command:
     * java -Xms2g -Xmx4g -XX:+UseG1GC -XX:MaxGCPauseMillis=200 
     *      -XX:+PrintGCDetails -jar myapp.jar
     */
}
```

---

Would you like me to continue with:
1. Java 8+ Features (Streams, Lambdas, Optional)
2. Spring Framework Deep Dive
3. Design Patterns with detailed examples
4. Performance Optimization techniques
5. All of the above?

Let me know and I'll continue building this comprehensive guide!

## Java 8 Features

### 5. Lambda Expressions & Functional Programming

#### 5.1 Lambda Expressions

**Syntax and Usage:**

```java
/**
 * Lambda Expression Syntax
 * 
 * (parameters) -> expression
 * (parameters) -> { statements; }
 */
public class LambdaExamples {
    
    /**
     * Traditional vs Lambda approach
     */
    public static void traditionalVsLambda() {
        List<String> names = Arrays.asList("John", "Jane", "Bob", "Alice");
        
        // Traditional approach with anonymous class
        Collections.sort(names, new Comparator<String>() {
            @Override
            public int compare(String s1, String s2) {
                return s1.compareTo(s2);
            }
        });
        
        // Lambda approach
        Collections.sort(names, (s1, s2) -> s1.compareTo(s2));
        
        // Even simpler with method reference
        Collections.sort(names, String::compareTo);
    }
    
    /**
     * Lambda with different parameter counts
     */
    public static void lambdaVariations() {
        // No parameters
        Runnable r1 = () -> System.out.println("Hello");
        
        // One parameter (parentheses optional)
        Consumer<String> c1 = s -> System.out.println(s);
        Consumer<String> c2 = (s) -> System.out.println(s);
        
        // Multiple parameters
        BiFunction<Integer, Integer, Integer> add = (a, b) -> a + b;
        
        // Multiple statements (requires braces)
        BiFunction<Integer, Integer, Integer> multiply = (a, b) -> {
            int result = a * b;
            System.out.println("Result: " + result);
            return result;
        };
    }
    
    /**
     * Functional Interfaces - Single Abstract Method (SAM)
     */
    @FunctionalInterface
    interface Calculator {
        int calculate(int a, int b);
        
        // Default methods allowed
        default void printResult(int result) {
            System.out.println("Result: " + result);
        }
        
        // Static methods allowed
        static Calculator getAddition() {
            return (a, b) -> a + b;
        }
    }
    
    public static void functionalInterfaceExample() {
        Calculator add = (a, b) -> a + b;
        Calculator subtract = (a, b) -> a - b;
        Calculator multiply = (a, b) -> a * b;
        Calculator divide = (a, b) -> a / b;
        
        System.out.println("10 + 5 = " + add.calculate(10, 5));
        System.out.println("10 - 5 = " + subtract.calculate(10, 5));
        System.out.println("10 * 5 = " + multiply.calculate(10, 5));
        System.out.println("10 / 5 = " + divide.calculate(10, 5));
    }
}
```

**Built-in Functional Interfaces:**

```java
import java.util.function.*;

/**
 * Common Functional Interfaces in java.util.function
 */
public class FunctionalInterfacesDemo {
    
    public static void demonstrateInterfaces() {
        // 1. Predicate<T> - Takes T, returns boolean
        Predicate<Integer> isEven = n -> n % 2 == 0;
        System.out.println("Is 4 even? " + isEven.test(4));
        
        // 2. Function<T, R> - Takes T, returns R
        Function<String, Integer> stringLength = s -> s.length();
        System.out.println("Length: " + stringLength.apply("Hello"));
        
        // 3. Consumer<T> - Takes T, returns void
        Consumer<String> printer = s -> System.out.println(s);
        printer.accept("Hello World");
        
        // 4. Supplier<T> - Takes nothing, returns T
        Supplier<Double> randomSupplier = () -> Math.random();
        System.out.println("Random: " + randomSupplier.get());
        
        // 5. BiFunction<T, U, R> - Takes T and U, returns R
        BiFunction<Integer, Integer, Integer> add = (a, b) -> a + b;
        System.out.println("Sum: " + add.apply(5, 3));
        
        // 6. BiPredicate<T, U> - Takes T and U, returns boolean
        BiPredicate<String, String> startsWith = (s, prefix) -> s.startsWith(prefix);
        System.out.println("Starts with? " + startsWith.test("Hello", "He"));
        
        // 7. UnaryOperator<T> - Takes T, returns T
        UnaryOperator<Integer> square = n -> n * n;
        System.out.println("Square: " + square.apply(5));
        
        // 8. BinaryOperator<T> - Takes two T, returns T
        BinaryOperator<Integer> max = (a, b) -> a > b ? a : b;
        System.out.println("Max: " + max.apply(10, 20));
    }
}
```

#### 5.2 Stream API

**Stream Pipeline Architecture:**

```
Source → Intermediate Operations → Terminal Operation
         (filter, map, sorted)     (collect, forEach, reduce)
         
         Lazy Evaluation           Triggers Execution
```

**Comprehensive Stream Examples:**

```java
import java.util.*;
import java.util.stream.*;

/**
 * Stream API - Functional-style operations on collections
 */
public class StreamAPIExamples {
    
    static class Employee {
        String name;
        String department;
        double salary;
        int age;
        
        public Employee(String name, String department, double salary, int age) {
            this.name = name;
            this.department = department;
            this.salary = salary;
            this.age = age;
        }
        
        // Getters
        public String getName() { return name; }
        public String getDepartment() { return department; }
        public double getSalary() { return salary; }
        public int getAge() { return age; }
    }
    
    /**
     * Creating Streams
     */
    public static void creatingStreams() {
        // From collection
        List<String> list = Arrays.asList("a", "b", "c");
        Stream<String> stream1 = list.stream();
        
        // From array
        String[] array = {"a", "b", "c"};
        Stream<String> stream2 = Arrays.stream(array);
        
        // Using Stream.of()
        Stream<String> stream3 = Stream.of("a", "b", "c");
        
        // Infinite stream
        Stream<Integer> infiniteStream = Stream.iterate(0, n -> n + 1);
        
        // Generate stream
        Stream<Double> randomStream = Stream.generate(Math::random);
        
        // Range
        IntStream range = IntStream.range(1, 10); // 1 to 9
        IntStream rangeClosed = IntStream.rangeClosed(1, 10); // 1 to 10
    }
    
    /**
     * Intermediate Operations (Lazy)
     */
    public static void intermediateOperations() {
        List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
        
        // filter - Select elements
        List<Integer> evenNumbers = numbers.stream()
            .filter(n -> n % 2 == 0)
            .collect(Collectors.toList());
        
        // map - Transform elements
        List<Integer> squares = numbers.stream()
            .map(n -> n * n)
            .collect(Collectors.toList());
        
        // flatMap - Flatten nested structures
        List<List<Integer>> nestedList = Arrays.asList(
            Arrays.asList(1, 2),
            Arrays.asList(3, 4),
            Arrays.asList(5, 6)
        );
        List<Integer> flatList = nestedList.stream()
            .flatMap(List::stream)
            .collect(Collectors.toList());
        
        // distinct - Remove duplicates
        List<Integer> unique = Arrays.asList(1, 2, 2, 3, 3, 4).stream()
            .distinct()
            .collect(Collectors.toList());
        
        // sorted - Sort elements
        List<Integer> sorted = numbers.stream()
            .sorted(Comparator.reverseOrder())
            .collect(Collectors.toList());
        
        // limit - Limit size
        List<Integer> limited = numbers.stream()
            .limit(5)
            .collect(Collectors.toList());
        
        // skip - Skip elements
        List<Integer> skipped = numbers.stream()
            .skip(5)
            .collect(Collectors.toList());
        
        // peek - Debug/side effects
        numbers.stream()
            .peek(n -> System.out.println("Processing: " + n))
            .map(n -> n * 2)
            .peek(n -> System.out.println("After map: " + n))
            .collect(Collectors.toList());
    }
    
    /**
     * Terminal Operations (Eager)
     */
    public static void terminalOperations() {
        List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5);
        
        // forEach - Iterate
        numbers.stream().forEach(System.out::println);
        
        // collect - Collect to collection
        List<Integer> list = numbers.stream().collect(Collectors.toList());
        Set<Integer> set = numbers.stream().collect(Collectors.toSet());
        
        // reduce - Reduce to single value
        int sum = numbers.stream().reduce(0, (a, b) -> a + b);
        int product = numbers.stream().reduce(1, (a, b) -> a * b);
        
        // count - Count elements
        long count = numbers.stream().count();
        
        // anyMatch, allMatch, noneMatch
        boolean hasEven = numbers.stream().anyMatch(n -> n % 2 == 0);
        boolean allPositive = numbers.stream().allMatch(n -> n > 0);
        boolean noneNegative = numbers.stream().noneMatch(n -> n < 0);
        
        // findFirst, findAny
        Optional<Integer> first = numbers.stream().findFirst();
        Optional<Integer> any = numbers.stream().findAny();
        
        // min, max
        Optional<Integer> min = numbers.stream().min(Integer::compareTo);
        Optional<Integer> max = numbers.stream().max(Integer::compareTo);
    }
    
    /**
     * Complex Stream Operations
     */
    public static void complexOperations() {
        List<Employee> employees = Arrays.asList(
            new Employee("John", "IT", 75000, 30),
            new Employee("Jane", "HR", 65000, 28),
            new Employee("Bob", "IT", 85000, 35),
            new Employee("Alice", "Finance", 70000, 32),
            new Employee("Charlie", "IT", 90000, 40)
        );
        
        // Group by department
        Map<String, List<Employee>> byDepartment = employees.stream()
            .collect(Collectors.groupingBy(Employee::getDepartment));
        
        // Average salary by department
        Map<String, Double> avgSalaryByDept = employees.stream()
            .collect(Collectors.groupingBy(
                Employee::getDepartment,
                Collectors.averagingDouble(Employee::getSalary)
            ));
        
        // Count by department
        Map<String, Long> countByDept = employees.stream()
            .collect(Collectors.groupingBy(
                Employee::getDepartment,
                Collectors.counting()
            ));
        
        // Partition by salary > 75000
        Map<Boolean, List<Employee>> partitioned = employees.stream()
            .collect(Collectors.partitioningBy(e -> e.getSalary() > 75000));
        
        // Top 3 highest paid employees
        List<Employee> top3 = employees.stream()
            .sorted(Comparator.comparing(Employee::getSalary).reversed())
            .limit(3)
            .collect(Collectors.toList());
        
        // Names of IT employees with salary > 80000
        List<String> itHighEarners = employees.stream()
            .filter(e -> e.getDepartment().equals("IT"))
            .filter(e -> e.getSalary() > 80000)
            .map(Employee::getName)
            .collect(Collectors.toList());
        
        // Total salary by department
        Map<String, Double> totalSalaryByDept = employees.stream()
            .collect(Collectors.groupingBy(
                Employee::getDepartment,
                Collectors.summingDouble(Employee::getSalary)
            ));
        
        // Statistics
        DoubleSummaryStatistics salaryStats = employees.stream()
            .collect(Collectors.summarizingDouble(Employee::getSalary));
        System.out.println("Average: " + salaryStats.getAverage());
        System.out.println("Max: " + salaryStats.getMax());
        System.out.println("Min: " + salaryStats.getMin());
        System.out.println("Sum: " + salaryStats.getSum());
        System.out.println("Count: " + salaryStats.getCount());
    }
    
    /**
     * Parallel Streams
     */
    public static void parallelStreams() {
        List<Integer> numbers = IntStream.rangeClosed(1, 1000000)
            .boxed()
            .collect(Collectors.toList());
        
        // Sequential stream
        long start = System.currentTimeMillis();
        long sum1 = numbers.stream()
            .mapToLong(Integer::longValue)
            .sum();
        long end = System.currentTimeMillis();
        System.out.println("Sequential: " + (end - start) + "ms");
        
        // Parallel stream
        start = System.currentTimeMillis();
        long sum2 = numbers.parallelStream()
            .mapToLong(Integer::longValue)
            .sum();
        end = System.currentTimeMillis();
        System.out.println("Parallel: " + (end - start) + "ms");
    }
}
```

**Stream Processing Flow:**

```
Data Source: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    │
    ├─> filter(n -> n % 2 == 0)
    │   Result: [2, 4, 6, 8, 10]
    │
    ├─> map(n -> n * n)
    │   Result: [4, 16, 36, 64, 100]
    │
    ├─> sorted()
    │   Result: [4, 16, 36, 64, 100]
    │
    └─> collect(Collectors.toList())
        Final: [4, 16, 36, 64, 100]
```

#### 5.3 Optional Class

**Avoiding NullPointerException:**

```java
import java.util.Optional;

/**
 * Optional - Container for potentially null values
 */
public class OptionalExamples {
    
    static class User {
        private String name;
        private String email;
        private Address address;
        
        public Optional<String> getName() {
            return Optional.ofNullable(name);
        }
        
        public Optional<Address> getAddress() {
            return Optional.ofNullable(address);
        }
    }
    
    static class Address {
        private String city;
        private String zipCode;
        
        public Optional<String> getCity() {
            return Optional.ofNullable(city);
        }
    }
    
    /**
     * Creating Optional
     */
    public static void creatingOptional() {
        // Empty optional
        Optional<String> empty = Optional.empty();
        
        // Optional with non-null value
        Optional<String> nonEmpty = Optional.of("Hello");
        
        // Optional that may be null
        String nullableValue = null;
        Optional<String> nullable = Optional.ofNullable(nullableValue);
    }
    
    /**
     * Checking and Retrieving Values
     */
    public static void checkingValues() {
        Optional<String> optional = Optional.of("Hello");
        
        // Check if present
        if (optional.isPresent()) {
            System.out.println(optional.get());
        }
        
        // Better: ifPresent with lambda
        optional.ifPresent(value -> System.out.println(value));
        
        // Get with default
        String value1 = optional.orElse("Default");
        
        // Get with supplier
        String value2 = optional.orElseGet(() -> "Default from supplier");
        
        // Throw exception if empty
        String value3 = optional.orElseThrow(() -> 
            new IllegalStateException("Value not present"));
    }
    
    /**
     * Transforming Optional
     */
    public static void transformingOptional() {
        Optional<String> optional = Optional.of("hello");
        
        // map - Transform value
        Optional<String> upper = optional.map(String::toUpperCase);
        
        // filter - Filter value
        Optional<String> filtered = optional.filter(s -> s.length() > 3);
        
        // flatMap - Avoid nested Optional
        User user = new User();
        Optional<String> city = Optional.ofNullable(user)
            .flatMap(User::getAddress)
            .flatMap(Address::getCity);
    }
    
    /**
     * Practical Example: Safe Navigation
     */
    public static String getUserCity(User user) {
        // Traditional approach (verbose)
        if (user != null) {
            Address address = user.getAddress().orElse(null);
            if (address != null) {
                return address.getCity().orElse("Unknown");
            }
        }
        return "Unknown";
        
        // Optional approach (clean)
        return Optional.ofNullable(user)
            .flatMap(User::getAddress)
            .flatMap(Address::getCity)
            .orElse("Unknown");
    }
    
    /**
     * Optional in Streams
     */
    public static void optionalInStreams() {
        List<Optional<String>> listOfOptionals = Arrays.asList(
            Optional.of("A"),
            Optional.empty(),
            Optional.of("B"),
            Optional.empty(),
            Optional.of("C")
        );
        
        // Extract present values
        List<String> values = listOfOptionals.stream()
            .filter(Optional::isPresent)
            .map(Optional::get)
            .collect(Collectors.toList());
        
        // Java 9+: flatMap with Optional::stream
        List<String> values2 = listOfOptionals.stream()
            .flatMap(Optional::stream)
            .collect(Collectors.toList());
    }
}
```

#### 5.4 Method References

**Types of Method References:**

```java
/**
 * Method References - Shorthand for lambda expressions
 */
public class MethodReferenceExamples {
    
    /**
     * 1. Static Method Reference
     * ClassName::staticMethod
     */
    public static void staticMethodReference() {
        List<String> numbers = Arrays.asList("1", "2", "3");
        
        // Lambda
        List<Integer> ints1 = numbers.stream()
            .map(s -> Integer.parseInt(s))
            .collect(Collectors.toList());
        
        // Method reference
        List<Integer> ints2 = numbers.stream()
            .map(Integer::parseInt)
            .collect(Collectors.toList());
    }
    
    /**
     * 2. Instance Method Reference
     * instance::instanceMethod
     */
    public static void instanceMethodReference() {
        String prefix = "Hello, ";
        List<String> names = Arrays.asList("John", "Jane", "Bob");
        
        // Lambda
        names.forEach(name -> System.out.println(prefix + name));
        
        // Method reference
        names.forEach(System.out::println);
    }
    
    /**
     * 3. Instance Method of Arbitrary Object
     * ClassName::instanceMethod
     */
    public static void arbitraryObjectMethodReference() {
        List<String> names = Arrays.asList("john", "jane", "bob");
        
        // Lambda
        List<String> upper1 = names.stream()
            .map(s -> s.toUpperCase())
            .collect(Collectors.toList());
        
        // Method reference
        List<String> upper2 = names.stream()
            .map(String::toUpperCase)
            .collect(Collectors.toList());
    }
    
    /**
     * 4. Constructor Reference
     * ClassName::new
     */
    public static void constructorReference() {
        List<String> names = Arrays.asList("John", "Jane", "Bob");
        
        // Lambda
        List<Person> people1 = names.stream()
            .map(name -> new Person(name))
            .collect(Collectors.toList());
        
        // Constructor reference
        List<Person> people2 = names.stream()
            .map(Person::new)
            .collect(Collectors.toList());
    }
    
    static class Person {
        String name;
        Person(String name) { this.name = name; }
    }
}
```

---

## Spring Framework

### 6. Spring Core Concepts

#### 6.1 Dependency Injection & IoC Container

**Inversion of Control (IoC) Concept:**

```
Traditional Flow:
    Application → Creates Dependencies → Uses Dependencies

IoC Flow:
    Application → Declares Dependencies
    IoC Container → Creates Dependencies → Injects into Application
```

**Dependency Injection Types:**

```java
/**
 * Three types of Dependency Injection
 */

// 1. Constructor Injection (Recommended)
@Service
public class UserService {
    private final UserRepository userRepository;
    private final EmailService emailService;
    
    @Autowired  // Optional in Spring 4.3+ if single constructor
    public UserService(UserRepository userRepository, 
                      EmailService emailService) {
        this.userRepository = userRepository;
        this.emailService = emailService;
    }
}

// 2. Setter Injection
@Service
public class OrderService {
    private OrderRepository orderRepository;
    
    @Autowired
    public void setOrderRepository(OrderRepository orderRepository) {
        this.orderRepository = orderRepository;
    }
}

// 3. Field Injection (Not Recommended)
@Service
public class ProductService {
    @Autowired
    private ProductRepository productRepository;
}
```

**Spring Bean Lifecycle:**

```
Container Started
    │
    ├─> Bean Definition Loaded
    │
    ├─> Bean Instantiation
    │
    ├─> Dependency Injection
    │
    ├─> @PostConstruct / InitializingBean
    │
    ├─> Bean Ready for Use
    │
    ├─> Container Shutdown
    │
    └─> @PreDestroy / DisposableBean
```

**Complete Bean Lifecycle Example:**

```java
import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.beans.factory.InitializingBean;

/**
 * Bean Lifecycle Demonstration
 */
@Component
public class LifecycleBean implements InitializingBean, DisposableBean {
    
    private String name;
    
    // 1. Constructor
    public LifecycleBean() {
        System.out.println("1. Constructor called");
    }
    
    // 2. Setter injection
    @Autowired
    public void setName(@Value("${bean.name}") String name) {
        System.out.println("2. Setter injection: " + name);
        this.name = name;
    }
    
    // 3. @PostConstruct
    @PostConstruct
    public void init() {
        System.out.println("3. @PostConstruct called");
    }
    
    // 4. InitializingBean interface
    @Override
    public void afterPropertiesSet() throws Exception {
        System.out.println("4. afterPropertiesSet() called");
    }
    
    // 5. Custom init method (if configured)
    public void customInit() {
        System.out.println("5. Custom init method called");
    }
    
    // Bean is now ready for use
    
    // 6. @PreDestroy
    @PreDestroy
    public void cleanup() {
        System.out.println("6. @PreDestroy called");
    }
    
    // 7. DisposableBean interface
    @Override
    public void destroy() throws Exception {
        System.out.println("7. destroy() called");
    }
    
    // 8. Custom destroy method (if configured)
    public void customDestroy() {
        System.out.println("8. Custom destroy method called");
    }
}
```

**Bean Scopes:**

```java
/**
 * Spring Bean Scopes
 */

// 1. Singleton (Default) - One instance per container
@Component
@Scope("singleton")
public class SingletonBean {
    // Shared across entire application
}

// 2. Prototype - New instance every time
@Component
@Scope("prototype")
public class PrototypeBean {
    // New instance for each request
}

// 3. Request - One instance per HTTP request (Web)
@Component
@Scope(value = WebApplicationContext.SCOPE_REQUEST, proxyMode = ScopedProxyMode.TARGET_CLASS)
public class RequestScopedBean {
    // New instance for each HTTP request
}

// 4. Session - One instance per HTTP session (Web)
@Component
@Scope(value = WebApplicationContext.SCOPE_SESSION, proxyMode = ScopedProxyMode.TARGET_CLASS)
public class SessionScopedBean {
    // One instance per user session
}

// 5. Application - One instance per ServletContext (Web)
@Component
@Scope(value = WebApplicationContext.SCOPE_APPLICATION, proxyMode = ScopedProxyMode.TARGET_CLASS)
public class ApplicationScopedBean {
    // One instance per web application
}
```

---

Would you like me to continue with:
1. Spring Boot deep dive (Auto-configuration, Starters, Actuator)
2. Spring Data JPA (Repositories, Queries, Transactions)
3. Spring Security (Authentication, Authorization, JWT)
4. Spring Cloud & Microservices patterns
5. Design Patterns with Spring examples
6. All of the above?

Let me know and I'll continue!

### 7. Spring Boot Essentials

#### 7.1 Spring Boot Auto-Configuration

**How Auto-Configuration Works:**

```
@SpringBootApplication
    │
    ├─> @SpringBootConfiguration
    │   └─> @Configuration
    │
    ├─> @EnableAutoConfiguration
    │   └─> Scans META-INF/spring.factories
    │       └─> Conditionally configures beans
    │
    └─> @ComponentScan
        └─> Scans for @Component, @Service, @Repository, @Controller
```

**Complete Spring Boot Application:**

```java
/**
 * Main Application Class
 */
@SpringBootApplication
public class Application {
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}

/**
 * REST Controller
 */
@RestController
@RequestMapping("/api/users")
public class UserController {
    
    private final UserService userService;
    
    public UserController(UserService userService) {
        this.userService = userService;
    }
    
    @GetMapping
    public ResponseEntity<List<UserDTO>> getAllUsers() {
        return ResponseEntity.ok(userService.findAll());
    }
    
    @GetMapping("/{id}")
    public ResponseEntity<UserDTO> getUserById(@PathVariable Long id) {
        return userService.findById(id)
            .map(ResponseEntity::ok)
            .orElse(ResponseEntity.notFound().build());
    }
    
    @PostMapping
    public ResponseEntity<UserDTO> createUser(@Valid @RequestBody UserDTO userDTO) {
        UserDTO created = userService.create(userDTO);
        return ResponseEntity.status(HttpStatus.CREATED).body(created);
    }
    
    @PutMapping("/{id}")
    public ResponseEntity<UserDTO> updateUser(
            @PathVariable Long id,
            @Valid @RequestBody UserDTO userDTO) {
        return userService.update(id, userDTO)
            .map(ResponseEntity::ok)
            .orElse(ResponseEntity.notFound().build());
    }
    
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteUser(@PathVariable Long id) {
        userService.delete(id);
        return ResponseEntity.noContent().build();
    }
}

/**
 * Service Layer
 */
@Service
@Transactional
public class UserService {
    
    private final UserRepository userRepository;
    private final ModelMapper modelMapper;
    
    public UserService(UserRepository userRepository, ModelMapper modelMapper) {
        this.userRepository = userRepository;
        this.modelMapper = modelMapper;
    }
    
    @Transactional(readOnly = true)
    public List<UserDTO> findAll() {
        return userRepository.findAll().stream()
            .map(user -> modelMapper.map(user, UserDTO.class))
            .collect(Collectors.toList());
    }
    
    @Transactional(readOnly = true)
    public Optional<UserDTO> findById(Long id) {
        return userRepository.findById(id)
            .map(user -> modelMapper.map(user, UserDTO.class));
    }
    
    public UserDTO create(UserDTO userDTO) {
        User user = modelMapper.map(userDTO, User.class);
        User saved = userRepository.save(user);
        return modelMapper.map(saved, UserDTO.class);
    }
    
    public Optional<UserDTO> update(Long id, UserDTO userDTO) {
        return userRepository.findById(id)
            .map(user -> {
                modelMapper.map(userDTO, user);
                User updated = userRepository.save(user);
                return modelMapper.map(updated, UserDTO.class);
            });
    }
    
    public void delete(Long id) {
        userRepository.deleteById(id);
    }
}

/**
 * Repository Layer
 */
@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByEmail(String email);
    List<User> findByAgeGreaterThan(int age);
    
    @Query("SELECT u FROM User u WHERE u.name LIKE %:name%")
    List<User> searchByName(@Param("name") String name);
}

/**
 * Entity
 */
@Entity
@Table(name = "users")
public class User {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(nullable = false)
    private String name;
    
    @Column(unique = true, nullable = false)
    private String email;
    
    private int age;
    
    @CreatedDate
    @Column(nullable = false, updatable = false)
    private LocalDateTime createdAt;
    
    @LastModifiedDate
    private LocalDateTime updatedAt;
    
    // Getters and Setters
}

/**
 * DTO
 */
public class UserDTO {
    private Long id;
    
    @NotBlank(message = "Name is required")
    private String name;
    
    @Email(message = "Invalid email format")
    @NotBlank(message = "Email is required")
    private String email;
    
    @Min(value = 18, message = "Age must be at least 18")
    private int age;
    
    // Getters and Setters
}

/**
 * Configuration
 */
@Configuration
public class AppConfig {
    
    @Bean
    public ModelMapper modelMapper() {
        return new ModelMapper();
    }
    
    @Bean
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }
}
```

#### 7.2 Application Properties Configuration

**application.yml:**

```yaml
spring:
  application:
    name: user-service
  
  datasource:
    url: jdbc:postgresql://localhost:5432/userdb
    username: ${DB_USERNAME:postgres}
    password: ${DB_PASSWORD:postgres}
    driver-class-name: org.postgresql.Driver
    hikari:
      maximum-pool-size: 10
      minimum-idle: 5
      connection-timeout: 30000
  
  jpa:
    hibernate:
      ddl-auto: validate
    show-sql: false
    properties:
      hibernate:
        dialect: org.hibernate.dialect.PostgreSQLDialect
        format_sql: true
  
  flyway:
    enabled: true
    locations: classpath:db/migration
  
  cache:
    type: redis
    redis:
      time-to-live: 600000
  
  redis:
    host: localhost
    port: 6379
  
server:
  port: 8080
  servlet:
    context-path: /api
  
logging:
  level:
    root: INFO
    com.example: DEBUG
  pattern:
    console: "%d{yyyy-MM-dd HH:mm:ss} - %msg%n"
  file:
    name: logs/application.log

management:
  endpoints:
    web:
      exposure:
        include: health,info,metrics,prometheus
  endpoint:
    health:
      show-details: always
```

#### 7.3 Exception Handling

**Global Exception Handler:**

```java
/**
 * Global Exception Handler
 */
@RestControllerAdvice
public class GlobalExceptionHandler {
    
    @ExceptionHandler(ResourceNotFoundException.class)
    public ResponseEntity<ErrorResponse> handleResourceNotFound(
            ResourceNotFoundException ex,
            WebRequest request) {
        ErrorResponse error = new ErrorResponse(
            HttpStatus.NOT_FOUND.value(),
            ex.getMessage(),
            LocalDateTime.now()
        );
        return new ResponseEntity<>(error, HttpStatus.NOT_FOUND);
    }
    
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ErrorResponse> handleValidationException(
            MethodArgumentNotValidException ex) {
        Map<String, String> errors = new HashMap<>();
        ex.getBindingResult().getFieldErrors().forEach(error ->
            errors.put(error.getField(), error.getDefaultMessage())
        );
        
        ErrorResponse error = new ErrorResponse(
            HttpStatus.BAD_REQUEST.value(),
            "Validation failed",
            LocalDateTime.now(),
            errors
        );
        return new ResponseEntity<>(error, HttpStatus.BAD_REQUEST);
    }
    
    @ExceptionHandler(Exception.class)
    public ResponseEntity<ErrorResponse> handleGlobalException(
            Exception ex,
            WebRequest request) {
        ErrorResponse error = new ErrorResponse(
            HttpStatus.INTERNAL_SERVER_ERROR.value(),
            "An error occurred",
            LocalDateTime.now()
        );
        return new ResponseEntity<>(error, HttpStatus.INTERNAL_SERVER_ERROR);
    }
}

/**
 * Custom Exception
 */
public class ResourceNotFoundException extends RuntimeException {
    public ResourceNotFoundException(String message) {
        super(message);
    }
}

/**
 * Error Response DTO
 */
@Data
@AllArgsConstructor
public class ErrorResponse {
    private int status;
    private String message;
    private LocalDateTime timestamp;
    private Map<String, String> errors;
    
    public ErrorResponse(int status, String message, LocalDateTime timestamp) {
        this.status = status;
        this.message = message;
        this.timestamp = timestamp;
    }
}
```

---

## Design Patterns

### 8. Common Design Patterns in Java/Spring

#### 8.1 Singleton Pattern

**Implementation:**

```java
/**
 * Thread-safe Singleton using enum (Best Practice)
 */
public enum DatabaseConnection {
    INSTANCE;
    
    private Connection connection;
    
    DatabaseConnection() {
        // Initialize connection
        this.connection = createConnection();
    }
    
    public Connection getConnection() {
        return connection;
    }
    
    private Connection createConnection() {
        // Create and return connection
        return null;
    }
}

/**
 * Double-Checked Locking Singleton
 */
public class ConfigurationManager {
    private static volatile ConfigurationManager instance;
    private Properties properties;
    
    private ConfigurationManager() {
        properties = new Properties();
        // Load properties
    }
    
    public static ConfigurationManager getInstance() {
        if (instance == null) {
            synchronized (ConfigurationManager.class) {
                if (instance == null) {
                    instance = new ConfigurationManager();
                }
            }
        }
        return instance;
    }
}

/**
 * Spring Singleton (Default)
 */
@Component
public class CacheManager {
    // Spring manages as singleton by default
}
```

#### 8.2 Factory Pattern

**Implementation:**

```java
/**
 * Factory Pattern
 */
public interface PaymentProcessor {
    void processPayment(double amount);
}

public class CreditCardProcessor implements PaymentProcessor {
    @Override
    public void processPayment(double amount) {
        System.out.println("Processing credit card payment: $" + amount);
    }
}

public class PayPalProcessor implements PaymentProcessor {
    @Override
    public void processPayment(double amount) {
        System.out.println("Processing PayPal payment: $" + amount);
    }
}

public class CryptoProcessor implements PaymentProcessor {
    @Override
    public void processPayment(double amount) {
        System.out.println("Processing crypto payment: $" + amount);
    }
}

/**
 * Factory
 */
public class PaymentProcessorFactory {
    public static PaymentProcessor createProcessor(String type) {
        switch (type.toUpperCase()) {
            case "CREDIT_CARD":
                return new CreditCardProcessor();
            case "PAYPAL":
                return new PayPalProcessor();
            case "CRYPTO":
                return new CryptoProcessor();
            default:
                throw new IllegalArgumentException("Unknown payment type: " + type);
        }
    }
}

/**
 * Spring Factory Pattern
 */
@Component
public class PaymentProcessorFactorySpring {
    
    private final Map<String, PaymentProcessor> processors;
    
    public PaymentProcessorFactorySpring(List<PaymentProcessor> processorList) {
        this.processors = processorList.stream()
            .collect(Collectors.toMap(
                p -> p.getClass().getSimpleName(),
                p -> p
            ));
    }
    
    public PaymentProcessor getProcessor(String type) {
        return processors.get(type);
    }
}
```

#### 8.3 Builder Pattern

**Implementation:**

```java
/**
 * Builder Pattern
 */
public class User {
    private final String firstName;
    private final String lastName;
    private final String email;
    private final String phone;
    private final String address;
    private final int age;
    
    private User(Builder builder) {
        this.firstName = builder.firstName;
        this.lastName = builder.lastName;
        this.email = builder.email;
        this.phone = builder.phone;
        this.address = builder.address;
        this.age = builder.age;
    }
    
    public static class Builder {
        private String firstName;
        private String lastName;
        private String email;
        private String phone;
        private String address;
        private int age;
        
        public Builder firstName(String firstName) {
            this.firstName = firstName;
            return this;
        }
        
        public Builder lastName(String lastName) {
            this.lastName = lastName;
            return this;
        }
        
        public Builder email(String email) {
            this.email = email;
            return this;
        }
        
        public Builder phone(String phone) {
            this.phone = phone;
            return this;
        }
        
        public Builder address(String address) {
            this.address = address;
            return this;
        }
        
        public Builder age(int age) {
            this.age = age;
            return this;
        }
        
        public User build() {
            // Validation
            if (firstName == null || lastName == null) {
                throw new IllegalStateException("First and last name required");
            }
            return new User(this);
        }
    }
    
    // Getters only (immutable)
}

// Usage
User user = new User.Builder()
    .firstName("John")
    .lastName("Doe")
    .email("john@example.com")
    .age(30)
    .build();

/**
 * Lombok Builder
 */
@Builder
@Data
public class Product {
    private Long id;
    private String name;
    private double price;
    private String category;
    private int stock;
}

// Usage
Product product = Product.builder()
    .name("Laptop")
    .price(999.99)
    .category("Electronics")
    .stock(50)
    .build();
```

#### 8.4 Strategy Pattern

**Implementation:**

```java
/**
 * Strategy Pattern
 */
public interface SortingStrategy {
    void sort(int[] array);
}

public class BubbleSort implements SortingStrategy {
    @Override
    public void sort(int[] array) {
        // Bubble sort implementation
        System.out.println("Sorting using Bubble Sort");
    }
}

public class QuickSort implements SortingStrategy {
    @Override
    public void sort(int[] array) {
        // Quick sort implementation
        System.out.println("Sorting using Quick Sort");
    }
}

public class MergeSort implements SortingStrategy {
    @Override
    public void sort(int[] array) {
        // Merge sort implementation
        System.out.println("Sorting using Merge Sort");
    }
}

/**
 * Context
 */
public class Sorter {
    private SortingStrategy strategy;
    
    public void setStrategy(SortingStrategy strategy) {
        this.strategy = strategy;
    }
    
    public void sort(int[] array) {
        strategy.sort(array);
    }
}

// Usage
Sorter sorter = new Sorter();
sorter.setStrategy(new QuickSort());
sorter.sort(array);

/**
 * Spring Strategy Pattern
 */
@Service
public class PaymentService {
    
    private final Map<String, PaymentStrategy> strategies;
    
    public PaymentService(List<PaymentStrategy> strategyList) {
        this.strategies = strategyList.stream()
            .collect(Collectors.toMap(
                PaymentStrategy::getType,
                Function.identity()
            ));
    }
    
    public void processPayment(String type, double amount) {
        PaymentStrategy strategy = strategies.get(type);
        if (strategy == null) {
            throw new IllegalArgumentException("Unknown payment type");
        }
        strategy.process(amount);
    }
}
```

#### 8.5 Observer Pattern

**Implementation:**

```java
/**
 * Observer Pattern
 */
public interface Observer {
    void update(String message);
}

public class EmailNotifier implements Observer {
    @Override
    public void update(String message) {
        System.out.println("Email notification: " + message);
    }
}

public class SMSNotifier implements Observer {
    @Override
    public void update(String message) {
        System.out.println("SMS notification: " + message);
    }
}

public class PushNotifier implements Observer {
    @Override
    public void update(String message) {
        System.out.println("Push notification: " + message);
    }
}

/**
 * Subject
 */
public class OrderSubject {
    private List<Observer> observers = new ArrayList<>();
    
    public void attach(Observer observer) {
        observers.add(observer);
    }
    
    public void detach(Observer observer) {
        observers.remove(observer);
    }
    
    public void notifyObservers(String message) {
        for (Observer observer : observers) {
            observer.update(message);
        }
    }
    
    public void placeOrder(String orderId) {
        System.out.println("Order placed: " + orderId);
        notifyObservers("Order " + orderId + " has been placed");
    }
}

/**
 * Spring Event-Driven (Observer Pattern)
 */
@Component
public class OrderEventPublisher {
    
    private final ApplicationEventPublisher eventPublisher;
    
    public OrderEventPublisher(ApplicationEventPublisher eventPublisher) {
        this.eventPublisher = eventPublisher;
    }
    
    public void publishOrderPlaced(Order order) {
        OrderPlacedEvent event = new OrderPlacedEvent(this, order);
        eventPublisher.publishEvent(event);
    }
}

public class OrderPlacedEvent extends ApplicationEvent {
    private final Order order;
    
    public OrderPlacedEvent(Object source, Order order) {
        super(source);
        this.order = order;
    }
    
    public Order getOrder() {
        return order;
    }
}

@Component
public class OrderEventListener {
    
    @EventListener
    public void handleOrderPlaced(OrderPlacedEvent event) {
        Order order = event.getOrder();
        System.out.println("Order placed: " + order.getId());
        // Send notifications, update inventory, etc.
    }
    
    @Async
    @EventListener
    public void sendEmailNotification(OrderPlacedEvent event) {
        // Send email asynchronously
    }
}
```

---

## Performance Optimization

### 9. Java & Spring Performance Best Practices

#### 9.1 Caching Strategies

**Spring Cache:**

```java
/**
 * Enable Caching
 */
@Configuration
@EnableCaching
public class CacheConfig {
    
    @Bean
    public CacheManager cacheManager() {
        SimpleCacheManager cacheManager = new SimpleCacheManager();
        cacheManager.setCaches(Arrays.asList(
            new ConcurrentMapCache("users"),
            new ConcurrentMapCache("products")
        ));
        return cacheManager;
    }
}

/**
 * Using Cache Annotations
 */
@Service
public class UserService {
    
    @Cacheable(value = "users", key = "#id")
    public User findById(Long id) {
        System.out.println("Fetching from database: " + id);
        return userRepository.findById(id).orElse(null);
    }
    
    @CachePut(value = "users", key = "#user.id")
    public User update(User user) {
        return userRepository.save(user);
    }
    
    @CacheEvict(value = "users", key = "#id")
    public void delete(Long id) {
        userRepository.deleteById(id);
    }
    
    @CacheEvict(value = "users", allEntries = true)
    public void clearCache() {
        System.out.println("Cache cleared");
    }
    
    @Cacheable(value = "users", condition = "#age > 18")
    public List<User> findByAge(int age) {
        return userRepository.findByAge(age);
    }
}
```

#### 9.2 Database Optimization

**N+1 Query Problem Solution:**

```java
/**
 * N+1 Problem
 */
@Entity
public class Department {
    @Id
    private Long id;
    private String name;
    
    @OneToMany(mappedBy = "department")
    private List<Employee> employees;
}

// Bad: N+1 queries
List<Department> departments = departmentRepository.findAll();
for (Department dept : departments) {
    dept.getEmployees().size(); // Triggers separate query for each department
}

/**
 * Solution 1: JOIN FETCH
 */
@Repository
public interface DepartmentRepository extends JpaRepository<Department, Long> {
    
    @Query("SELECT d FROM Department d JOIN FETCH d.employees")
    List<Department> findAllWithEmployees();
}

/**
 * Solution 2: Entity Graph
 */
@EntityGraph(attributePaths = {"employees"})
@Query("SELECT d FROM Department d")
List<Department> findAllWithEmployeesGraph();

/**
 * Solution 3: Batch Fetching
 */
@Entity
public class Department {
    @OneToMany(mappedBy = "department", fetch = FetchType.LAZY)
    @BatchSize(size = 10)
    private List<Employee> employees;
}
```

**Pagination:**

```java
/**
 * Efficient Pagination
 */
@RestController
@RequestMapping("/api/users")
public class UserController {
    
    @GetMapping
    public Page<UserDTO> getUsers(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size,
            @RequestParam(defaultValue = "id") String sortBy) {
        
        Pageable pageable = PageRequest.of(page, size, Sort.by(sortBy));
        return userService.findAll(pageable);
    }
}

@Service
public class UserService {
    
    public Page<UserDTO> findAll(Pageable pageable) {
        return userRepository.findAll(pageable)
            .map(user -> modelMapper.map(user, UserDTO.class));
    }
}
```

#### 9.3 Async Processing

**Async Methods:**

```java
/**
 * Enable Async
 */
@Configuration
@EnableAsync
public class AsyncConfig {
    
    @Bean(name = "taskExecutor")
    public Executor taskExecutor() {
        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
        executor.setCorePoolSize(5);
        executor.setMaxPoolSize(10);
        executor.setQueueCapacity(100);
        executor.setThreadNamePrefix("async-");
        executor.initialize();
        return executor;
    }
}

/**
 * Async Service
 */
@Service
public class NotificationService {
    
    @Async("taskExecutor")
    public CompletableFuture<String> sendEmail(String to, String subject) {
        try {
            Thread.sleep(2000); // Simulate email sending
            String result = "Email sent to " + to;
            return CompletableFuture.completedFuture(result);
        } catch (InterruptedException e) {
            return CompletableFuture.failedFuture(e);
        }
    }
    
    @Async
    public void sendSMS(String phone, String message) {
        // Send SMS asynchronously
        System.out.println("SMS sent to " + phone);
    }
}

/**
 * Using Async Methods
 */
@Service
public class OrderService {
    
    private final NotificationService notificationService;
    
    public void processOrder(Order order) {
        // Save order
        orderRepository.save(order);
        
        // Send notifications asynchronously
        CompletableFuture<String> emailFuture = 
            notificationService.sendEmail(order.getEmail(), "Order Confirmation");
        
        notificationService.sendSMS(order.getPhone(), "Order placed");
        
        // Wait for email if needed
        emailFuture.thenAccept(result -> 
            System.out.println("Email result: " + result)
        );
    }
}
```

---

## Summary & Best Practices

### Key Takeaways

**Java Core:**
- Master OOP principles and apply them consistently
- Understand Collections internals for optimal performance
- Use appropriate concurrency mechanisms
- Monitor and optimize JVM memory usage

**Java 8+:**
- Leverage Streams for cleaner, more maintainable code
- Use Optional to avoid NullPointerException
- Apply functional programming concepts appropriately
- Utilize method references for concise code

**Spring Framework:**
- Prefer constructor injection for better testability
- Use appropriate bean scopes
- Implement proper exception handling
- Leverage Spring Boot auto-configuration

**Performance:**
- Implement caching strategically
- Optimize database queries (avoid N+1)
- Use async processing for I/O operations
- Monitor application metrics

**Design Patterns:**
- Apply patterns to solve specific problems
- Don't over-engineer solutions
- Use Spring's built-in pattern implementations
- Keep code maintainable and testable

---

## Additional Resources

### Recommended Reading
- Effective Java by Joshua Bloch
- Spring in Action by Craig Walls
- Java Concurrency in Practice by Brian Goetz
- Clean Code by Robert C. Martin

### Online Resources
- Spring Boot Documentation
- Baeldung Java Tutorials
- Java Documentation (Oracle)
- Spring Guides

---

**End of Comprehensive Java & Spring Boot Interview Guide**

This guide covers the essential topics for Principal-level Java Full Stack & Cloud Engineer interviews. Practice these concepts, understand the underlying principles, and be prepared to discuss real-world applications and trade-offs.

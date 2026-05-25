ChatGPT


This is a copy of a shared ChatGPT conversation

Report conversation

Top 100 Java Coding Interview Questions & Answers
Java Technical Lead / Senior Developer Coding Preparation Guide
This guide includes:

Core Java coding problems

Collections

Strings

Arrays

Multithreading

Java 8 Streams

Algorithms

HashMap

Concurrency

Design-focused coding

1. Reverse a String
Problem
Reverse a string without using built-in reverse.

Code
public class ReverseString {
    public static void main(String[] args) {
        String str = "JAVA";
        String reversed = "";

        for (int i = str.length() - 1; i >= 0; i--) {
            reversed += str.charAt(i);
        }

        System.out.println(reversed);
    }
}
Output
AVAJ
Complexity
Time: O(n)

Space: O(n)

2. Reverse String using StringBuilder
String reversed = new StringBuilder("JAVA").reverse().toString();
3. Check Palindrome String
public class Palindrome {
    public static void main(String[] args) {
        String str = "madam";

        String reversed = new StringBuilder(str).reverse().toString();

        if (str.equals(reversed)) {
            System.out.println("Palindrome");
        } else {
            System.out.println("Not Palindrome");
        }
    }
}
4. Find Duplicate Characters in String
import java.util.*;

public class DuplicateChars {
    public static void main(String[] args) {
        String str = "programming";

        Map<Character, Integer> map = new HashMap<>();

        for(char ch : str.toCharArray()) {
            map.put(ch, map.getOrDefault(ch, 0) + 1);
        }

        for(Map.Entry<Character, Integer> entry : map.entrySet()) {
            if(entry.getValue() > 1) {
                System.out.println(entry.getKey());
            }
        }
    }
}
5. Count Character Occurrences
String str = "banana";

Map<Character, Integer> map = new HashMap<>();

for(char ch : str.toCharArray()) {
    map.put(ch, map.getOrDefault(ch, 0) + 1);
}

System.out.println(map);
6. Swap Two Numbers without Third Variable
int a = 10;
int b = 20;

a = a + b;
b = a - b;
a = a - b;

System.out.println(a + " " + b);
7. Find Largest Number in Array
int[] arr = {10, 20, 5, 90, 45};

int max = arr[0];

for(int num : arr) {
    if(num > max) {
        max = num;
    }
}

System.out.println(max);
8. Find Second Largest Number
int[] arr = {10, 20, 50, 40};

int first = Integer.MIN_VALUE;
int second = Integer.MIN_VALUE;

for(int num : arr) {
    if(num > first) {
        second = first;
        first = num;
    } else if(num > second && num != first) {
        second = num;
    }
}

System.out.println(second);
9. Sort Array
Arrays.sort(arr);
10. Bubble Sort
for(int i=0;i<arr.length;i++) {
    for(int j=0;j<arr.length-i-1;j++) {
        if(arr[j] > arr[j+1]) {
            int temp = arr[j];
            arr[j] = arr[j+1];
            arr[j+1] = temp;
        }
    }
}
11. Binary Search
int[] arr = {10,20,30,40,50};

int key = 30;

int low = 0;
int high = arr.length - 1;

while(low <= high) {
    int mid = (low + high)/2;

    if(arr[mid] == key) {
        System.out.println("Found");
        break;
    } else if(arr[mid] < key) {
        low = mid + 1;
    } else {
        high = mid - 1;
    }
}
12. Find Missing Number in Array
int[] arr = {1,2,3,5};

int n = 5;

int expected = n*(n+1)/2;

int actual = 0;

for(int num : arr) {
    actual += num;
}

System.out.println(expected - actual);
13. Remove Duplicates from Array
int[] arr = {1,2,2,3,4,4};

Set<Integer> set = new LinkedHashSet<>();

for(int num : arr) {
    set.add(num);
}

System.out.println(set);
14. Find Frequency of Elements
Map<Integer,Integer> map = new HashMap<>();

for(int num : arr) {
    map.put(num, map.getOrDefault(num,0)+1);
}
15. Fibonacci Series
int a = 0;
int b = 1;

for(int i=0;i<10;i++) {
    System.out.print(a + " ");

    int c = a + b;
    a = b;
    b = c;
}
16. Prime Number Check
int n = 17;
boolean prime = true;

for(int i=2;i<=Math.sqrt(n);i++) {
    if(n%i == 0) {
        prime = false;
        break;
    }
}

System.out.println(prime);
17. Factorial using Recursion
public static int factorial(int n) {
    if(n == 1) return 1;

    return n * factorial(n-1);
}
18. Anagram Check
String s1 = "listen";
String s2 = "silent";

char[] a = s1.toCharArray();
char[] b = s2.toCharArray();

Arrays.sort(a);
Arrays.sort(b);

System.out.println(Arrays.equals(a,b));
19. Find First Non-Repeated Character
String str = "swiss";

Map<Character,Integer> map = new LinkedHashMap<>();

for(char ch : str.toCharArray()) {
    map.put(ch,map.getOrDefault(ch,0)+1);
}

for(Map.Entry<Character,Integer> entry : map.entrySet()) {
    if(entry.getValue() == 1) {
        System.out.println(entry.getKey());
        break;
    }
}
20. Reverse Array
int[] arr = {1,2,3,4};

for(int i=arr.length-1;i>=0;i--) {
    System.out.print(arr[i] + " ");
}
21. Check Armstrong Number
int n = 153;
int sum = 0;
int temp = n;

while(temp > 0) {
    int digit = temp % 10;
    sum += digit * digit * digit;
    temp /= 10;
}

System.out.println(sum == n);
22. Find GCD
int a = 24;
int b = 18;

while(b != 0) {
    int temp = b;
    b = a % b;
    a = temp;
}

System.out.println(a);
23. Find LCM
int lcm = (a*b)/gcd;
24. Check Even/Odd
System.out.println(n % 2 == 0 ? "Even" : "Odd");
25. Count Words in String
String str = "Java is powerful";

String[] words = str.split(" ");

System.out.println(words.length);
26. Remove White Spaces
str = str.replaceAll("\\s","");
27. Reverse Words in Sentence
String str = "Java is awesome";

String[] words = str.split(" ");

for(int i=words.length-1;i>=0;i--) {
    System.out.print(words[i] + " ");
}
28. Sort HashMap by Value
map.entrySet()
   .stream()
   .sorted(Map.Entry.comparingByValue())
   .forEach(System.out::println);
29. Find Max Occurring Character
char maxChar = ' ';
int max = 0;

for(Map.Entry<Character,Integer> entry : map.entrySet()) {
    if(entry.getValue() > max) {
        max = entry.getValue();
        maxChar = entry.getKey();
    }
}
30. Check Leap Year
if((year % 400 == 0) || 
   (year % 4 == 0 && year % 100 != 0))
31. Find Duplicate Elements in Array
Set<Integer> set = new HashSet<>();

for(int num : arr) {
    if(!set.add(num)) {
        System.out.println(num);
    }
}
32. Merge Two Arrays
int[] merged = IntStream
    .concat(Arrays.stream(arr1), Arrays.stream(arr2))
    .toArray();
33. Find Intersection of Arrays
Set<Integer> set1 = new HashSet<>();
Set<Integer> result = new HashSet<>();

for(int num : arr1) set1.add(num);

for(int num : arr2) {
    if(set1.contains(num)) {
        result.add(num);
    }
}
34. Rotate Array
int k = 2;

Collections.rotate(Arrays.asList(arr), k);
35. Find Sum of Digits
while(n > 0) {
    sum += n % 10;
    n /= 10;
}
36. Convert String to Integer
int num = Integer.parseInt("123");
37. Convert Integer to String
String str = String.valueOf(123);
38. Remove Duplicate Characters
String str = "programming";

StringBuilder sb = new StringBuilder();

Set<Character> set = new HashSet<>();

for(char ch : str.toCharArray()) {
    if(set.add(ch)) {
        sb.append(ch);
    }
}
39. Longest Substring without Repeating Characters
Sliding Window Concept
abcabcbb

Window moves dynamically
Set<Character> set = new HashSet<>();

int left = 0;
int max = 0;

for(int right=0; right<str.length(); right++) {

    while(set.contains(str.charAt(right))) {
        set.remove(str.charAt(left++));
    }

    set.add(str.charAt(right));

    max = Math.max(max, right-left+1);
}
40. Two Sum Problem
Map<Integer,Integer> map = new HashMap<>();

for(int i=0;i<arr.length;i++) {
    int complement = target - arr[i];

    if(map.containsKey(complement)) {
        System.out.println(map.get(complement) + "," + i);
    }

    map.put(arr[i],i);
}
41. Thread Creation
class MyThread extends Thread {
    public void run() {
        System.out.println("Thread running");
    }
}
42. Runnable Example
Runnable r = () -> System.out.println("Runnable");
new Thread(r).start();
43. Synchronization Example
public synchronized void increment() {
    count++;
}
44. Deadlock Example
Thread-1 -> Lock A -> Waiting B
Thread-2 -> Lock B -> Waiting A
45. Producer Consumer Problem
BlockingQueue<Integer> queue = new ArrayBlockingQueue<>(10);
46. ExecutorService Example
ExecutorService service = Executors.newFixedThreadPool(5);

service.submit(() -> {
    System.out.println("Task");
});
47. Callable Example
Callable<Integer> c = () -> 100;
48. CompletableFuture Example
CompletableFuture.supplyAsync(() -> "Hello")
    .thenApply(String::toUpperCase)
    .thenAccept(System.out::println);
49. Stream Filter Example
list.stream()
    .filter(x -> x > 10)
    .forEach(System.out::println);
50. Stream Map Example
list.stream()
    .map(String::toUpperCase)
    .collect(Collectors.toList());
51. Group By using Streams
Map<String,List<Employee>> grouped =
employees.stream()
.collect(Collectors.groupingBy(Employee::getDept));
52. Count using Streams
long count = list.stream()
    .filter(x -> x > 10)
    .count();
53. Find Duplicate Elements using Streams
Set<Integer> set = new HashSet<>();

list.stream()
    .filter(n -> !set.add(n))
    .forEach(System.out::println);
54. Sort Objects
employees.sort(Comparator.comparing(Employee::getSalary));
55. Find Highest Salary
employees.stream()
.max(Comparator.comparing(Employee::getSalary));
56. FlatMap Example
list.stream()
    .flatMap(Collection::stream)
57. Parallel Stream
list.parallelStream()
58. Optional Example
Optional.ofNullable(name)
    .orElse("Default");
59. Singleton Design Pattern
class Singleton {

    private static final Singleton INSTANCE =
        new Singleton();

    private Singleton(){}

    public static Singleton getInstance() {
        return INSTANCE;
    }
}
60. Factory Pattern
Client
  |
Factory
  |
Concrete Objects
61. Builder Pattern
User user = User.builder()
    .name("Venu")
    .age(30)
    .build();
62. Immutable Class
final class Employee {
    private final int id;
}
63. Custom Exception
class InvalidAgeException extends Exception {
    public InvalidAgeException(String msg) {
        super(msg);
    }
}
64. File Reading
Files.readAllLines(Paths.get("test.txt"));
65. Serialization
ObjectOutputStream out =
 new ObjectOutputStream(new FileOutputStream("a.txt"));
66. JDBC Connection
Connection con =
DriverManager.getConnection(url,user,password);
67. PreparedStatement
PreparedStatement ps =
con.prepareStatement("select * from emp where id=?");
68. Binary Tree Traversal
       10
      /  \
     5   20
Inorder:

left -> root -> right
69. BFS Traversal
Queue<Node> queue = new LinkedList<>();
70. DFS Traversal
Stack<Node> stack = new Stack<>();
71. Detect Cycle in LinkedList
Using Floyd cycle algorithm.

Slow pointer
Fast pointer
72. Reverse LinkedList
Node prev = null;
73. Stack using Array
int[] stack = new int[10];
74. Queue using Array
int[] queue = new int[10];
75. LRU Cache Concept
HashMap + Doubly LinkedList
76. Thread-safe Singleton
private static volatile Singleton instance;
77. Double Checked Locking
if(instance == null)
78. Custom Comparator
Comparator<Employee> c =
(a,b) -> a.getSalary() - b.getSalary();
79. Reverse Number
while(n>0) {
    rev = rev*10 + n%10;
}
80. Find Vowels
if("AEIOUaeiou".indexOf(ch)!=-1)
81. Count Lines in File
Files.lines(Paths.get("a.txt")).count();
82. Read Large File Efficiently
BufferedReader br
83. Top K Elements
Using PriorityQueue.

84. Kth Largest Element
PriorityQueue<Integer> pq = new PriorityQueue<>();
85. Merge Sort
Divide
Merge
Sort
86. Quick Sort
Pivot
Partition
Recursion
87. Heap Sort
Using binary heap.

88. Detect Duplicate using XOR
xor ^= num;
89. Power of Two Check
(n & (n-1)) == 0
90. Bit Manipulation Swap
a ^= b;
b ^= a;
a ^= b;
91. Longest Common Prefix
Arrays.sort(arr);
92. Roman to Integer
Using HashMap.

93. Valid Parentheses
Using Stack.

94. Sliding Window Maximum
Using Deque.

95. Rate Limiter Design
Client
 |
API Gateway
 |
Token Bucket
96. Thread-safe Counter
AtomicInteger counter =
 new AtomicInteger();
97. Custom Annotation
@interface MyAnnotation {}
98. Reflection Example
Class.forName("Employee");
99. Memory Optimization Techniques
Answer
Use primitives

Avoid object creation

StringBuilder

Caching

Streams carefully

GC tuning

100. Design URL Shortener
Client
 |
API
 |
Hash Generator
 |
Database
 |
Cache
Key concepts:

Base62 encoding

Cache

DB indexing

Scalability

Expiration

Strong Technical Lead Coding Interview Closing Statement
“For senior Java interviews, coding alone is not enough. Interviewers expect clean code, optimized complexity, thread safety, scalability thinking, design patterns, concurrency handling, memory optimization, and production-ready engineering practices.”


For senior Java interviews, coding alone is not enough. Interviewers expect clean code, optimized complexity, thread safety, scalability thinking, design patterns, concurrency handling, memory optimization, and production-ready engineering practices.

Exactly. For a Senior Java Developer / Technical Lead interview, companies usually evaluate you across 7 major dimensions, not just coding.

Senior Java Interview Evaluation Areas
                Senior Java Engineer
                         |
 ---------------------------------------------------------
 |            |            |            |                |
Coding     System      Concurrency   Performance     Leadership
Skills      Design       & JVM         & Scale        & Delivery
                         |
                  Production Engineering
1. Clean Code Expectations
Interviewers expect:

Bad Code
public void p(List<Employee> l){
 for(Employee e:l){
  if(e.getSalary()>10000){
   System.out.println(e.getName());
  }
 }
}
Problems:

Poor naming

No readability

No abstraction

Hard to maintain

Good Code
public void printHighSalaryEmployees(List<Employee> employees) {

    employees.stream()
            .filter(employee -> employee.getSalary() > 10000)
            .map(Employee::getName)
            .forEach(System.out::println);
}
Why this is better:

Meaningful naming

Readable

Maintainable

Functional style

Easier testing

2. Time Complexity Optimization
Interviewers expect you to discuss:

O(1)
O(log n)
O(n)
O(n log n)
O(n²)
Example
Bad Approach
Nested loops:

for(int i=0;i<n;i++) {
   for(int j=0;j<n;j++) {
   }
}
Complexity:

O(n²)
Optimized Approach
Using HashMap:

Map<Integer,Integer> map = new HashMap<>();
Complexity:

O(n)
3. Thread Safety & Concurrency
Senior engineers are expected to understand:

Race conditions

Deadlocks

Synchronization

Locking

Thread pools

Async processing

Parallelism

Race Condition Example
Thread-1 --> count++
Thread-2 --> count++
Possible incorrect result due to concurrent updates.

Thread-Safe Solution
AtomicInteger counter = new AtomicInteger();

counter.incrementAndGet();
4. JVM & Memory Optimization
Interviewers expect JVM understanding.

Application
    |
 JVM
    |
 ------------------------
 | Heap                 |
 | Stack                |
 | Metaspace            |
 ------------------------
Key areas:

GC tuning

Heap sizing

Memory leaks

Thread dumps

CPU profiling

Common Senior-Level Question
“How do you debug high CPU in production?”
Expected answer:

1. Check metrics
2. Capture thread dump
3. Identify hot threads
4. Analyze stack traces
5. Review loops/contention
6. Optimize bottleneck
5. Production-Ready Engineering
Senior engineers must think beyond code.

Interviewers expect:

Logging

Monitoring

Observability

Security

Retry handling

Resilience

Scalability

Failure recovery

Example: Production-Ready API
Client
  |
API Gateway
  |
Microservice
  |
Database
  |
Observability + Retry + Cache + Metrics
6. Scalability Thinking
Interviewers evaluate architecture maturity.

Weak Answer
“Application works.”

Strong Senior Answer
“The service is stateless, horizontally scalable, cache-enabled, supports async event processing using Kafka, and has observability through Prometheus and Grafana.”

7. Design Patterns Knowledge
Senior engineers are expected to apply patterns correctly.

Commonly Asked Patterns
Singleton
Factory
Builder
Strategy
Observer
Adapter
Decorator
Proxy
Circuit Breaker
Saga
Example: Builder Pattern
User user = User.builder()
        .name("Venu")
        .age(34)
        .build();
Why interviewers like this:

Immutable objects

Readability

Cleaner construction

8. API & Microservices Thinking
Senior interviews heavily focus on distributed systems.

Expected knowledge:

REST standards

Idempotency

Retry handling

Circuit breakers

Rate limiting

API Gateway

Kafka

Event-driven systems

Example Architecture
Client
   |
API Gateway
   |
------------------------
| User Service         |
| Payment Service      |
| Notification Service |
------------------------
         |
       Kafka
9. Database Optimization
Expected topics:

Indexing

Query optimization

Pagination

Connection pooling

Transactions

Isolation levels

Weak Answer
“I use JPA repository.”

Strong Senior Answer
“I avoid N+1 queries using fetch joins, optimize indexes based on query patterns, and use pagination for large datasets.”

10. Observability & Monitoring
Modern senior interviews expect production monitoring knowledge.

Expected Tools
Grafana

Prometheus

Kibana

Splunk

OpenTelemetry

Datadog

Dynatrace

11. Leadership Evaluation
Technical Leads are evaluated on:

Architecture ownership
Mentoring
Code reviews
Release handling
Incident management
Stakeholder communication
Production support
Strong Technical Lead Answer
“I usually drive end-to-end delivery including architecture discussions, production deployment planning, observability setup, code reviews, mentoring offshore teams, and coordinating with business and infrastructure stakeholders.”

12. What Senior Interviewers Secretly Evaluate
They Observe:
1. Problem-solving maturity
Can you break down large problems?

2. Tradeoff thinking
Can you explain WHY?

3. Communication clarity
Can you explain architecture simply?

4. Production awareness
Have you handled real incidents?

5. Scalability mindset
Will your solution work at enterprise scale?

13. Senior-Level Coding Expectations
Interviewers expect:

Correctness
+
Optimization
+
Clean design
+
Thread safety
+
Scalability
+
Maintainability
Example Senior-Level Improvement
Junior Solution
List<Employee> result = new ArrayList<>();

for(Employee e : employees){
   if(e.getSalary() > 10000){
      result.add(e);
   }
}
Senior-Level Solution
List<Employee> highSalaryEmployees = employees.stream()
        .filter(employee -> employee.getSalary() > 10000)
        .sorted(Comparator.comparing(Employee::getSalary).reversed())
        .limit(10)
        .toList();
Discussion points:

Readability

Scalability

Functional programming

Sorting complexity

Stream optimization

14. Most Important Senior Interview Areas
Must Master
Core Java
Collections

Streams

Multithreading

JVM

Memory

Concurrency

Spring Boot
Security

JPA

Transactions

Batch

Kafka

Microservices

DevOps
Docker

Kubernetes

CI/CD

Jenkins

OpenShift

Cloud
AWS

Azure

Architecture
Distributed systems

Event-driven architecture

Caching

Scalability

Production Support
RCA

Monitoring

Performance tuning

15. Final Senior Interview Formula
Coding
 + Architecture
 + JVM
 + Concurrency
 + Scalability
 + Observability
 + Leadership
 + Communication
 = Senior Technical Lead
Strong Closing Statement for Interviews
“As a Senior Java Technical Lead, I focus not only on writing optimized and maintainable code, but also on designing scalable, resilient, observable, and production-ready enterprise systems while mentoring teams and driving end-to-end technical delivery.”


As a Senior Java Technical Lead, I focus not only on writing optimized and maintainable code, but also on designing scalable, resilient, observable, and production-ready enterprise systems while mentoring teams and driving end-to-end technical delivery.”

That is already a strong statement. Here are several upgraded versions you can use depending on the situation.

1. Strong Technical Lead Version (Recommended)
“As a Senior Java Technical Lead, I specialize in designing and delivering scalable, resilient, cloud-native, and production-ready enterprise applications. My expertise spans Java, Spring Boot, microservices, distributed systems, cloud platforms, DevOps, observability, and performance engineering. Beyond coding, I focus on architecture design, production reliability, mentoring engineering teams, stakeholder collaboration, and driving end-to-end technical delivery across the software development lifecycle.”

2. Architect-Level Version
“As a Senior Java Technical Lead, I focus on architecting highly scalable, event-driven, and cloud-native enterprise platforms with strong emphasis on performance, resiliency, observability, and operational excellence. I drive technical strategy, microservices architecture, DevOps automation, distributed system design, and production stability while mentoring teams and collaborating with business and engineering stakeholders to deliver enterprise-scale solutions.”

3. Client-Facing US Interview Version
“I am a Senior Java Technical Lead with strong experience in building enterprise-scale distributed applications using Java, Spring Boot, microservices, Kafka, Kubernetes, and cloud technologies. My responsibilities include solution architecture, system scalability, performance optimization, CI/CD implementation, observability setup, production support, and mentoring offshore and nearshore teams while ensuring successful end-to-end delivery.”

4. Banking/Financial Domain Version
“As a Senior Java Technical Lead in banking and financial services, I design secure, scalable, and high-availability enterprise systems capable of handling mission-critical workloads. I focus on microservices architecture, event-driven systems, observability, resiliency, compliance, and production engineering while leading development teams and collaborating closely with architects, product owners, and business stakeholders.”

5. Short Powerful LinkedIn / Resume Summary
“Senior Java Technical Lead specializing in scalable microservices, cloud-native architectures, distributed systems, DevOps, observability, and production engineering with strong expertise in end-to-end enterprise solution delivery.”

6. Very Strong FAANG-Style Version
“I focus on building highly scalable, fault-tolerant, observable, and performance-optimized distributed systems using modern Java and cloud-native technologies. My experience includes architecture design, concurrency optimization, event-driven systems, Kubernetes-based deployments, CI/CD automation, JVM tuning, and leading cross-functional engineering teams to deliver resilient enterprise platforms.”

7. Strong Technical Leadership Keywords
Use these keywords naturally in interviews:

Scalability
Resiliency
Observability
Performance Optimization
Distributed Systems
Cloud-Native
Event-Driven Architecture
Production Engineering
Fault Tolerance
High Availability
CI/CD
DevOps
Kubernetes
Kafka
Microservices
JVM Tuning
Mentoring
Stakeholder Management
Technical Ownership
8. Best 60-Second Self Introduction Version
“I’m a Senior Java Technical Lead with strong experience designing and delivering enterprise-scale cloud-native applications using Java, Spring Boot, microservices, Kafka, Kubernetes, and distributed system architectures. Over the years, I’ve worked extensively on scalable backend systems, production engineering, observability, DevOps automation, and performance optimization. In addition to hands-on development, I actively drive architecture discussions, mentor engineering teams, support production releases, and collaborate with architects, product owners, and business stakeholders to ensure successful end-to-end delivery.”

9. Advanced Architecture-Focused Version
Clients
   |
API Gateway
   |
Microservices Layer
   |
Kafka/Event Streaming
   |
Caching Layer
   |
Databases
   |
Observability Stack
   |
CI/CD + Kubernetes + Cloud
Strong statement:

“My engineering approach focuses on building scalable and loosely coupled distributed systems using event-driven architecture, resilient APIs, asynchronous communication, caching strategies, observability tooling, and cloud-native deployment models.”

10. Strong Final Closing Line
“I believe senior engineering is not just about writing code — it’s about building reliable systems, enabling teams, improving engineering practices, and ensuring long-term scalability, maintainability, and operational excellence.”



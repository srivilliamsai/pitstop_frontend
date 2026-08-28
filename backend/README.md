# ⚙️ PitStop Backend

> **Microservices-based Backend for On-Demand Roadside Assistance & Fuel Delivery Platform**

-----

## 🚀 Overview

**PitStop Backend** is a **Java Spring Boot microservices architecture** designed to power the PitStop mobile app — a futuristic platform offering **real-time roadside assistance, fuel delivery, emergency help, BNPL (Buy-Now-Pay-Later) payments, and intelligent analytics**.

Each microservice is modular, independently deployable, and communicates securely through REST and Feign clients via an API Gateway. The backend ensures **scalability, fault tolerance, and high availability** using the **Spring Cloud Netflix Stack**.

-----

## 🧱 Core Features

  - 🧩 **Microservices Architecture**
      - Fully decoupled domain-based services (User, Order, Payment, BNPL, etc.)
  - 🛰 **Spring Cloud Integration**
      - Eureka Discovery Server
      - Config Server
      - API Gateway (Routing + Load Balancing)
  - 🧾 **RESTful API Design**
      - Clean controller-service-repo structure with DTOs
      - Unified JSON responses and exception handling
  - 🔐 **Secure Authentication**
      - JWT-based user authentication and role-based authorization
  - ⚡ **Asynchronous Communication**
      - Feign clients for inter-service calls
      - RabbitMQ or internal REST integration (optional)
  - 📊 **Analytics & Monitoring**
      - Analytics service for logs, metrics, and usage tracking
  - 🧠 **BNPL Integration**
      - Split payments and deferred payment logic for fuel or services
  - 📨 **Notification Service**
      - Email/SMS/Push event triggers for orders and emergencies
  - 🧰 **Swagger Documentation**
      - Auto-generated API docs per service at `/swagger-ui.html`

-----

## 🗂️ Folder Structure

```
pitstop-backend/
│
├── config-server/            # Centralized config management
│   └── src/main/resources/
│       └── application.yml
│
├── discovery-server/         # Eureka service registry
│   └── src/main/resources/
│       └── application.yml
│
├── api-gateway/              # API routing and authentication entrypoint
│   └── src/main/resources/
│       └── application.yml
│
├── common-lib/               # Shared DTOs and utility classes
│   └── src/main/java/com/pitstop/common/
│
├── user-service/             # Handles user accounts, profiles, JWT
│   ├── controller/
│   ├── service/
│   ├── repository/
│   ├── entity/
│   ├── dto/
│   └── application.yml
│
├── order-service/            # Manages fuel orders, requests, tracking
│   ├── controller/
│   ├── service/
│   ├── repository/
│   ├── feign/
│   ├── entity/
│   ├── dto/
│   └── application.yml
│
├── payment-service/          # Handles transactions, BNPL, gateways
├── bnpl-service/             # Deferred billing logic
├── mechanic-service/         # Mechanic and service provider registry
├── emergency-service/        # Emergency call and dispatch
├── notification-service/     # Notification management
├── analytics-service/        # Data logs, metrics, usage analytics
│
├── pom.xml                   # Parent Maven config
└── README.md
```

-----

## 🧰 Tech Stack

| Layer | Technology | Description |
|:------|:------------|:-------------|
| **Language** | Java 8  | Modern, type-safe JVM language |
| **Framework** | Spring Boot 2.7.x | Microservice foundation |
| **Cloud Tools** | Spring Cloud Netflix | Eureka, Gateway, Config |
| **Build Tool** | Maven 3.9.x | Multi-module dependency management |
| **Security** | Spring Security + JWT | Authentication & Authorization |
| **Database** | MySQL 8 | Persistent data store |
| **API Docs** | Swagger / OpenAPI | Auto API documentation |
| **Testing** | JUnit 5 + Mockito | Unit and integration tests |
| **CI/CD** | GitHub Actions / Docker | Automated build & deploy |
| **Monitoring** | Spring Actuator | Service health endpoints |

-----

## 🌐 Microservice List

| Service | Port | Description |
|:----------|:------|:-------------|
| **Config Server** | 8888 | Central configuration management |
| **Discovery Server (Eureka)** | 8761 | Service registry |
| **API Gateway** | 8080 | Unified routing and authentication layer |
| **User Service** | 8081 | Manages user authentication and profiles |
| **Order Service** | 8082 | Handles orders, requests, and tracking |
| **Payment Service** | 8083 | Processes transactions |
| **BNPL Service** | 8084 | Manages deferred payments |
| **Mechanic Service** | 8085 | Mechanic and workshop data |
| **Emergency Service** | 8086 | Emergency dispatch and assistance |
| **Notification Service** | 8087 | Email/SMS/push notifications |
| **Analytics Service** | 8088 | Logging and analytics |

-----

## ⚙️ Configuration Management

### 🔧 `config-server`

Holds all shared configurations in one repository:

```yaml
spring:
  cloud:
    config:
      server:
        git:
          uri: https://github.com/srivilliamsai/pitstop-config-repo
```

Each service connects to it:

```yaml
spring:
  config:
    import: optional:configserver:http://localhost:8888
```

-----

## 🔐 Authentication (JWT)

  - **Login** → Generates a JWT token
  - **Token** → Attached to all service requests via headers
  - **Gateway** validates token → routes request only if valid
  - Role-based authorization for admin, mechanic, and user

Example Header:

```
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6...
```

-----

## 📡 Inter-Service Communication

Services communicate using **OpenFeign Clients**:

```java
@FeignClient(name = "payment-service")
public interface PaymentClient {
    @PostMapping("/payments/process")
    PaymentResponse processPayment(@RequestBody PaymentRequest request);
}
```

-----

## 🧪 Testing Setup

Each service includes:

  - ✅ Unit tests with **JUnit 5**
  - 🔁 Mocked dependencies using **Mockito**
  - 📊 Code coverage with **JaCoCo**

Example:

```
src/test/java/com/pitstop/user/service/UserServiceTest.java
```

-----

## 🧠 Swagger Documentation

Available per service at:
`http://localhost:<port>/swagger-ui.html`

**Example:**

  - User Service → `http://localhost:8081/swagger-ui.html`
  - Order Service → `http://localhost:8082/swagger-ui.html`

-----

## 🚀 Running the Project

### Step 1 — Build Parent

```bash
mvn clean install -DskipTests
```

### Step 2 — Start Config & Discovery

(In separate terminals)

```bash
cd config-server
mvn spring-boot:run
```

```bash
cd ../discovery-server
mvn spring-boot:run
```

### Step 3 — Start All Services

(In separate terminals)

```bash
cd ../api-gateway
mvn spring-boot:run
```

```bash
# Start other services
mvn spring-boot:run -pl user-service
mvn spring-boot:run -pl order-service
mvn spring-boot:run -pl payment-service
# ... and so on for all other services
```

-----

## 🧩 API Example

**`POST /orders/create`**

Request:

```json
{
  "userId": "U001",
  "serviceType": "Fuel Delivery",
  "location": "Anna Salai, Chennai",
  "paymentMode": "BNPL"
}
```

Response:

```json
{
  "orderId": "O12345",
  "status": "CONFIRMED",
  "eta": "15 mins"
}
```

-----

## 📦 Deployment

### 🐳 Docker Setup

Each service has a `Dockerfile`:

```bash
docker build -t pitstop-user-service .
docker run -p 8081:8081 pitstop-user-service
```

### ☁️ Cloud Deployment

  - Oracle Cloud Infrastructure / AWS ECS / Render
  - Use `docker-compose.yml` or Kubernetes YAML for orchestration

-----

## 🧠 Future Enhancements

  - 🔋 **Service Mesh** (Istio / Linkerd)
  - 📊 **Centralized ELK** logging stack
  - 🔐 **OAuth2** + Refresh Token flow
  - 🧠 **AI-driven** emergency prediction model integration
  - 🚗 Integration with vehicle **telematics APIs**

-----

## 👨‍💻 Author

**Sri Villiam Sai Ayyappan** B.Tech (Information Technology) | SRM Valliammai Engineering College  
📍 Chennai, India  
🔗 [LinkedIn](https://www.linkedin.com/in/srivilliamsai/)
🔗 [GitHub](https://github.com/srivilliamsai)

-----

## 🏁 License

This project is licensed under the **MIT License** — see the `LICENSE` file for details.

> “Powering safer journeys through intelligent service architecture — PitStop Backend.” ⚙️

# Personal Finance Tracker 💰 (Spring Boot + JSP)

A Personal Finance Tracker web application that helps users manage their money in a simple and organized way.  
Users can register, login, add income/expense transactions, view transaction history, calculate balance dynamically, and set a monthly budget to control spending.

---

## 📌 Features

### ✅ Authentication (Session Based)
- User Registration
- User Login
- User Logout
- Dashboard Access only after login (session validation)

### ✅ Transactions
- Add Transaction (CREDITED / DEBITED)
- View Transaction History (latest first)
- Edit Transaction
- Delete Transaction
- Balance Calculation (Dynamic)

### ✅ Budget (Monthly)
- Set / Update Monthly Budget (Per User)
- Monthly Spending Calculation
- Warning if monthly spending exceeds budget (Allowed to add transactions)

---

## 🧱 Tech Stack

### Backend
- Java
- Spring Boot
- Spring MVC
- Spring Data JPA (Hibernate)
- JSP + JSTL

### Database
- Oracle Database

### Tools
- Maven
- Git + GitHub
- Eclipse / IntelliJ
- SQL Developer

---

## 🏗️ Project Architecture



---

## 🗃️ Database Design

### 1) USERS Table
| Column | Type | Description |
|--------|------|-------------|
| id | number | Primary Key |
| name | varchar | User name |
| email | varchar | Unique |
| password | varchar | Encrypted/Plain (as per implementation) |

---

### 2) TRANSACTIONS Table
| Column | Type | Description |
|--------|------|-------------|
| id | number | Primary Key |
| amount | number | Transaction amount |
| type | varchar | CREDITED / DEBITED |
| category | varchar | Category name |
| description | varchar | Optional |
| transactionDateTime | timestamp | Date & time |
| user_id | number | Foreign Key |

---

### 3) BUDGETS Table
| Column | Type | Description |
|--------|------|-------------|
| id | number | Primary Key |
| budgetMonth | number | 1–12 |
| budgetYear | number | Example: 2026 |
| amount | number | Monthly budget amount |
| user_id | number | Foreign Key |

✅ Unique Constraint:

---

## ⚙️ Important Logic

### Dynamic Balance Calculation
This project **does NOT store balance** in database.

Balance is calculated dynamically:


This ensures:
- No mismatch in balance
- No extra update logic required

---

## 🖥️ Screens / Pages

- `home.jsp`
- `register.jsp`
- `login.jsp`
- `dashboard.jsp`
- `addTransaction.jsp`
- `transactionHistory.jsp`
- `editTransaction.jsp`
- `budget.jsp`

---

## 🔗 Main Endpoints

### Home
- `GET /`

### Auth
- `GET /user/register`
- `POST /user/register`
- `GET /user/login`
- `POST /user/login`
- `GET /user/logout`

### Dashboard
- `GET /user/dashboard`

### Transactions
- `GET /transactions/add`
- `POST /transactions/save`
- `GET /transactions/history`
- `GET /transactions/edit/{id}`
- `POST /transactions/update`
- `GET /transactions/delete/{id}`

### Budget
- `GET /budget`
- `POST /budget/save`

---

## 🚀 How to Run the Project

### 1️⃣ Clone the Repository
```bash
git clone <your-repo-url>
cd personal-finance-tracker


### Set your application.properties
spring.datasource.url=jdbc:oracle:thin:@localhost:1521:xe
spring.datasource.username=YOUR_USERNAME
spring.datasource.password=YOUR_PASSWORD

spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.OracleDialect


That's all run your app now!


This project follows **Layered Architecture**:


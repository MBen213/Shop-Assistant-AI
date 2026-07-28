# API Specification

| Field | Value |
|-------|-------|
| Project | Shop Assistant AI |
| Version | 1.0.0 |
| Status | Future |
| Protocol | REST API |
| Data Format | JSON |

---

# Purpose

This document defines the future REST API endpoints that will enable synchronization between the mobile application and cloud services.

The first release (v1.0) works completely offline using SQLite.

The API described here will be implemented in future versions without requiring major changes to the application architecture.

---

# Authentication

Future authentication methods:

- JWT Access Token
- Refresh Token

---

# Base URL

Example:

https://api.shopassistant.ai/v1/

---

# Response Format

Success

```json
{
  "success": true,
  "message": "Operation completed successfully.",
  "data": {}
}
```

Error

```json
{
  "success": false,
  "message": "Validation failed.",
  "errors": []
}
```

---

# Planned Endpoints

Authentication

POST /auth/login

POST /auth/logout

POST /auth/refresh

---

Products

GET /products

GET /products/{id}

POST /products

PUT /products/{id}

DELETE /products/{id}

---

Categories

GET /categories

POST /categories

PUT /categories/{id}

DELETE /categories/{id}

---

Sales

GET /sales

POST /sales

GET /sales/{id}

---

Purchases

GET /purchases

POST /purchases

---

Customers

GET /customers

POST /customers

PUT /customers/{id}

DELETE /customers/{id}

---

Suppliers

GET /suppliers

POST /suppliers

PUT /suppliers/{id}

DELETE /suppliers/{id}

---

Expenses

GET /expenses

POST /expenses

---

Reports

GET /reports/daily

GET /reports/monthly

GET /reports/profit

GET /reports/inventory

---

Synchronization

POST /sync/upload

GET /sync/download

GET /sync/status
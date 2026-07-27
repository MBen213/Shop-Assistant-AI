# Software Requirements Specification (SRS)

| Field | Value |
|-------|-------|
| Project | Shop Assistant AI |
| Version | 1.0.0 |
| Status | Draft |
| Author | Mohamed Ben |
| Last Updated | 2026-07-27 |

---

# 1. Introduction

## 1.1 Purpose

This document defines the functional and non-functional requirements of Shop Assistant AI.

It serves as the primary technical reference for software development, testing, and future maintenance.

---

## 1.2 Scope

Shop Assistant AI is a mobile application designed to help small and medium-sized businesses manage their daily operations.

The application provides features for:

- Product Management
- Sales Management
- Purchase Management
- Inventory Tracking
- Customer Management
- Supplier Management
- Expense Tracking
- Reporting
- Business Analytics
- Offline Data Storage

---

## 1.3 Intended Users

The application is intended for:

- Shop Owners
- Employees

---

# 2. User Roles

## Owner

Permissions:

- Full access
- Manage users
- View reports
- Manage products
- Manage suppliers
- Manage customers
- View profits
- Backup & Restore

---

## Employee

Permissions:

- Create sales
- Search products
- View inventory
- Print invoices

Restrictions:

- Cannot delete data
- Cannot access reports
- Cannot change settings

---

# 3. System Overview

The application consists of the following modules:

- Authentication
- Dashboard
- Products
- Categories
- Sales
- Purchases
- Inventory
- Customers
- Suppliers
- Expenses
- Reports
- Notifications
- Settings
- AI Assistant (Future Version)

---

# 4. Functional Requirements

## Authentication

The system shall allow users to:

- Login securely
- Logout
- Change password
- Recover account (future version)

---

## Dashboard

The dashboard shall display:

- Today's Sales
- Monthly Revenue
- Monthly Expenses
- Net Profit
- Low Stock Products
- Recent Transactions

---

## Products

The system shall allow users to:

- Add Product
- Edit Product
- Delete Product (Owner only)
- Search Product
- Filter Products
- Manage Categories
- Generate Barcode (Future)

---

## Sales

The system shall allow users to:

- Create Sale
- Edit Sale
- Cancel Sale
- Print Invoice
- View Sales History

---

## Purchases

The system shall allow users to:

- Create Purchase
- Manage Suppliers
- Update Inventory Automatically

---

## Inventory

The system shall:

- Track Stock Quantity
- Alert Low Stock
- Record Inventory Movement
- Support Stock Adjustment

---

## Customers

Users shall be able to:

- Add Customer
- Edit Customer
- View Purchase History
- Manage Customer Debts

---

## Suppliers

Users shall be able to:

- Add Supplier
- Edit Supplier
- View Purchase History
- Record Supplier Payments

---

## Expenses

The application shall:

- Record Expenses
- Categorize Expenses
- Generate Expense Reports

---

## Reports

The application shall generate:

- Daily Report
- Weekly Report
- Monthly Report
- Profit Report
- Expense Report
- Inventory Report
- Best Selling Products

---

## Backup

The application shall support:

- Local Backup
- Restore Backup
- Export Database
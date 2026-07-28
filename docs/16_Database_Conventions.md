# Database Conventions

| Field | Value |
|-------|-------|
| Project | Shop Assistant AI |
| Database | SQLite |
| Version | 1.0.0 |
| Status | Approved |
| Author | Mohamed Ben |

---

# Purpose

This document defines the database standards and conventions used throughout the project.

All database tables, relationships, constraints, and migrations must follow these conventions.

---

# 1. Naming Convention

## Tables

- Use PascalCase.
- Table names must be plural.

Examples:

- Users
- Products
- Categories
- Sales
- Sale_Items
- Purchase_Items
- Inventory_Movements

---

## Columns

Use snake_case.

Examples

- full_name
- created_at
- updated_by
- purchase_price
- selling_price

---

## Primary Keys

Every table must contain:

| Column | Type |
|---------|------|
| id | TEXT (UUID) |

---

## Foreign Keys

Always end with `_id`.

Examples

- user_id
- role_id
- product_id
- category_id
- supplier_id

---

# 2. UUID Policy

Every primary key uses UUID.

Example

```
550e8400-e29b-41d4-a716-446655440000
```

Advantages

- Globally unique
- Safe for synchronization
- Better for future cloud support
- Prevents predictable IDs

---

# 3. Audit Fields

Every master data table must contain:

| Column |
|---------|
| created_at |
| created_by |
| updated_at |
| updated_by |

Purpose

- Track data history
- Improve accountability
- Simplify debugging

---

# 4. Soft Delete Policy

The application uses Soft Delete.

Every master table must include:

| Column |
|---------|
| is_active |
| deleted_at |
| deleted_by |

Rules

- Records are never permanently deleted.
- Deleted records remain available for reports.
- Deleted records are hidden from normal users.
- Authorized users may restore deleted records.

---

# 5. Transaction Tables

The following tables are immutable.

- Sales
- Sale_Items
- Purchases
- Purchase_Items
- Inventory_Movements
- Payments

Rules

- Never delete.
- Never modify historical values.
- Use status changes or adjustment records instead.

---

# 6. Date & Time

All timestamps are stored using ISO-8601.

Example

```
2026-07-27T18:35:42Z
```

---

# 7. Boolean Values

SQLite stores booleans as INTEGER.

| Value | Meaning |
|--------|---------|
| 1 | True |
| 0 | False |

---

# 8. Monetary Values

All prices use REAL.

Examples

- purchase_price
- selling_price
- discount
- tax
- subtotal
- total

Rules

- Never store formatted currency.
- Currency formatting is handled by the UI.

---

# 9. Quantity Values

Quantity fields use REAL.

Examples

- 1
- 2
- 0.5
- 1.250

Allows support for:

- Pieces
- Kilograms
- Liters
- Services

---

# 10. Image Storage

Images are never stored inside the database.

Only store:

```
image_path
```

Example

```
products/coca-cola.png
```

---

# 11. Constraints

Every table should define:

- Primary Key
- Foreign Keys
- NOT NULL
- UNIQUE
- CHECK constraints whenever possible

---

# 12. Indexes

Create indexes for:

- Foreign Keys
- Frequently searched columns
- Invoice numbers
- Product SKU
- Barcode
- Username
- Customer Code

---

# 13. Business Rules

Business rules belong to the application layer.

Examples

✔ Prevent selling inactive products

✔ Prevent deleting referenced categories

✔ Prevent negative stock

Database constraints are only used to protect data integrity.

---

# 14. Transactions

Critical operations must execute inside a database transaction.

Examples

Creating a sale:

1. Create Sale
2. Create Sale Items
3. Update Inventory
4. Create Inventory Movements
5. Save Payment

If one step fails,

Everything rolls back.

---

# 15. Migration Rules

Database schema changes must use migrations.

Rules

- Never edit production tables manually.
- Every schema change increments the database version.
- Migrations must preserve existing data.

---

# 16. Security

Passwords are never stored in plain text.

Only password hashes are stored.

Sensitive information must never be logged.

---

# 17. Documentation Rules

Every new table must include:

- Purpose
- Columns
- Relationships
- Business Rules
- Indexes

This ensures the schema remains self-documented.

---

# 18. Future Scalability

The database design supports future features including:

- Multi-store support
- Barcode scanners
- Receipt printers
- Offline-first synchronization
- Cloud synchronization
- AI analytics
- Dashboard reporting
- REST API
- Web Admin Panel

---

# Approval

This document defines the official database conventions for Shop Assistant AI.

All future database changes must comply with these standards.
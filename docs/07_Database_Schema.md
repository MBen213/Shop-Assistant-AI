# Database Schema

| Field | Value |
|-------|-------|
| Project | Shop Assistant AI |
| Database | SQLite |
| Version | 1.0.0 |
| Status | Draft |
| Author | Mohamed Ben |

---

# Table: Roles

## Purpose

Defines the permissions assigned to application users.

### Columns

| Column | Type | Constraints |
|---------|------|------------|
| id | TEXT | PRIMARY KEY |
| name | TEXT | UNIQUE, NOT NULL |
| description | TEXT | NULL |
| created_at | TEXT | NOT NULL |
| updated_at | TEXT | NOT NULL |

### Initial Data

| Role |
|------|
| Owner |
| Employee |

---

# Table: Users

## Purpose

Stores application users.

### Columns

| Column | Type | Constraints |
|---------|------|------------|
| id | TEXT | PRIMARY KEY |
| role_id | TEXT | FOREIGN KEY |
| full_name | TEXT | NOT NULL |
| username | TEXT | UNIQUE, NOT NULL |
| password_hash | TEXT | NOT NULL |
| phone | TEXT | NULL |
| email | TEXT | NULL |
| is_active | INTEGER | DEFAULT 1 |
| created_at | TEXT | NOT NULL |
| updated_at | TEXT | NOT NULL |

### Relationships

- role_id → Roles.id

### Notes

- Passwords are stored as hashes.
- Usernames must be unique.
- Every user must have exactly one role.

---

# Table: Categories

## Purpose

Stores product categories used to organize products across different business types.

Examples:

- Beverages
- Dairy
- Electronics
- Clothing
- Books
- Office Supplies

---

## Columns

| Column | Type | Constraints | Description |
|----------|----------|----------------|------------------------------|
| id | TEXT | PRIMARY KEY | UUID |
| code | TEXT | UNIQUE, NOT NULL | Business Category Code |
| name | TEXT | NOT NULL | Category Name |
| description | TEXT | NULL | Optional Description |
| icon | TEXT | NULL | Icon Identifier |
| color | TEXT | NULL | UI Color |
| is_active | INTEGER | DEFAULT 1 | Active Status |
| created_at | TEXT | NOT NULL | Creation Date |
| updated_at | TEXT | NOT NULL | Last Update |

---

## Relationships

One Category

↓

Many Products

Category.id → Products.category_id

---

## Business Rules

- Category names should be unique.
- Categories cannot be deleted if products belong to them.
- Inactive categories cannot be assigned to new products.
- Categories can be archived instead of deleted.

---

## Indexes

- code
- name
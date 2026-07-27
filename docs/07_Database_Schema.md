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
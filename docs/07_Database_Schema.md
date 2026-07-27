# Database Schema

| Field | Value |
|-------|-------|
| Project | Shop Assistant AI |
| Database | SQLite |
| Version | 1.0.0 |
| Status | Draft |

---

# Users

| Column | Type | Constraints |
|---------|------|------------|
| id | TEXT | PRIMARY KEY |
| role_id | TEXT | NOT NULL |
| full_name | TEXT | NOT NULL |
| username | TEXT | UNIQUE |
| password_hash | TEXT | NOT NULL |
| phone | TEXT | NULL |
| email | TEXT | NULL |
| is_active | INTEGER | DEFAULT 1 |
| created_at | TEXT | NOT NULL |
| updated_at | TEXT | NOT NULL |
# Coding Standards

| Field | Value |
|-------|-------|
| Project | Shop Assistant AI |
| Version | 1.0.0 |
| Status | Active |

---

# 1. General Principles

- Write clean and readable code.
- Follow SOLID principles.
- Keep functions small and focused.
- Avoid duplicated code.
- Prefer composition over inheritance.

---

# 2. Naming Conventions

## Classes

Use PascalCase.

Example:

ProductRepository

InventoryService

---

## Variables

Use camelCase.

Example:

productName

totalPrice

createdAt

---

## Files

Use snake_case.

Example:

product_repository.dart

inventory_service.dart

---

# 3. Folder Structure

Organize code by feature.

Example:

features/
    products/
    sales/
    inventory/
    expenses/

---

# 4. Documentation

Every public class and method should include documentation comments.

---

# 5. Error Handling

- Never ignore exceptions.
- Display user-friendly error messages.
- Log unexpected errors.

---

# 6. Git Commit Convention

Examples:

feat:
Add new feature

fix:
Fix a bug

docs:
Update documentation

refactor:
Improve code structure

test:
Add or update tests

style:
Formatting changes

chore:
Maintenance tasks

---

# 7. Code Review Checklist

Before every commit:

- Code compiles successfully.
- No unused imports.
- No duplicated code.
- Naming is consistent.
- Documentation updated if needed.

---

# 8. Testing

Every important business logic should have unit tests.

---

# 9. Security

- Never store passwords as plain text.
- Validate all user inputs.
- Use parameterized database queries.

---

# 10. Performance

- Avoid unnecessary database queries.
- Cache data when appropriate.
- Keep UI responsive.
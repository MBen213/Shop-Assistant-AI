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

---

# Table: Products

## Purpose

Stores all products and services offered by the business.

The table supports both physical products and services, making the application suitable for different business types.

Examples:

- Coca Cola
- Laptop
- Notebook
- Phone Repair
- Color Printing

---

## Columns

| Column | Type | Constraints | Description |
|----------|----------|----------------|------------------------------|
| id | TEXT | PRIMARY KEY | UUID |
| sku | TEXT | UNIQUE, NOT NULL | Internal Product Code |
| barcode | TEXT | UNIQUE | Barcode (optional) |
| name | TEXT | NOT NULL | Product or Service Name |
| description | TEXT | NULL | Product Description |
| item_type | TEXT | NOT NULL | Product or Service |
| category_id | TEXT | FOREIGN KEY | Category Reference |
| brand_id | TEXT | FOREIGN KEY, NULL | Brand Reference |
| unit_id | TEXT | FOREIGN KEY, NULL | Unit Reference |
| purchase_price | REAL | DEFAULT 0 | Purchase Cost |
| selling_price | REAL | NOT NULL | Selling Price |
| minimum_stock | REAL | DEFAULT 0 | Low Stock Alert Threshold |
| image_path | TEXT | NULL | Product Image |
| notes | TEXT | NULL | Internal Notes |
| is_active | INTEGER | DEFAULT 1 | Active Status |
| created_at | TEXT | NOT NULL | Creation Date |
| updated_at | TEXT | NOT NULL | Last Update |

---

## Relationships

Category

Category.id → Products.category_id

Brand

Brand.id → Products.brand_id

Unit

Unit.id → Products.unit_id

---

## Business Rules

- SKU must be unique.
- Barcode must be unique if provided.
- Product name cannot be empty.
- Selling price cannot be negative.
- Purchase price cannot be negative.
- Services ignore stock calculations.
- Inactive products cannot be sold.
- Products are archived instead of permanently deleted.

---

## Indexes

- sku
- barcode
- name
- category_id

---

# Table: Customers

## Purpose

Stores customer information.

Customers may purchase products or services and may have outstanding balances.

---

## Columns

| Column | Type | Constraints | Description |
|----------|----------|----------------|------------------------------|
| id | TEXT | PRIMARY KEY | UUID |
| code | TEXT | UNIQUE, NOT NULL | Customer Code |
| full_name | TEXT | NOT NULL | Customer Name |
| phone | TEXT | NULL | Phone Number |
| email | TEXT | NULL | Email Address |
| address | TEXT | NULL | Address |
| notes | TEXT | NULL | Internal Notes |
| is_active | INTEGER | DEFAULT 1 | Active Status |
| created_at | TEXT | NOT NULL | Creation Date |
| updated_at | TEXT | NOT NULL | Last Update |

---

## Relationships

Customer.id → Sales.customer_id

---

## Business Rules

- Customer code must be unique.
- Customer name cannot be empty.
- Customers with sales history cannot be permanently deleted.
- Customers can be archived instead of deleted.

---

## Indexes

- code
- full_name
- phone

---

# Table: Suppliers

## Purpose

Stores supplier information.

Suppliers provide products purchased by the business.

---

## Columns

| Column | Type | Constraints | Description |
|----------|----------|----------------|------------------------------|
| id | TEXT | PRIMARY KEY | UUID |
| code | TEXT | UNIQUE, NOT NULL | Supplier Code |
| company_name | TEXT | NOT NULL | Supplier Name |
| contact_person | TEXT | NULL | Contact Person |
| phone | TEXT | NULL | Phone Number |
| email | TEXT | NULL | Email Address |
| address | TEXT | NULL | Address |
| notes | TEXT | NULL | Internal Notes |
| is_active | INTEGER | DEFAULT 1 | Active Status |
| created_at | TEXT | NOT NULL | Creation Date |
| updated_at | TEXT | NOT NULL | Last Update |

---

## Relationships

Supplier.id → Purchases.supplier_id

---

## Business Rules

- Supplier code must be unique.
- Supplier name cannot be empty.
- Suppliers with purchase history cannot be deleted.

---

## Indexes

- code
- company_name
- phone

---

# Table: Units

## Purpose

Defines measurement units used by products.

Examples:

- Piece
- Kg
- Gram
- Liter
- Bottle
- Box
- Pack
- Meter
- Service

---

## Columns

| Column | Type | Constraints | Description |
|----------|----------|----------------|------------------------------|
| id | TEXT | PRIMARY KEY | UUID |
| code | TEXT | UNIQUE, NOT NULL | Unit Code |
| name | TEXT | NOT NULL | Unit Name |
| symbol | TEXT | NULL | Display Symbol |
| is_active | INTEGER | DEFAULT 1 | Active Status |
| created_at | TEXT | NOT NULL | Creation Date |
| updated_at | TEXT | NOT NULL | Last Update |

---

## Relationships

Unit.id → Products.unit_id

---

## Business Rules

- Unit names must be unique.
- Units already assigned to products cannot be deleted.

---

## Indexes

- code
- name

---

# Table: Permissions

## Purpose

Defines every permission available in the system.

Permissions are assigned to roles, not directly to users.

---

## Columns

| Column | Type | Constraints | Description |
|---------|------|-------------|-------------|
| id | TEXT | PRIMARY KEY | UUID |
| code | TEXT | UNIQUE, NOT NULL | Permission Code |
| name | TEXT | NOT NULL | Permission Name |
| module | TEXT | NOT NULL | Related Module |
| description | TEXT | NULL | Description |
| created_at | TEXT | NOT NULL | Creation Date |

---

## Examples

PRODUCT_VIEW

PRODUCT_CREATE

PRODUCT_UPDATE

PRODUCT_DELETE

SALE_CREATE

SALE_CANCEL

PURCHASE_CREATE

REPORT_VIEW

SETTINGS_UPDATE

USER_MANAGEMENT

---

# Table: Role_Permissions

## Purpose

Defines which permissions belong to each role.

---

## Columns

| Column | Type | Constraints |
|---------|------|------------|
| role_id | TEXT | FOREIGN KEY |
| permission_id | TEXT | FOREIGN KEY |

---

## Composite Primary Key

(role_id, permission_id)

---

# Table: Sales

## Purpose

Stores sales invoices generated by the business.

Each sale can contain one or more products or services.

---

## Columns

| Column | Type | Constraints | Description |
|---------|------|-------------|-------------|
| id | TEXT | PRIMARY KEY | UUID |
| invoice_number | TEXT | UNIQUE, NOT NULL | Invoice Number |
| customer_id | TEXT | FOREIGN KEY, NULL | Customer Reference |
| user_id | TEXT | FOREIGN KEY | Employee who created the sale |
| shift_id | TEXT | FOREIGN KEY | Work Shift |
| subtotal | REAL | NOT NULL | Total Before Discount |
| discount | REAL | DEFAULT 0 | Discount Amount |
| tax | REAL | DEFAULT 0 | Tax Amount |
| total | REAL | NOT NULL | Final Total |
| payment_status | TEXT | NOT NULL | Paid / Partial / Unpaid |
| payment_method | TEXT | NOT NULL | Cash / Card / Transfer |
| notes | TEXT | NULL | Notes |
| status | TEXT | DEFAULT 'Completed' | Completed / Cancelled / Refunded |
| created_at | TEXT | NOT NULL | Creation Date |
| updated_at | TEXT | NOT NULL | Last Update |

---

## Relationships

customer_id → Customers.id

user_id → Users.id

shift_id → Shifts.id

---

## Business Rules

- Invoice number must be unique.
- Total cannot be negative.
- Cancelled invoices must restore inventory.
- Completed invoices reduce inventory.
- Customer is optional.
- Every sale must have one employee.

---

## Indexes

- invoice_number
- customer_id
- user_id
- created_at

---

# Table: Sale_Items

## Purpose

Stores all products or services included in a sales invoice.

Each record represents one line inside a sale.

Product information is stored as a snapshot to preserve historical accuracy.

---

## Columns

| Column | Type | Constraints | Description |
|---------|------|-------------|-------------|
| id | TEXT | PRIMARY KEY | UUID |
| sale_id | TEXT | FOREIGN KEY | Sale Reference |
| product_id | TEXT | FOREIGN KEY | Product Reference |
| sku | TEXT | NOT NULL | Product SKU at Sale Time |
| product_name | TEXT | NOT NULL | Product Name at Sale Time |
| barcode | TEXT | NULL | Product Barcode at Sale Time |
| unit_name | TEXT | NULL | Unit Name at Sale Time |
| quantity | REAL | NOT NULL | Sold Quantity |
| unit_price | REAL | NOT NULL | Selling Price at Sale Time |
| discount | REAL | DEFAULT 0 | Line Discount |
| tax | REAL | DEFAULT 0 | Line Tax |
| line_total | REAL | NOT NULL | Final Line Total |
| created_at | TEXT | NOT NULL | Creation Date |

---

## Relationships

sale_id → Sales.id

product_id → Products.id

---

## Business Rules

- Quantity must be greater than zero.
- Unit price cannot be negative.
- Product snapshot must not change after the sale.
- Line total is calculated from quantity, price, discount, and tax.

---

## Formula

line_total = (quantity × unit_price) - discount + tax

---

## Indexes

- sale_id
- product_id
- sku

---

# Table: Inventory_Movements

## Purpose

Tracks every inventory movement in the system.

Stock is calculated from these movements instead of being stored directly in the Products table.

---

## Columns

| Column | Type | Constraints | Description |
|---------|------|-------------|-------------|
| id | TEXT | PRIMARY KEY | UUID |
| product_id | TEXT | FOREIGN KEY | Product Reference |
| movement_type | TEXT | NOT NULL | Type of Movement |
| reference_type | TEXT | NOT NULL | Source Document |
| reference_id | TEXT | NOT NULL | Related Document ID |
| quantity | REAL | NOT NULL | Quantity Changed |
| unit_cost | REAL | DEFAULT 0 | Cost Per Unit |
| notes | TEXT | NULL | Notes |
| created_by | TEXT | FOREIGN KEY | User Reference |
| created_at | TEXT | NOT NULL | Creation Date |

---

## Relationships

product_id → Products.id

created_by → Users.id

reference_id →

- Sales.id
- Purchases.id
- Adjustments.id
- Returns.id

---

## Movement Types

PURCHASE_IN

SALE_OUT

SALE_RETURN

PURCHASE_RETURN

STOCK_ADJUSTMENT

DAMAGE

LOSS

INITIAL_STOCK

TRANSFER_IN

TRANSFER_OUT

---

## Business Rules

- Quantity cannot be zero.
- Every movement must have a source.
- Stock is calculated from all movements.
- Movements cannot be edited after creation.
- Corrections must be done using adjustment movements.

---

## Indexes

- product_id
- movement_type
- created_at

# Global Data Integrity Rules

## Soft Delete Policy

The application uses Soft Delete instead of permanent deletion.

Every master data table should contain:

- is_active
- deleted_at
- deleted_by

Deleted records:

- are hidden from normal users.
- remain available for historical reports.
- preserve database relationships.
- can be restored by authorized users.

Permanent deletion is only allowed for development, database maintenance, or records that have never been referenced by another table.

---

# Table: Brands

## Purpose

Stores product brands.

Examples:

- Samsung
- Apple
- Dell
- HP
- Coca-Cola

---

## Columns

| Column | Type | Constraints | Description |
|---------|------|-------------|-------------|
| id | TEXT | PRIMARY KEY | UUID |
| code | TEXT | UNIQUE, NOT NULL | Brand Code |
| name | TEXT | UNIQUE, NOT NULL | Brand Name |
| description | TEXT | NULL | Description |
| logo_path | TEXT | NULL | Brand Logo |
| is_active | INTEGER | DEFAULT 1 | Active Status |
| deleted_at | TEXT | NULL | Soft Delete Timestamp |
| deleted_by | TEXT | FOREIGN KEY, NULL | User who deleted |
| created_at | TEXT | NOT NULL | Creation Date |
| created_by | TEXT | FOREIGN KEY | User who created |
| updated_at | TEXT | NOT NULL | Last Update |
| updated_by | TEXT | FOREIGN KEY | User who updated |

---

## Relationships

Products.brand_id → Brands.id

---

## Business Rules

- Brand names must be unique.
- Brands linked to products cannot be permanently deleted.
- Soft Delete is used.
- Inactive brands cannot be assigned to new products.

---

## Indexes

- code
- name

---

# Table: Purchases

## Purpose

Stores purchase invoices from suppliers.

Purchases increase inventory and update product costs.

---

## Columns

| Column | Type | Constraints | Description |
|---------|------|-------------|-------------|
| id | TEXT | PRIMARY KEY | UUID |
| invoice_number | TEXT | UNIQUE, NOT NULL | Purchase Invoice Number |
| supplier_id | TEXT | FOREIGN KEY | Supplier Reference |
| user_id | TEXT | FOREIGN KEY | Employee who created the purchase |
| subtotal | REAL | NOT NULL | Total Before Discount |
| discount | REAL | DEFAULT 0 | Discount Amount |
| tax | REAL | DEFAULT 0 | Tax Amount |
| total | REAL | NOT NULL | Final Total |
| payment_status | TEXT | NOT NULL | Paid / Partial / Unpaid |
| payment_method | TEXT | NOT NULL | Cash / Card / Transfer |
| notes | TEXT | NULL | Internal Notes |
| status | TEXT | DEFAULT 'Completed' | Completed / Cancelled |
| created_at | TEXT | NOT NULL | Creation Timestamp |
| created_by | TEXT | FOREIGN KEY | User who created |
| updated_at | TEXT | NOT NULL | Last Update |
| updated_by | TEXT | FOREIGN KEY | User who updated |

---

## Relationships

supplier_id → Suppliers.id

user_id → Users.id

created_by → Users.id

updated_by → Users.id

---

## Business Rules

- Invoice number must be unique.
- Supplier is required.
- Total cannot be negative.
- Completed purchases increase inventory.
- Cancelled purchases reverse inventory movements.
- Purchases cannot be permanently deleted.

---

## Indexes

- invoice_number
- supplier_id
- created_at
- user_id

---

# Table: Purchase_Items

## Purpose

Stores all products included in a purchase invoice.

Each record represents one purchased product or service.

Product information is stored as a snapshot to preserve historical accuracy.

---

## Columns

| Column | Type | Constraints | Description |
|---------|------|-------------|-------------|
| id | TEXT | PRIMARY KEY | UUID |
| purchase_id | TEXT | FOREIGN KEY | Purchase Reference |
| product_id | TEXT | FOREIGN KEY | Product Reference |
| sku | TEXT | NOT NULL | Product SKU at Purchase Time |
| product_name | TEXT | NOT NULL | Product Name at Purchase Time |
| barcode | TEXT | NULL | Product Barcode |
| unit_name | TEXT | NULL | Unit Name |
| quantity | REAL | NOT NULL | Purchased Quantity |
| unit_cost | REAL | NOT NULL | Purchase Cost Per Unit |
| discount | REAL | DEFAULT 0 | Line Discount |
| tax | REAL | DEFAULT 0 | Line Tax |
| line_total | REAL | NOT NULL | Final Line Total |
| created_at | TEXT | NOT NULL | Creation Timestamp |

---

## Relationships

purchase_id → Purchases.id

product_id → Products.id

---

## Business Rules

- Quantity must be greater than zero.
- Unit cost cannot be negative.
- Product snapshot must never change.
- Line total is calculated automatically.

---

## Formula

line_total = (quantity × unit_cost) - discount + tax

---

## Indexes

- purchase_id
- product_id
- sku


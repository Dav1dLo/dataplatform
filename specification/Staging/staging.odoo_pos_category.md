# odoo_pos_category

## Source system
This table originates from Odoo ERP, specifically the Point of Sale (POS) module. The naming convention (`odoo_pos_category`) and the presence of Odoo-specific audit columns like `create_uid`, `write_uid`, and `JSONB` name fields are characteristic of Odoo's PostgreSQL schema.

## Functional process 
This table supports the Point of Sale product categorization process. It manages the hierarchical structure of product categories used to organize items on the POS interface, allowing for nested categories via the `parent_id` relationship.

## Description
One row represents a single product category within the Odoo Point of Sale system. This is a raw landed staging table containing the structural definition of categories, including their display sequence, color coding, and localized names.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated ID from Odoo. |
| parent_id | INTEGER | true | Self-referencing foreign key | Points to the parent category ID for hierarchy. |
| sequence | INTEGER | true | Display order | Used to sort categories in the POS UI. |
| color | INTEGER | true | UI color index | Integer representing the color assigned to the category. |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the user who last updated the record. |
| name | JSONB | false | Category name | Multilingual name stored as a JSON object. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `parent_id` → `staging.odoo_pos_category.id`: Represents the parent-child relationship within the category tree.
    - `create_uid` → `staging.odoo_res_users.id` (guess): Likely links to the users table.
    - `write_uid` → `staging.odoo_res_users.id` (guess): Likely links to the users table.
- **Natural keys (inferred):** Not confidently inferable. Odoo often relies on the surrogate `id` for internal references.

## Caveats for downstream consumers

- **Sensitive Data:** No PII or financial data present.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo PostgreSQL deployments.
- **Data Structure:** The `name` column is `JSONB`; downstream consumers must parse this (e.g., `name->>'en_US'`) to extract human-readable strings.
- **Soft Deletes:** This table does not appear to implement a `deleted` flag; records are likely hard-deleted in the source system.
- **Hierarchy:** Queries traversing the category tree will require recursive CTEs due to the `parent_id` structure.
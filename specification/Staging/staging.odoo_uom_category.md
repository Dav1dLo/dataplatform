# odoo_uom_category

## Source system
This table originates from Odoo ERP. The naming convention `odoo_uom_category` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of the Odoo `uom.category` model, which manages units of measure groupings.

## Functional process 
This table supports the product management and inventory configuration process. It defines categories for units of measure (e.g., "Weight", "Length", "Units"), allowing the system to enforce conversion rules between units within the same category during procurement, sales, and inventory movements.

## Description
One row represents a single unit of measure category defined within the Odoo system. This is a raw landing table in the Staging layer, providing a direct, un-transformed copy of the Odoo `uom_category` database table.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; maps to Odoo internal ID. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the user who last updated the record. |
| name | JSONB | false | Category name | Multi-language string stored as JSONB. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the Odoo ORM. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the Odoo ORM. |
| is_pos_groupable | BOOLEAN | true | POS grouping flag | Indicates if items in this category can be grouped in the Point of Sale. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit pattern for record creation).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit pattern for record modification).
- **Natural keys (inferred):** 
    - `name` (Note: While Odoo uses `id` as the primary key, the `name` field is typically unique within the business context of UoM categories).

## Caveats for downstream consumers

- **PII/Sensitive Data:** None identified; contains system configuration data.
- **Timezone:** Timestamps (`create_date`, `write_date`) are typically stored in UTC by Odoo; verify against your specific Odoo instance configuration.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume standard Odoo behavior where records are physically deleted or remain active.
- **JSONB Handling:** The `name` column is `JSONB`. Downstream consumers will need to extract the relevant language key (e.g., `name->>'en_US'`) to use this in reports.
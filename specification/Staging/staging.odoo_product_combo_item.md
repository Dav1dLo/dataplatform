# odoo_product_combo_item

## Source system
This table originates from Odoo ERP. The naming convention (e.g., `company_id`, `create_uid`, `write_uid`, `write_date`) and the specific structure of product combo associations are characteristic of Odoo's internal database schema for managing product variants and bundles.

## Functional process 
This table supports the product configuration and bundle management process. It defines the individual components (products) that constitute a specific product combo, allowing for the calculation of additional costs (`extra_price`) when a user selects specific items within a bundle during the sales or e-commerce checkout process.

## Description
One row represents a single product component associated with a specific combo bundle. It acts as a raw landed copy of the Odoo `product.combo.item` model, capturing the relationship between a parent combo and its child product, including any price adjustments.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; unique identifier for the combo item record. |
| company_id | INTEGER | true | Company identifier | Foreign key to the company owning this record. |
| combo_id | INTEGER | false | Parent combo identifier | Foreign key to the parent product combo definition. |
| product_id | INTEGER | false | Component product identifier | Foreign key to the product being added to the combo. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| extra_price | NUMERIC | true | Price adjustment | Additional cost added to the base price when this item is selected. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp of record creation; timezone typically UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of last modification; timezone typically UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Standard Odoo multi-company architecture).
    - `combo_id` → `product_combo.id` (Links to the parent bundle definition).
    - `product_id` → `product_product.id` (Links to the actual product being added).
    - `create_uid` / `write_uid` → `res_users.id` (Links to the system users).
- **Natural keys (inferred):** Not confidently inferable; Odoo typically relies on the surrogate `id` for internal linking.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo deployments.
- **Soft Deletes:** Odoo typically uses hard deletes for these types of association tables; if a row is missing, it has likely been removed from the source.
- **Precision:** `extra_price` is `NUMERIC` without defined scale; verify if this represents currency units or a percentage-based adjustment in the source.
- **Data Integrity:** `company_id` may be null in single-company Odoo installations.
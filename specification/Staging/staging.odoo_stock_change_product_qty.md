# odoo_stock_change_product_qty

## Source system
This table originates from Odoo ERP. The naming convention `odoo_stock_change_product_qty` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal ORM models used for inventory adjustments.

## Functional process 
This table supports the inventory management and stock adjustment process. It records the intent or execution of changing the quantity of a specific product within the warehouse, typically used by the "Update Quantity" wizard in the Odoo Inventory module to reconcile stock levels.

## Description
One row represents a single request or transaction to update the stock level for a specific product template or variant. It serves as a raw landing copy of the Odoo `stock.change.product.qty` model, capturing the target quantity and the audit trail of the adjustment.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `staging.stock_change_product_qty_id_seq` for generation. |
| product_id | INTEGER | false | Foreign key to the specific product variant | Links to the `product.product` table. |
| product_tmpl_id | INTEGER | false | Foreign key to the product template | Links to the `product.template` table. |
| create_uid | INTEGER | true | ID of the user who created the record | Links to `res.users`. |
| write_uid | INTEGER | true | ID of the user who last modified the record | Links to `res.users`. |
| new_quantity | NUMERIC | false | The target quantity set for the product | Represents the absolute stock level after adjustment. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_id` → `product_product.id` (Standard Odoo relation to product variants).
    - `product_tmpl_id` → `product_template.id` (Standard Odoo relation to product templates).
    - `create_uid` / `write_uid` → `res_users.id` (Standard Odoo audit trail for user actions).
- **Natural keys (inferred):** Not confidently inferable; Odoo often uses internal IDs for these transient wizard-based models.

## Caveats for downstream consumers

- **Timestamps:** All `_date` columns are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Nature:** This table often represents a transient wizard state in Odoo; ensure that downstream logic accounts for potentially high volumes of adjustment records.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume standard CRUD behavior.
- **Precision:** `new_quantity` is `NUMERIC` without defined scale/precision in the source; verify if downstream systems require rounding to specific decimal places (e.g., 2 or 4).
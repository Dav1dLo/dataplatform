# odoo_stock_valuation_layer_revaluation

## Source system
This table originates from Odoo ERP, specifically the Inventory or Accounting module. The naming convention `odoo_stock_valuation_layer_revaluation` and the presence of columns like `account_journal_id`, `product_id`, and `lot_id` are characteristic of Odoo's internal stock valuation logic.

## Functional process 
This table supports the inventory valuation adjustment process. It tracks manual or automated revaluations of stock value, capturing the financial impact (`added_value`) of changes to product costs, which are then reflected in the general ledger via the linked `account_id` and `account_journal_id`.

## Description
One row represents a single revaluation event for a specific product or lot within the inventory system. It serves as a raw landing record in the staging layer, capturing the financial adjustment amount and the associated metadata for audit and accounting reconciliation purposes.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated identifier. |
| company_id | INTEGER | false | Odoo company identifier | Links the record to a specific legal entity. |
| product_id | INTEGER | false | Product identifier | References the product being revalued. |
| lot_id | INTEGER | true | Lot/Serial number identifier | Optional; identifies specific stock batches. |
| account_journal_id | INTEGER | true | Accounting journal ID | The journal where the valuation entry is recorded. |
| account_id | INTEGER | true | General ledger account ID | The account impacted by the revaluation. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| reason | VARCHAR | true | Revaluation description | Textual explanation for the valuation change. |
| date | DATE | true | Accounting date | The date the revaluation is effective for reporting. |
| added_value | NUMERIC | false | Adjustment amount | The monetary value added (or subtracted) to stock. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of the last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_id` → `product_product.id` (Likely reference to the product master table).
    - `company_id` → `res_company.id` (Standard Odoo multi-company architecture).
    - `account_id` → `account_account.id` (Reference to the chart of accounts).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains `create_uid` and `write_uid`, which link to internal user tables; ensure access control is applied if user identity is sensitive.
- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Integrity:** `added_value` is a `NUMERIC` type; ensure downstream systems handle potential precision/scale requirements for currency calculations.
- **Soft Deletes:** This table does not appear to have an explicit `active` or `deleted_at` flag; assume all records are current unless otherwise specified by Odoo's internal logic.
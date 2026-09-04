# odoo_stock_request_count

## Source system
This table originates from Odoo ERP, as evidenced by the naming convention `odoo_stock_request_count` and the presence of standard Odoo audit columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`.

## Functional process 
This table supports the inventory management and stock-taking process. It tracks the initiation and recording of stock counts or inventory adjustments, linking specific users to the creation and modification of these requests within the Odoo warehouse management module.

## Description
One row in this table represents a single stock request or inventory count entry initiated within the Odoo system. It serves as a raw landed copy of the Odoo `stock.request.count` model, capturing the audit trail and scheduling dates for inventory reconciliation.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.stock_request_count_id_seq`. |
| user_id | INTEGER | true | ID of the user responsible for the count | Likely references `res.users`. |
| create_uid | INTEGER | true | ID of the user who created the record | Standard Odoo audit field. |
| write_uid | INTEGER | true | ID of the user who last modified the record | Standard Odoo audit field. |
| set_count | VARCHAR | true | The recorded count value | Type is generic VARCHAR; check source for numeric constraints. |
| inventory_date | DATE | false | Scheduled date for the inventory count | Mandatory field for planning. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |
| accounting_date | DATE | true | Date for financial accounting impact | Used for valuation adjustments. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `res_users.id` (Guess: standard Odoo user reference).
    - `create_uid` → `res_users.id` (Guess: standard Odoo creator reference).
    - `write_uid` → `res_users.id` (Guess: standard Odoo modifier reference).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** All `create_date` and `write_date` values are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Sensitivity:** `user_id` and associated UID columns link to internal employee/user records; ensure appropriate access controls are applied if exposing user identities.
- **Soft Deletes:** This table does not explicitly show a `deleted` or `active` flag; verify if Odoo's `active` column is missing or if this table uses hard deletes.
- **Type Precision:** The `set_count` column is defined as `VARCHAR`; downstream consumers should handle potential non-numeric characters or casting errors when performing aggregations.
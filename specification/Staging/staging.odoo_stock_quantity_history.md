# odoo_stock_quantity_history

## Source system
This table originates from Odoo ERP, a modular business management software. The naming convention `stock_quantity_history` and the presence of audit columns like `create_uid` and `write_uid` are characteristic of Odoo's internal ORM structure for tracking inventory snapshots.

## Functional process 
This table supports the inventory management and valuation process. It records historical snapshots of stock quantities, allowing the system to reconstruct inventory levels at specific points in time for reporting or accounting purposes.

## Description
One row in this table represents a single historical snapshot of a stock quantity record at a specific point in time. As a staging table, it serves as a raw, landed copy of the Odoo `stock.quantity.history` model, capturing the state of inventory levels as they were recorded in the source system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence from Odoo. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the Odoo `res.users` table. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the Odoo `res.users` table. |
| inventory_datetime | TIMESTAMP | true | Snapshot timestamp | The point in time for which the stock quantity is calculated. |
| create_date | TIMESTAMP | true | Record creation timestamp | Audit timestamp; usually UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Audit timestamp; usually UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Inferred from Odoo standard naming convention for user references).
    - `write_uid` → `res_users.id` (Inferred from Odoo standard naming convention for user references).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** `create_uid` and `write_uid` link to user records, which may contain PII; ensure appropriate access controls are applied.
- **Timezones:** Timestamps are typically stored in UTC by Odoo; verify against the source instance configuration if local time offsets are expected.
- **Data Retention:** This table represents a raw landing; it may contain multiple versions of the same record if the source system performs updates, or it may be an append-only log depending on the Odoo module configuration.
- **Completeness:** This table does not contain the actual quantity values (e.g., `product_qty`); check if these are joined via a separate related table or if the schema provided is incomplete.
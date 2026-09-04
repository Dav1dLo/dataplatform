# odoo_sale_mass_cancel_orders

## Source system
This table originates from Odoo ERP. The naming convention `odoo_sale_mass_cancel_orders` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal ORM-managed tables, specifically those used for transient or wizard-based operations in the Sales module.

## Functional process 
This table supports the "Sales Order Management" process, specifically the bulk cancellation of sales orders. It likely functions as a transient model (a wizard) that captures the state or parameters required to execute a mass cancellation action within the Odoo sales pipeline.

## Description
One row in this table represents a single execution or configuration instance of a mass cancellation operation for sales orders. It serves as a raw landed copy of the Odoo transient model, capturing the audit trail of who initiated and modified the cancellation request.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; unique identifier for the operation. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the Odoo `res_users` table. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the Odoo `res_users` table. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the Odoo server. |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded in UTC by the Odoo server. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo pattern for tracking record creation).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for tracking record modification).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** `create_uid` and `write_uid` link to user identities; ensure access controls are applied if mapping these to human-readable names.
- **Timestamps:** All timestamps are assumed to be in UTC, consistent with Odoo's internal storage format.
- **Data Retention:** As this appears to be a transient/wizard table, rows may be purged or truncated by the source system periodically; do not rely on this table for long-term historical audit logs of cancelled orders.
- **Nullability:** Most columns are nullable, reflecting the transient nature of the record during the wizard lifecycle.
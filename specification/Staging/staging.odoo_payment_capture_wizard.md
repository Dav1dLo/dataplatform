# odoo_payment_capture_wizard

## Source system
This table originates from Odoo ERP, as indicated by the naming convention `odoo_payment_capture_wizard` and the presence of standard Odoo audit columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`.

## Functional process 
This table supports the payment processing workflow, specifically the "capture" phase of an authorized transaction. It captures the state of a wizard interface used by staff to finalize or void payments against sales orders or invoices, determining how much of an authorized amount should be captured versus voided.

## Description
One row represents a single instance of a payment capture wizard session initiated by a user. It acts as a raw landing record for the configuration of a payment capture event, tracking the intended amount to capture and whether to void any remaining authorized funds.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated identifier. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the Odoo res_users table. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the Odoo res_users table. |
| amount_to_capture | NUMERIC | true | Amount to capture | The monetary value intended for capture; unit depends on currency settings. |
| void_remaining_amount | BOOLEAN | true | Void remaining flag | If true, any remaining authorized amount is voided after capture. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Inferred UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern for record creation).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern for record modification).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined with user dimension tables to resolve names.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Lifecycle:** This table represents a "wizard" state; records may be transient or represent ephemeral UI sessions rather than finalized financial transactions.
- **Precision:** `amount_to_capture` is `NUMERIC` without defined scale/precision; verify against source DDL if high-precision financial reporting is required.
# odoo_payment_refund_wizard

## Source system
This table originates from Odoo ERP. The naming convention (`_wizard`) and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's transient models used to manage temporary state during UI-driven business processes.

## Functional process 
This table supports the "Refund Management" process within the Odoo accounting or sales module. It acts as a temporary staging area for the wizard interface that calculates and validates refund amounts against existing payments before they are committed to the general ledger.

## Description
One row in this table represents a single instance of a payment refund request initiated via the Odoo user interface. It serves as a raw landed copy of the transient wizard state, capturing the intended refund amount and the associated payment reference before the transaction is finalized.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; unique identifier for the wizard session. |
| payment_id | INTEGER | true | Foreign key to the payment | References the original payment being refunded. |
| create_uid | INTEGER | true | Creator user ID | References the user who initiated the refund wizard. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the wizard state. |
| amount_to_refund | NUMERIC | true | Refund amount | The monetary value requested for the refund. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp of when the wizard session was opened. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of the last modification to the wizard session. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `payment_id` → `staging.account_payment.id` (Guess: standard Odoo naming convention for payment references).
    - `create_uid` → `staging.res_users.id` (Guess: standard Odoo audit column for user tracking).
    - `write_uid` → `staging.res_users.id` (Guess: standard Odoo audit column for user tracking).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may be linked to PII in the `res_users` table.
- **Timezone:** Timestamps (`create_date`, `write_date`) are typically stored in UTC by Odoo; verify against system configuration.
- **Data Lifecycle:** This table represents transient wizard state; rows may be ephemeral or represent incomplete transactions that were never committed to the core accounting ledger.
- **Precision:** `amount_to_refund` is `NUMERIC` without defined scale/precision; check source DDL for specific rounding rules (usually 2 decimal places in Odoo).
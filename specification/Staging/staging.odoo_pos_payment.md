# odoo_pos_payment

## Source system
This table originates from Odoo ERP, specifically the Point of Sale (POS) module. The naming convention (e.g., `pos_order_id`, `account_move_id`, `create_uid`) is characteristic of Odoo's internal database schema, which tracks transactional payments linked to POS sessions and accounting entries.

## Functional process 
This table supports the retail point-of-sale transaction lifecycle, specifically the payment collection phase. It records the financial settlement of POS orders, capturing details such as payment methods, card information, and transaction status, which are subsequently reconciled against accounting moves and POS sessions.

## Description
One row represents a single payment transaction associated with a specific Point of Sale order. It serves as a raw landed copy of the Odoo `pos.payment` model, capturing the financial details and metadata required for downstream revenue reporting and reconciliation.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Default: `nextval('staging.pos_payment_id_seq')` |
| pos_order_id | INTEGER | false | Foreign key to the POS order | Links to `pos_order` table |
| payment_method_id | INTEGER | false | Identifier for the payment method | Links to `pos_payment_method` table |
| session_id | INTEGER | true | POS session identifier | Links to `pos_session` table |
| company_id | INTEGER | true | Company identifier | Multi-company support |
| account_move_id | INTEGER | true | Linked accounting entry | Links to `account_move` table |
| create_uid | INTEGER | true | User ID who created the record | Links to `res_users` |
| write_uid | INTEGER | true | User ID who last updated the record | Links to `res_users` |
| name | VARCHAR | true | Payment reference label | Often a system-generated string |
| card_type | VARCHAR | true | Type of card used | e.g., Credit, Debit |
| card_brand | VARCHAR | true | Brand of the card | e.g., Visa, Mastercard |
| card_no | VARCHAR | true | Masked card number | PII risk; check masking policy |
| cardholder_name | VARCHAR | true | Name on the card | PII risk |
| payment_ref_no | VARCHAR | true | External payment reference | Transaction reference from gateway |
| payment_method_authcode | VARCHAR | true | Authorization code | Provided by payment terminal |
| payment_method_issuer_bank | VARCHAR | true | Issuing bank name | |
| payment_method_payment_mode | VARCHAR | true | Payment mode classification | |
| transaction_id | VARCHAR | true | Unique transaction identifier | External gateway ID |
| payment_status | VARCHAR | true | Status of the payment | e.g., done, cancelled |
| ticket | VARCHAR | true | Receipt/Ticket identifier | |
| uuid | VARCHAR | true | Global unique identifier | Odoo internal sync ID |
| amount | NUMERIC | false | Payment amount | Monetary value |
| is_change | BOOLEAN | true | Flag for change returned | True if this is a change payment |
| payment_date | TIMESTAMP | false | Date and time of payment | |
| create_date | TIMESTAMP | true | Record creation timestamp | |
| write_date | TIMESTAMP | true | Last update timestamp | |
| employee_id | INTEGER | true | Employee who processed payment | Links to `hr_employee` |
| online_account_payment_id | INTEGER | true | Linked online payment ID | |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `pos_order_id` → `pos_order.id` (Evidence: standard Odoo naming convention for POS order relations)
    - `payment_method_id` → `pos_payment_method.id` (Evidence: standard Odoo naming convention for payment methods)
    - `session_id` → `pos_session.id` (Evidence: standard Odoo naming convention for POS sessions)
- **Natural keys (inferred):** 
    - `uuid` (Odoo uses this for cross-instance synchronization)

## Caveats for downstream consumers

- **PII/Sensitive Data:** Columns `card_no` and `cardholder_name` contain sensitive customer information and should be masked or restricted based on data governance policies.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo server configurations.
- **Soft Deletes:** Odoo typically does not use soft deletes in this table; records are usually immutable once the payment is confirmed.
- **Precision:** The `amount` column is `NUMERIC` without defined scale; verify if downstream systems require rounding to 2 decimal places for currency consistency.
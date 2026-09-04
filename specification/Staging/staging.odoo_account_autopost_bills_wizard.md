# odoo_account_autopost_bills_wizard

## Source system
This table originates from Odoo ERP. The naming convention `account_autopost_bills_wizard` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's transient model (wizard) architecture used for batch processing operations.

## Functional process 
This table supports the automated accounts payable process, specifically the "autopost" functionality for vendor bills. It tracks the state of a wizard session used to batch-process or validate bills for a specific partner, recording the count of bills processed during that session.

## Description
One row represents a single execution instance of the "autopost bills" wizard in the Odoo interface. This is a raw landing of a transient model, meaning the data is typically short-lived in the source system and serves as an audit trail for batch bill processing events.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `account_autopost_bills_wizard_id_seq`. |
| partner_id | INTEGER | true | Foreign key to the vendor/partner | Links to the `res.partner` table in Odoo. |
| nb_unmodified_bills | INTEGER | true | Count of bills | Number of bills processed that remained unmodified. |
| create_uid | INTEGER | true | Creator user ID | Links to `res.users` who initiated the wizard. |
| write_uid | INTEGER | true | Last modifier user ID | Links to `res.users` who last updated the record. |
| create_date | TIMESTAMP | true | Record creation timestamp | In UTC as per Odoo standard. |
| write_date | TIMESTAMP | true | Last update timestamp | In UTC as per Odoo standard. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `partner_id` → `res_partner.id` (Inferred from Odoo naming convention for partner relations).
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains `partner_id` and user IDs; ensure access control aligns with organizational PII/internal data policies.
- **Timezone:** Timestamps (`create_date`, `write_date`) are stored in UTC.
- **Data Lifecycle:** As this is a "wizard" table, records may be purged or truncated by the source system periodically; do not rely on this for long-term historical reporting of all bills.
- **Nullability:** Many fields are nullable as they represent transient state; handle nulls gracefully in aggregations.
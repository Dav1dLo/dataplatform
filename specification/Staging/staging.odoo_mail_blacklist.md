# odoo_mail_blacklist

## Source system
This table originates from Odoo, an open-source ERP and CRM platform. The naming convention (`mail_blacklist`, `create_uid`, `write_uid`) and the sequence-based primary key pattern are characteristic of Odoo's internal ORM-managed database schema.

## Functional process 
This table supports the email communication and marketing compliance process. It tracks email addresses that have opted out of communications or have been flagged as invalid, ensuring that the system respects communication preferences and avoids sending emails to blacklisted recipients.

## Description
One row in this table represents a single email address that has been added to the system's blacklist. This is a raw landing table representing the state of the Odoo `mail.blacklist` model, used to synchronize opt-out statuses across the data platform.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `staging.mail_blacklist_id_seq`. |
| create_uid | INTEGER | true | ID of the user who created the record | References the Odoo `res.users` table. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References the Odoo `res.users` table. |
| email | VARCHAR | false | The blacklisted email address | Natural key for this entity. |
| active | BOOLEAN | true | Soft-delete flag | Indicates if the blacklist entry is currently enforced. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit column).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit column).
- **Natural keys (inferred):** 
    - `email`

## Caveats for downstream consumers

- **PII:** The `email` column contains Personally Identifiable Information and should be masked or handled according to data privacy policies.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo deployments.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should generally filter by `active = TRUE` unless performing historical audit analysis.
- **Data Integrity:** As a staging table, this may contain duplicates or inconsistent states if the source Odoo instance has experienced synchronization issues.
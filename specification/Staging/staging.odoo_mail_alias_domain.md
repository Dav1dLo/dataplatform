# odoo_mail_alias_domain

## Source system
This table originates from Odoo ERP, as evidenced by the naming convention (`odoo_mail_alias_domain`), the use of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`), and the sequence-based primary key pattern.

## Functional process 
This table supports the email routing and configuration process within the Odoo platform. It defines the domain-specific settings for incoming email aliases, including bounce handling, catch-all configurations, and default sender addresses, which are critical for the "Lead-to-cash" and "Support ticketing" modules.

## Description
One row in this table represents a single email domain configuration used by the Odoo mail server to route incoming messages. This is a raw landing copy of the Odoo `mail.alias.domain` model, capturing the configuration state at the time of ingestion.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `staging.mail_alias_domain_id_seq`. |
| sequence | INTEGER | true | Display order index | Used for sorting domains in the UI. |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the user who last updated this record. |
| name | VARCHAR | false | Domain name | The email domain (e.g., 'example.com'). |
| bounce_alias | VARCHAR | false | Bounce alias prefix | The local part of the email used for bounce processing. |
| catchall_alias | VARCHAR | false | Catch-all alias prefix | The local part of the email used for catch-all routing. |
| default_from | VARCHAR | true | Default sender address | The default 'From' email address for outgoing mail. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for user references).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for user references).
- **Natural keys (inferred):** 
    - `name` (The domain name is unique within the Odoo system configuration).

## Caveats for downstream consumers

- **Sensitive Data:** The `default_from` and alias columns may contain email addresses; ensure compliance with PII masking policies if exposing to non-admin users.
- **Timestamps:** All `_date` columns are assumed to be in UTC, consistent with Odoo's internal storage.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are likely removed physically from the source.
- **Precision:** `VARCHAR` columns do not have defined lengths in the metadata; assume standard Odoo string limits (typically 255 characters) but verify against source DDL if performing bulk inserts.
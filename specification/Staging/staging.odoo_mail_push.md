# odoo_mail_push

## Source system
This table originates from Odoo ERP, specifically the mail or notification module. The naming convention (`mail_push`, `create_uid`, `write_uid`) and the sequence-based primary key are characteristic of Odoo's internal ORM structure.

## Functional process 
This table supports the mobile or browser push notification delivery process. It tracks the payload content intended for specific registered devices, likely used to queue or log push notifications sent to users via the Odoo platform.

## Description
One row in this table represents a single push notification record associated with a specific device. It serves as a raw landing copy of the Odoo `mail.push` model, capturing the notification content and the audit trail of its creation and modification.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `staging.mail_push_id_seq`. |
| mail_push_device_id | INTEGER | false | Foreign key to the device record | Links to the target device receiving the push. |
| create_uid | INTEGER | true | User ID who created the record | References the `res.users` table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the `res.users` table. |
| payload | TEXT | true | Notification content | Likely contains JSON-formatted push data. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC; Odoo standard. |
| write_date | TIMESTAMP | true | Last modification timestamp | Inferred UTC; Odoo standard. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `mail_push_device_id` → `staging.odoo_mail_push_device.id` (Inferred based on Odoo naming conventions for related models).
    - `create_uid` → `staging.odoo_res_users.id` (Standard Odoo audit field).
    - `write_uid` → `staging.odoo_res_users.id` (Standard Odoo audit field).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `payload` column may contain PII or sensitive notification content; ensure appropriate masking if exposed to non-privileged users.
- **Timezones:** Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with Odoo's default database storage behavior.
- **Data Integrity:** This is a staging table; it may contain duplicate records or partial updates if the ingestion process is not idempotent.
- **Soft Deletes:** Odoo typically does not use soft-delete flags; records are usually physically deleted from the source. Assume this table reflects the current state of the source at the time of extraction.
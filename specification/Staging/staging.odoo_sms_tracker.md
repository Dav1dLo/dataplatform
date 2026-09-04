# odoo_sms_tracker

## Source system
This table originates from Odoo ERP, specifically the SMS marketing or notification module. The presence of `mail_notification_id` and standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) is characteristic of Odoo's internal ORM structure for tracking communication logs.

## Functional process 
This table supports the SMS communication tracking process, likely linking SMS delivery events to broader notification workflows. It acts as a bridge between the Odoo notification system and the external SMS gateway, allowing the platform to track the status and lifecycle of individual SMS messages sent to users.

## Description
One row in this table represents a single SMS tracking event or delivery record associated with a notification. It serves as a raw landed staging entity, capturing the unique identifier and audit timestamps for SMS communications generated within the Odoo environment.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.sms_tracker_id_seq`. |
| mail_notification_id | INTEGER | true | Foreign key to notification | Links the SMS to a specific mail notification record. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record in Odoo. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| sms_uuid | VARCHAR | false | Unique SMS identifier | Business-level unique identifier for the SMS message. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp when the record was created in Odoo. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp when the record was last modified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `mail_notification_id` → `mail_notification.id` (Likely links to the Odoo mail notification system).
    - `create_uid` → `res_users.id` (Standard Odoo pattern for audit trails).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for audit trails).
- **Natural keys (inferred):** 
    - `sms_uuid` (This appears to be the unique business key for the SMS event).

## Caveats for downstream consumers

- **Sensitive Data:** The table does not contain PII directly, but `sms_uuid` could potentially be used to join with other tables containing phone numbers or message content.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Integrity:** `mail_notification_id` is nullable, implying some SMS records may exist independently of a formal mail notification object.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume all records are active unless otherwise specified by the source system logic.
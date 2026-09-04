# odoo_mail_notification_mail_resend_message_rel

## Source system
Odoo ERP. The table naming convention `_rel` combined with the specific module prefixes `mail_resend_message` and `mail_notification` strongly indicates this is a standard Odoo many-to-many join table used to link email resend requests to specific notification records.

## Functional process 
This table supports the email communication and notification retry process. It tracks the relationship between a message resend request (triggered when an email fails to send) and the specific notification records associated with that attempt, ensuring the system can track which notifications are tied to which resend operations.

## Description
One row in this table represents a single association between a `mail_resend_message` record and a `mail_notification` record. It serves as a raw landing copy of the junction table used by the Odoo ORM to manage many-to-many relationships in the mail module.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mail_resend_message_id | INTEGER | false | Foreign key to the mail_resend_message table | Links to the parent resend request. |
| mail_notification_id | INTEGER | false | Foreign key to the mail_notification table | Links to the specific notification record. |

## Keys

- **Primary key (inferred):** The composite key `(mail_resend_message_id, mail_notification_id)`.
- **Foreign keys (inferred):** 
    - `mail_resend_message_id` → `mail_resend_message.id`: Links to the resend message entity.
    - `mail_notification_id` → `mail_notification.id`: Links to the notification entity.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no business data other than the relationship between two entities.
- There are no timestamps or audit columns present in this table.
- Ensure that joins to this table are performed on both columns to maintain the integrity of the many-to-many relationship.
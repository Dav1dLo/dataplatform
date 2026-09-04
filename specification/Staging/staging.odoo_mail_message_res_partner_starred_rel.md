# odoo_mail_message_res_partner_starred_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` and the specific column pattern `mail_message_id` and `res_partner_id` are characteristic of Odoo's internal many-to-many relationship tables used to track state—in this case, which partners have "starred" or flagged specific mail messages.

## Functional process 
This table supports the internal communication and notification system within Odoo. It tracks the "starred" status of messages for individual partners, allowing the UI to persist user-specific flags on messages within the chatter or messaging module.

## Description
One row in this table represents a single "starred" association between a specific mail message and a specific partner. It is a raw landing of an Odoo join table, serving as the source for identifying which users have marked specific communications as important or flagged for follow-up.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mail_message_id | INTEGER | false | Foreign key to the mail_message table | Represents the unique identifier of the message. |
| res_partner_id | INTEGER | false | Foreign key to the res_partner table | Represents the unique identifier of the partner who starred the message. |

## Keys

- **Primary key (inferred):** The composite key `(mail_message_id, res_partner_id)` is the inferred primary key, as this is a standard Odoo join table structure.
- **Foreign keys (inferred):** 
    - `mail_message_id` → `mail_message.id`: Links to the core message entity.
    - `res_partner_id` → `res_partner.id`: Links to the partner entity (user/contact).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no timestamps or metadata columns (like `create_date`), so it is impossible to determine when a message was starred based on this table alone.
- There are no sensitive PII columns in this table, as it only contains integer foreign keys.
- As a raw staging table, it may contain orphaned records if the upstream `mail_message` or `res_partner` records were deleted without a cascading delete in the source system.
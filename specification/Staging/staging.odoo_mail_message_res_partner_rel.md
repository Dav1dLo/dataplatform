# odoo_mail_message_res_partner_rel

## Source system
This table originates from Odoo ERP. The naming convention `mail_message_res_partner_rel` is characteristic of Odoo's automated many-to-many relationship tables, which link the `mail.message` model to the `res.partner` model to track message recipients or followers.

## Functional process 
This table supports the communication and notification tracking process within Odoo. It maps specific email or system messages to the partners (contacts/users) involved in the conversation, facilitating the "followers" or "message recipient" functionality in the Odoo Discuss or Chatter modules.

## Description
One row in this table represents a single association between a specific mail message and a partner. It acts as a join table at the grain of a unique message-to-partner link. As a staging table, it provides a raw, un-joined view of the relationship data as extracted from the Odoo PostgreSQL database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mail_message_id | INTEGER | false | Foreign key to the mail message | Links to the `mail_message` table. |
| res_partner_id | INTEGER | false | Foreign key to the partner | Links to the `res_partner` table. |

## Keys

- **Primary key (inferred):** Not confidently inferable. Odoo typically uses a composite primary key on these relationship tables consisting of both columns.
- **Foreign keys (inferred):** 
    - `mail_message_id` → `staging.mail_message.id`: This column references the primary identifier of the message entity.
    - `res_partner_id` → `staging.res_partner.id`: This column references the primary identifier of the partner entity.
- **Natural keys (inferred):** The combination of `(mail_message_id, res_partner_id)` acts as the natural key for this relationship.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There is no audit timestamp (e.g., `create_date`) present in this table; downstream consumers cannot determine when the relationship was created based on this table alone.
- Ensure that joins to `mail_message` and `res_partner` handle potential missing records if the upstream extraction was partial.
# odoo_mail_scheduled_message_res_partner_rel

## Source system
This table originates from Odoo ERP. The naming convention `_res_partner_rel` is a standard pattern used by the Odoo ORM to represent many-to-many relationship tables between a primary entity (in this case, scheduled messages) and the `res.partner` model, which manages contacts, customers, and vendors.

## Functional process 
This table supports the communication and notification module within Odoo. It acts as a join table to track the distribution list for scheduled messages, linking specific message instances to the individual partners (recipients) intended to receive them.

## Description
One row in this table represents a single association between a scheduled mail message and a specific partner. It is a raw landing of an Odoo many-to-many join table, serving as the bridge to resolve the relationship between message headers and recipient contact records.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mail_scheduled_message_id | INTEGER | false | Foreign key to the scheduled message | Links to the parent message record. |
| res_partner_id | INTEGER | false | Foreign key to the partner record | Links to the recipient contact record. |

## Keys

- **Primary key (inferred):** Not confidently inferable. Odoo many-to-many tables often use a composite primary key consisting of both columns.
- **Foreign keys (inferred):** 
    - `mail_scheduled_message_id` → `mail_scheduled_message.id`: This column references the primary key of the scheduled message table.
    - `res_partner_id` → `res_partner.id`: This column references the primary key of the partner/contact table.
- **Natural keys (inferred):** The combination of `(mail_scheduled_message_id, res_partner_id)` acts as the unique business key for this relationship.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- There is no audit timestamp (e.g., `created_at`) available in this table; temporal analysis of when the relationship was created is not possible from this source alone.
- Ensure joins to `res_partner` handle potential duplicates if the source Odoo instance has data integrity issues, though the schema implies a unique constraint on the pair.
# odoo_mail_compose_message_res_partner_rel

## Source system
This table originates from Odoo ERP. The naming convention `mail_compose_message_res_partner_rel` is characteristic of Odoo's ORM-generated many-to-many relationship tables, which link the message composition wizard to specific partner records.

## Functional process 
This table supports the communication and messaging module within Odoo. It tracks the association between a specific email/message composition wizard instance and the business partners (customers, vendors, or internal users) intended as recipients or participants in that communication thread.

## Description
One row in this table represents a single link between a mail composition wizard session and a partner record. It serves as a raw landing of the join table used to manage many-to-many relationships for message distribution in the Odoo staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| wizard_id | INTEGER | false | Foreign key to the mail composition wizard | Links to the specific message composition event. |
| partner_id | INTEGER | false | Foreign key to the partner record | Identifies the recipient or related partner. |

## Keys

- **Primary key (inferred):** The composite key `(wizard_id, partner_id)` is the inferred primary key, as this is a standard Odoo join table structure.
- **Foreign keys (inferred):** 
    - `wizard_id` → `mail_compose_message.id`: This column links to the wizard instance that manages the message creation.
    - `partner_id` → `res_partner.id`: This column links to the master partner record representing the person or entity.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There is no audit timestamp or soft-delete flag present; this table reflects the current state of active associations in the source system.
- Ensure that joins to `res_partner` and `mail_compose_message` handle potential orphans if the source system performs asynchronous cleanup of the wizard records.
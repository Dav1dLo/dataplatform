# odoo_mail_compose_message_ir_attachments_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` combined with the specific module prefixes `mail_compose_message` and `ir_attachments` is characteristic of Odoo's internal many-to-many relationship tables used to link email wizard instances to their associated file attachments.

## Functional process 
This table supports the document management and communication process within Odoo. It acts as a join table that links specific email composition sessions (wizards) to the binary files or documents (attachments) that are intended to be sent or associated with those messages.

## Description
One row in this table represents a single association between an email composition wizard instance and an attachment record. It is a raw landing copy of the Odoo database join table, used to maintain the many-to-many relationship between the `mail.compose.message` and `ir.attachment` models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| wizard_id | INTEGER | false | Foreign key to the mail composition wizard | Links to the `mail_compose_message` table. |
| attachment_id | INTEGER | false | Foreign key to the attachment record | Links to the `ir_attachment` table. |

## Keys

- **Primary key (inferred):** The combination of `(wizard_id, attachment_id)` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `wizard_id` → `mail_compose_message.id`: This column references the specific email wizard session.
    - `attachment_id` → `ir_attachment.id`: This column references the specific file or document metadata record.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There is no surrogate primary key; queries should use the composite key `(wizard_id, attachment_id)` to ensure uniqueness.
- As a staging table, this reflects the raw state of the Odoo database; ensure that downstream models handle potential orphaned records if referential integrity is not strictly enforced in the source system.
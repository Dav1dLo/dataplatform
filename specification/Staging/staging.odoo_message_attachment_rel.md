# odoo_message_attachment_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` is characteristic of Odoo's internal ORM mechanism for managing many-to-many relationship tables between business objects, specifically linking communication messages to their associated file attachments.

## Functional process 
This table supports the document management and communication tracking process. It maintains the relational mapping between message entities (e.g., emails, internal notes) and the binary file attachments associated with them, ensuring that multiple attachments can be linked to a single message and vice versa.

## Description
One row in this table represents a single association between a specific message and a specific file attachment. It serves as a raw junction table in the staging layer, facilitating the reconstruction of many-to-many relationships between communication logs and stored documents.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| message_id | INTEGER | false | Foreign key to the message record | Links to the primary key of the message table. |
| attachment_id | INTEGER | false | Foreign key to the attachment record | Links to the primary key of the ir_attachment table. |

## Keys

- **Primary key (inferred):** The composite key `(message_id, attachment_id)` is the inferred primary key, as this is a standard junction table structure.
- **Foreign keys (inferred):** 
    - `message_id` → `mail_message.id`: This column references the unique identifier of the message entity.
    - `attachment_id` → `ir_attachment.id`: This column references the unique identifier of the file attachment entity.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table contains no surrogate primary key; queries should rely on the composite key `(message_id, attachment_id)`.
- There are no timestamps or audit columns present; it is impossible to determine the creation order of these relationships from this table alone.
- This is a pure junction table; it contains no business data other than the relational links.
- Ensure that joins to `mail_message` or `ir_attachment` account for potential missing records if the source system performs hard deletes on the parent entities.
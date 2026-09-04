# odoo_scheduled_message_attachment_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` is a standard pattern used by the Odoo ORM to represent many-to-many relationship tables (join tables) between two primary entities.

## Functional process 
This table supports the communication and document management module within Odoo. It facilitates the association between scheduled messages (e.g., automated email or SMS queues) and their corresponding file attachments, ensuring that documents are correctly linked to outgoing communications.

## Description
One row in this table represents a single link between a scheduled message and an attachment. It is a junction table at the grain of one row per unique message-attachment pair, serving as a raw landed copy of the Odoo database's many-to-many relationship mapping.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| scheduled_message_id | INTEGER | false | Foreign key to the scheduled message entity | Links to the primary message record. |
| attachment_id | INTEGER | false | Foreign key to the attachment entity | Links to the document/file record. |

## Keys

- **Primary key (inferred):** The composite key `(scheduled_message_id, attachment_id)`.
- **Foreign keys (inferred):** 
    - `scheduled_message_id` → `odoo_scheduled_message.id` (Inferred from Odoo naming conventions for join tables).
    - `attachment_id` → `odoo_ir_attachment.id` (Inferred from Odoo naming conventions for join tables).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; rely on the parent tables for creation or modification context.
- As a raw staging table, it may contain orphaned references if the source system's referential integrity was not strictly enforced at the time of extraction.
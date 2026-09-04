# odoo_activity_attachment_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` is characteristic of Odoo's ORM, which automatically generates junction tables for many-to-many relationships between business objects (in this case, activities and attachments).

## Functional process 
This table supports the document management and communication tracking process within Odoo. It links specific activity records (such as meetings, calls, or tasks) to their associated file attachments, enabling users to view relevant documents directly within the context of an activity.

## Description
One row in this table represents a single association between an activity and an attachment. It serves as a raw, junction-table copy from the Odoo database, maintaining the many-to-many relationship required to map multiple files to multiple activities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| activity_id | INTEGER | false | Foreign key to the activity record | Links to the primary key of the activity table. |
| attachment_id | INTEGER | false | Foreign key to the attachment record | Links to the primary key of the ir.attachment table. |

## Keys

- **Primary key (inferred):** The combination of `(activity_id, attachment_id)` acts as the composite primary key.
- **Foreign keys (inferred):** 
    - `activity_id` → `mail_activity.id` (Inferred based on Odoo standard schema for activity relations).
    - `attachment_id` → `ir_attachment.id` (Inferred based on Odoo standard schema for file attachments).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; incremental loading must rely on the upstream source's `write_date` or `create_date` if available in the parent tables.
- Ensure inner joins are used when filtering by specific activities or attachments to avoid orphaned references if the source system has inconsistent referential integrity.
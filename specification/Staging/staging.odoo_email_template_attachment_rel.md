# odoo_email_template_attachment_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` is characteristic of Odoo's ORM, which automatically generates junction tables for many-to-many relationships defined in the underlying PostgreSQL database.

## Functional process 
This table supports the email marketing and notification management process. It maintains the association between email templates and their corresponding file attachments, ensuring that when a template is triggered, the correct documents are bundled with the outgoing message.

## Description
One row in this table represents a single link between an email template and an attachment file. It acts as a junction table to resolve a many-to-many relationship, allowing multiple attachments to be associated with a single template and vice versa. As a staging table, it provides a raw, unjoined view of these associations as they exist in the source Odoo instance.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| email_template_id | INTEGER | false | Foreign key to the email template | References the primary key of the template definition. |
| attachment_id | INTEGER | false | Foreign key to the attachment record | References the primary key of the stored file/attachment. |

## Keys

- **Primary key (inferred):** The combination of `(email_template_id, attachment_id)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `email_template_id` → `email_template.id`: This column links to the master email template definition.
    - `attachment_id` → `ir_attachment.id`: This column links to the Odoo `ir_attachment` table which stores the file metadata.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; it is impossible to determine when an association was created or deleted based on this table alone.
- Ensure that downstream joins handle the potential for orphaned records if the source system does not enforce strict referential integrity at the database level.
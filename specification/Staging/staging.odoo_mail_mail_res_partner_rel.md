# odoo_mail_mail_res_partner_rel

## Source system
Odoo ERP. The naming convention `mail_mail_res_partner_rel` is characteristic of Odoo's ORM, which automatically generates join tables for many-to-many relationships between the `mail.mail` (outgoing email) and `res.partner` (contact/partner) models.

## Functional process 
Communication tracking and notification management. This table supports the link between outgoing email records and the specific partners (contacts) associated with those emails, likely representing recipients, CCs, or related entities in the Odoo messaging system.

## Description
This table represents a many-to-many join relationship between email records and partner records. Each row signifies that a specific partner is associated with a specific email message. It serves as a raw landing copy of the Odoo database's relational mapping table.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mail_mail_id | INTEGER | false | Foreign key to the mail_mail table | Represents the unique identifier of the email message. |
| res_partner_id | INTEGER | false | Foreign key to the res_partner table | Represents the unique identifier of the partner/contact. |

## Keys

- **Primary key (inferred):** The composite key `(mail_mail_id, res_partner_id)`.
- **Foreign keys (inferred):** 
    - `mail_mail_id` → `mail_mail.id`: Links to the source email record.
    - `res_partner_id` → `res_partner.id`: Links to the source partner record.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; queries should expect to join this against both `mail_mail` and `res_partner` to derive meaningful business context.
- No audit timestamps (e.g., `created_at`) are present in this table; temporal analysis must be performed by joining to the parent `mail_mail` table.
- As a raw staging table, it contains no soft-delete flags; assume records are removed if the relationship is severed in the source system.
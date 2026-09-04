# odoo_mail_activity_type_mail_template_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` is characteristic of Odoo's automated many-to-many relationship tables, which link two distinct business entities within the Odoo framework.

## Functional process 
This table supports the automated email notification process within Odoo's CRM or Activity management modules. It maps specific activity types (e.g., "Call", "Email", "Meeting") to the email templates that should be triggered or associated when such an activity is created or completed.

## Description
One row in this table represents a single association between an activity type and an email template. It acts as a join table in the staging layer, preserving the raw many-to-many relationship defined in the source Odoo database to ensure referential integrity for downstream transformation.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mail_activity_type_id | INTEGER | false | Foreign key to the activity type definition | Links to `mail_activity_type` table. |
| mail_template_id | INTEGER | false | Foreign key to the email template definition | Links to `mail_template` table. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key on `(mail_activity_type_id, mail_template_id)`.
- **Foreign keys (inferred):** 
    - `mail_activity_type_id` → `mail_activity_type.id`: This column references the activity type definition.
    - `mail_template_id` → `mail_template.id`: This column references the specific email template configuration.
- **Natural keys (inferred):** The combination of `(mail_activity_type_id, mail_template_id)` acts as the unique business key for this relationship.

## Caveats for downstream consumers

- This is a junction table; expect no descriptive attributes other than the two foreign keys.
- There are no timestamps or audit columns present in this table; it represents the current state of the relationship as captured during the last ingestion.
- Ensure that joins to `mail_activity_type` and `mail_template` are handled as inner joins if you only require active associations.
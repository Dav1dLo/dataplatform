# odoo_sms_template_sms_template_reset_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` combined with the column names `sms_template_reset_id` and `sms_template_id` is characteristic of Odoo's automated many-to-many relationship tables, which link core business objects to their associated configuration or reset templates.

## Functional process 
This table supports the SMS marketing or notification configuration process. It maintains the many-to-many association between SMS templates and their corresponding reset configurations, ensuring that specific SMS templates can be linked to multiple reset definitions (or vice versa) within the Odoo communication module.

## Description
One row in this table represents a single association between an SMS template and a reset template. This is a raw landing copy of a join table, used to resolve many-to-many relationships between the `sms_template` and `sms_template_reset` entities in the source system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| sms_template_reset_id | INTEGER | false | Foreign key to the reset template definition | Links to the primary key of the reset configuration table. |
| sms_template_id | INTEGER | false | Foreign key to the SMS template definition | Links to the primary key of the SMS template table. |

## Keys

- **Primary key (inferred):** The combination of `(sms_template_reset_id, sms_template_id)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `sms_template_reset_id` → `sms_template_reset.id` (Inferred from Odoo naming conventions for join tables).
    - `sms_template_id` → `sms_template.id` (Inferred from Odoo naming conventions for join tables).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- Ensure that joins to parent tables handle potential orphans if the source system's referential integrity is not strictly enforced.
- No sensitive PII is contained within this table as it only holds integer identifiers.
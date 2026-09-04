# odoo_mail_canned_response_res_groups_rel

## Source system
This table originates from Odoo ERP. The naming convention `mail_canned_response_res_groups_rel` is a standard pattern used by the Odoo ORM to represent a many-to-many relationship table between canned response templates and user security groups.

## Functional process 
This table supports the access control management for canned responses within the Odoo communication module. It defines which user security groups are permitted to view or utilize specific canned response templates, ensuring that sensitive or role-specific communication snippets are restricted to authorized personnel.

## Description
One row in this table represents a single association between a canned response template and a security group. It acts as a join table in the staging layer, maintaining the raw many-to-many relationship mapping as it exists in the source Odoo database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mail_canned_response_id | INTEGER | false | Foreign key to the canned response template. | Maps to `mail_canned_response.id`. |
| res_groups_id | INTEGER | false | Foreign key to the security group. | Maps to `res_groups.id`. |

## Keys

- **Primary key (inferred):** The composite key `(mail_canned_response_id, res_groups_id)`.
- **Foreign keys (inferred):** 
    - `mail_canned_response_id` → `mail_canned_response.id`: Links to the specific canned response definition.
    - `res_groups_id` → `res_groups.id`: Links to the Odoo security group definition.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a pure join table; it contains no descriptive attributes, only identifiers.
- There is no audit timestamp (e.g., `create_date` or `write_date`) present in this table, making it difficult to determine when an association was created or modified without joining to the parent entities.
- Ensure that joins to `mail_canned_response` and `res_groups` handle potential orphans if the staging data is not perfectly synchronized.
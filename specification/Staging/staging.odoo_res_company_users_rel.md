# odoo_res_company_users_rel

## Source system
This table originates from Odoo ERP. The naming convention `res_company_users_rel` is a standard pattern used by the Odoo framework to represent many-to-many relationship tables (often referred to as "relation tables" or "join tables") between the `res_company` and `res_users` entities.

## Functional process 
This table supports the multi-company access control process within Odoo. It defines which users are authorized to access or operate within specific company environments, ensuring that user permissions are scoped correctly across a multi-tenant or multi-subsidiary organizational structure.

## Description
One row in this table represents a single association between a specific user and a specific company, granting the user access to that company's data. This is a raw landing of an Odoo join table, serving as the base for mapping user-to-company permissions in downstream analytical models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| cid | INTEGER | false | Company ID | Foreign key referencing the `res_company` table. |
| user_id | INTEGER | false | User ID | Foreign key referencing the `res_users` table. |

## Keys

- **Primary key (inferred):** The combination of `(cid, user_id)` is the inferred composite primary key, as this is a standard join table structure in Odoo.
- **Foreign keys (inferred):** 
    - `cid` → `res_company.id`: This column links to the company entity.
    - `user_id` → `res_users.id`: This column links to the user entity.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table contains no non-key attributes; it is purely a mapping table.
- There are no timestamps or soft-delete flags; this table represents the current state of access permissions as captured during the last ingestion.
- Ensure that joins to `res_company` or `res_users` handle potential orphan records if the upstream Odoo instance has referential integrity gaps.
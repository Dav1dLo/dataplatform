# odoo_res_groups_users_rel

## Source system
This table originates from Odoo ERP. The naming convention `res_groups_users_rel` is a standard pattern used by the Odoo ORM to manage many-to-many relationship tables between security groups (`res_groups`) and users (`res_users`).

## Functional process 
This table supports the Identity and Access Management (IAM) process within the ERP. It maps users to their assigned security groups, which in turn dictate the permissions, access rights, and menu visibility for those users across the platform.

## Description
One row in this table represents a single assignment of a user to a specific security group. It acts as a join table in the staging layer, providing a raw, un-transformed link between user identities and their authorization roles.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| gid | INTEGER | false | Group ID | Foreign key referencing the `res_groups` table. |
| uid | INTEGER | false | User ID | Foreign key referencing the `res_users` table. |

## Keys

- **Primary key (inferred):** The combination of `(gid, uid)` is the composite primary key for this relationship table.
- **Foreign keys (inferred):** 
    - `gid → res_groups.id`: Links to the security group definition.
    - `uid → res_users.id`: Links to the user account definition.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata; the relationship is defined by surrogate integer IDs.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only the relationship mapping.
- There is no audit timestamp (e.g., `create_date` or `write_date`) present in this staging extract, so tracking when a user was added to or removed from a group is not possible from this table alone.
- Ensure that joins to `res_groups` and `res_users` are handled as inner joins if you require valid entity metadata, as this table may contain orphaned IDs if the source system's referential integrity is not strictly enforced during extraction.
# odoo_res_groups_website_menu_rel

## Source system
This table originates from Odoo ERP. The naming convention `res_groups_website_menu_rel` is characteristic of Odoo's automated many-to-many relationship tables, which link security groups (`res_groups`) to website menu items (`website_menu`).

## Functional process 
This table supports the Access Control List (ACL) management for the website builder module. It defines which user groups have permission to view or interact with specific website menu items, ensuring that navigation elements are dynamically filtered based on the logged-in user's security profile.

## Description
One row represents a single association between a security group and a website menu item. It acts as a join table in the staging layer, providing a raw, un-transformed mapping of the many-to-many relationship between the `res_groups` and `website_menu` entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| website_menu_id | INTEGER | false | Foreign key to the website menu item | References the primary key of the website menu table. |
| res_groups_id | INTEGER | false | Foreign key to the security group | References the primary key of the res_groups table. |

## Keys

- **Primary key (inferred):** The combination of `(website_menu_id, res_groups_id)` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `website_menu_id → website_menu.id`: Links to the menu definition.
    - `res_groups_id → res_groups.id`: Links to the security group definition.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no audit timestamps (e.g., `create_date` or `write_date`) present in this staging extract, making it impossible to determine when a specific permission was granted or revoked.
- Ensure that joins to parent tables handle potential orphans if the source system's referential integrity is not strictly enforced during the extraction process.
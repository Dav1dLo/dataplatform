# odoo_digest_digest_res_users_rel

## Source system
This table originates from Odoo, an open-source ERP and CRM platform. The naming convention `_rel` is characteristic of Odoo's ORM, which automatically generates junction tables for many-to-many relationships between models.

## Functional process 
This table supports the "Digest Email" configuration process. It manages the many-to-many relationship between digest email templates (`digest.digest`) and the system users (`res.users`) who are subscribed to receive them.

## Description
One row in this table represents a single subscription link between a specific digest email configuration and a user. It serves as a raw landing copy of the Odoo junction table, facilitating the mapping of users to their respective digest notifications.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| digest_digest_id | INTEGER | false | Foreign key to the digest configuration | Links to the `digest_digest` table. |
| res_users_id | INTEGER | false | Foreign key to the system user | Links to the `res_users` table. |

## Keys

- **Primary key (inferred):** The composite key `(digest_digest_id, res_users_id)` is the inferred primary key as this is a standard junction table.
- **Foreign keys (inferred):** 
    - `digest_digest_id → digest_digest.id`: This column references the primary identifier of the digest configuration.
    - `res_users_id → res_users.id`: This column references the primary identifier of the user.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; it contains no descriptive attributes, only relationship identifiers.
- There are no timestamps or audit columns present in this table; tracking the creation or deletion of these relationships is not possible from this source alone.
- As a raw staging table, it assumes the source system's referential integrity is maintained; verify existence of IDs in parent tables before joining.
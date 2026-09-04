# odoo_digest_tip_res_users_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` combined with the column names `digest_tip_id` and `res_users_id` is characteristic of Odoo's automated many-to-many relationship tables, which link core business entities (in this case, digest tips and system users) within the Odoo PostgreSQL database.

## Functional process 
This table supports the user notification and digest configuration process. It tracks the association between specific "digest tips" (educational or feature-related notifications) and the individual system users who are configured to receive or have interacted with them.

## Description
One row in this table represents a single many-to-many relationship link between a digest tip and a user. It serves as a raw landing copy of the Odoo join table, used to resolve the association between users and the tips they are assigned to or have acknowledged.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| digest_tip_id | INTEGER | false | Foreign key to the digest tip definition | Links to the primary key of the digest_tip table. |
| res_users_id | INTEGER | false | Foreign key to the system user | Links to the primary key of the res_users table. |

## Keys

- **Primary key (inferred):** The combination of `(digest_tip_id, res_users_id)` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `digest_tip_id → digest_tip.id`: This column references the master list of digest tips.
    - `res_users_id → res_users.id`: This column references the master list of system users.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only the relationship keys.
- There is no audit timestamp (e.g., `create_date` or `write_date`) present in this table, so the temporal order of relationship creation cannot be determined from this table alone.
- Ensure joins to `res_users` and `digest_tip` are handled as inner joins if you only require active associations.
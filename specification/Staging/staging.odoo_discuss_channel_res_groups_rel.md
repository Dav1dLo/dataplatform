# odoo_discuss_channel_res_groups_rel

## Source system
This table originates from Odoo ERP. The naming convention `discuss_channel_res_groups_rel` is characteristic of Odoo's automated many-to-many relationship tables, which link the `discuss.channel` model to the `res.groups` model to manage access control or membership for communication channels.

## Functional process 
This table supports the access control and security configuration process for Odoo Discuss channels. It maps specific security groups to communication channels, determining which user groups have permission to access or interact with specific channels within the Odoo platform.

## Description
One row in this table represents a single association between a communication channel and a security group. It serves as a raw, landed junction table used to resolve the many-to-many relationship between channel definitions and group-based permissions.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| discuss_channel_id | INTEGER | false | Foreign key to the discuss_channel table | Represents the unique identifier of the communication channel. |
| res_groups_id | INTEGER | false | Foreign key to the res_groups table | Represents the unique identifier of the security group granted access. |

## Keys

- **Primary key (inferred):** The composite of `(discuss_channel_id, res_groups_id)` is the inferred primary key, as this is a standard Odoo join table structure.
- **Foreign keys (inferred):** 
    - `discuss_channel_id` → `staging.discuss_channel.id`: This column links to the primary channel definition table.
    - `res_groups_id` → `staging.res_groups.id`: This column links to the Odoo security groups definition table.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table contains no surrogate primary key; queries should join on the composite of both columns to ensure uniqueness.
- As a junction table, it contains no timestamps or audit metadata; it reflects the current state of channel-group associations as captured during the last ingestion.
- Ensure inner joins are used when filtering by channel or group to avoid Cartesian products if the relationship is missing.
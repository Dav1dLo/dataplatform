# odoo_res_groups_implied_rel

## Source system
This table originates from Odoo ERP. The naming convention `res_groups_implied_rel` is characteristic of Odoo's internal PostgreSQL schema, where `res_groups` refers to the core security groups/roles module and `_rel` denotes a many-to-many join table.

## Functional process 
This table supports the Role-Based Access Control (RBAC) system within Odoo. It defines the hierarchy of security groups by mapping "implied" relationships, where a user assigned to group `gid` automatically inherits the permissions associated with group `hid`.

## Description
One row represents a single directed relationship between two security groups, indicating that the group identified by `gid` implies the permissions of the group identified by `hid`. This is a raw landing of the Odoo join table used to flatten or traverse the security group hierarchy.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| gid | INTEGER | false | ID of the parent group | References `res_groups.id`. |
| hid | INTEGER | false | ID of the implied (child) group | References `res_groups.id`. |

## Keys

- **Primary key (inferred):** The composite key `(gid, hid)` is the primary key, as this is a standard Odoo join table structure.
- **Foreign keys (inferred):** 
    - `gid` → `res_groups.id`: Represents the group that inherits permissions.
    - `hid` → `res_groups.id`: Represents the group whose permissions are being inherited.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table contains no descriptive text, only integer identifiers; it must be joined with `res_groups` to retrieve human-readable group names.
- The relationship is directional: `gid` implies `hid`. If group A implies B, and B implies C, a user in A effectively has permissions from A, B, and C.
- There are no timestamps or soft-delete flags; this represents the current state of group hierarchy as captured during the last ingestion.
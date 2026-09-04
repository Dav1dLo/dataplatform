# odoo_mrp_workcenter_productivity_loss

## Source system
This table originates from Odoo ERP, specifically the Manufacturing (MRP) module. The naming convention `mrp_workcenter_productivity_loss` is standard for Odoo's internal data structures, which track downtime or efficiency losses associated with manufacturing work centers.

## Functional process 
This table supports the manufacturing performance tracking and OEE (Overall Equipment Effectiveness) calculation process. It defines the categories of productivity loss (e.g., "Maintenance", "Tooling", "Breakdown") that can be assigned to work center productivity records to explain why a machine was not producing at full capacity.

## Description
One row represents a specific type or category of productivity loss defined within the Odoo manufacturing system. It serves as a lookup or configuration table in the staging layer, providing descriptive labels for the various reasons a work center might experience downtime or reduced efficiency.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence. |
| sequence | INTEGER | true | Display order index | Used to sort loss types in the UI. |
| loss_id | INTEGER | true | Reference to parent loss category | Likely a self-referencing or hierarchical link. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the users table. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the users table. |
| loss_type | VARCHAR | true | Classification of loss | Categorizes the loss (e.g., 'productive', 'performance', 'availability'). |
| name | JSONB | false | Display name | Multi-language label stored as JSON. |
| manual | BOOLEAN | true | Manual entry flag | Indicates if this loss is manually triggered. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Inferred UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit field for record creation).
    - `write_uid` → `res_users.id` (Standard Odoo audit field for record modification).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **JSONB Data:** The `name` column is stored as `JSONB`. Downstream consumers must use PostgreSQL JSON operators (e.g., `name->>'en_US'`) to extract human-readable text.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to implement a `deleted_at` or `active` flag; assume standard Odoo behavior where records are either present or removed.
- **Audit Fields:** `create_uid` and `write_uid` refer to internal Odoo user IDs; ensure joins to the user dimension are handled if mapping to actual employee names.
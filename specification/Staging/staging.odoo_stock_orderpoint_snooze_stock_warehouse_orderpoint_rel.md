# odoo_stock_orderpoint_snooze_stock_warehouse_orderpoint_rel

## Source system
This table originates from Odoo ERP. The naming convention `odoo_stock_orderpoint_snooze_stock_warehouse_orderpoint_rel` is characteristic of Odoo's automated many-to-many relationship tables, which link a "snooze" configuration (used to temporarily pause replenishment alerts) to specific warehouse orderpoints (reordering rules).

## Functional process 
This table supports the inventory replenishment and procurement process. It manages the many-to-many association between snooze settings for stock alerts and the specific warehouse orderpoints they apply to, allowing users to suppress replenishment notifications for specific items in specific locations for a defined period.

## Description
One row in this table represents a single association between a snooze configuration record and a warehouse orderpoint record. It serves as a raw landing copy of the Odoo relational join table, facilitating the resolution of many-to-many relationships between replenishment rules and their snooze status.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| stock_orderpoint_snooze_id | INTEGER | false | Foreign key to the snooze configuration record. | Links to the parent snooze event. |
| stock_warehouse_orderpoint_id | INTEGER | false | Foreign key to the warehouse orderpoint record. | Links to the specific reordering rule. |

## Keys

- **Primary key (inferred):** The combination of `stock_orderpoint_snooze_id` and `stock_warehouse_orderpoint_id` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `stock_orderpoint_snooze_id` → `stock_orderpoint_snooze.id`: This column references the snooze configuration entity.
    - `stock_warehouse_orderpoint_id` → `stock_warehouse_orderpoint.id`: This column references the warehouse reordering rule entity.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a join table; it contains no business data other than the relationship between two entities.
- There are no timestamps or soft-delete flags present; this table reflects the current state of relationships as captured during the last ingestion.
- Ensure that joins to parent tables handle the composite key structure correctly to avoid fan-out issues.
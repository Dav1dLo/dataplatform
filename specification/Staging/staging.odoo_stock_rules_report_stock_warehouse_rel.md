# odoo_stock_rules_report_stock_warehouse_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` combined with the specific module prefixes `stock_rules_report` and `stock_warehouse` indicates this is a standard Odoo many-to-many join table used to link stock reporting rules to specific warehouse entities.

## Functional process 
This table supports the inventory management and reporting module. It facilitates the association between stock rule configurations and the warehouses to which those rules apply, enabling the system to filter or aggregate stock data based on warehouse-specific reporting parameters.

## Description
One row in this table represents a single association between a stock rules report and a warehouse. It serves as a raw landing copy of the Odoo relational join table, maintaining the link between reporting configurations and physical or logical warehouse locations.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| stock_rules_report_id | INTEGER | false | Foreign key to the stock rules report definition. | Links to the parent report configuration. |
| stock_warehouse_id | INTEGER | false | Foreign key to the warehouse entity. | Identifies the warehouse included in the report. |

## Keys

- **Primary key (inferred):** The combination of `stock_rules_report_id` and `stock_warehouse_id` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `stock_rules_report_id` → `stock_rules_report.id`: This column references the primary identifier of the stock rules report configuration.
    - `stock_warehouse_id` → `stock_warehouse.id`: This column references the primary identifier of the warehouse entity.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- Expect no null values in either column, as this is a relational mapping table.
- Ensure that joins to parent tables are handled as inner joins if you require only valid, existing associations.
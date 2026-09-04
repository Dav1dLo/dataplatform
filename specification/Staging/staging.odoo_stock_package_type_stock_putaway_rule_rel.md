# odoo_stock_package_type_stock_putaway_rule_rel

## Source system
This table originates from Odoo ERP. The naming convention `odoo_stock_package_type_stock_putaway_rule_rel` is characteristic of Odoo's internal many-to-many relationship tables, which are automatically generated to link two distinct entities within the Inventory (Stock) module.

## Functional process 
This table supports the inventory putaway strategy configuration process. It maps specific package types (e.g., pallets, boxes) to defined putaway rules, which dictate where incoming stock should be stored based on the packaging used.

## Description
One row in this table represents a single association between a stock putaway rule and a stock package type. It serves as a raw landing copy of the join table used by the Odoo ORM to manage many-to-many relationships between the `stock.putaway.rule` and `stock.package.type` models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| stock_putaway_rule_id | INTEGER | false | Foreign key to the putaway rule definition | Links to the primary key of the putaway rule table. |
| stock_package_type_id | INTEGER | false | Foreign key to the package type definition | Links to the primary key of the package type table. |

## Keys

- **Primary key (inferred):** The combination of `(stock_putaway_rule_id, stock_package_type_id)` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `stock_putaway_rule_id` → `stock_putaway_rule.id` (Inferred from Odoo naming convention).
    - `stock_package_type_id` → `stock_package_type.id` (Inferred from Odoo naming convention).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no attributes other than the foreign keys.
- There are no timestamps or audit columns present in this table; it reflects the current state of the relationship as captured during the last ingestion.
- Ensure that joins to the parent tables handle potential orphan records if the source system's referential integrity is not strictly enforced during the extraction process.
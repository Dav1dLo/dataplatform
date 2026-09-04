# odoo_mrp_routing_workcenter_product_template_attribute_value_re

## Source system
This table originates from Odoo ERP, specifically the Manufacturing (MRP) module. The naming convention `mrp_routing_workcenter_..._re` is characteristic of Odoo's many-to-many relation tables (often suffixed with `_rel` or `_re` in database exports) used to link manufacturing routing work centers to specific product attribute values.

## Functional process 
This table supports the manufacturing configuration process, specifically defining which product variants (identified by their attribute values) are processed at which specific work centers during a manufacturing routing. It enables the system to dynamically assign routing steps based on the specific attributes of the product being manufactured.

## Description
One row in this table represents a single association between a manufacturing routing work center and a specific product template attribute value. It serves as a raw landing copy of the Odoo relational join table, facilitating the mapping of manufacturing operations to product variants.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mrp_routing_workcenter_id | INTEGER | false | Foreign key to the work center routing definition. | Links to the `mrp_routing_workcenter` table. |
| product_template_attribute_value_id | INTEGER | false | Foreign key to the product attribute value. | Links to the `product_template_attribute_value` table. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite key of `(mrp_routing_workcenter_id, product_template_attribute_value_id)`.
- **Foreign keys (inferred):** 
    - `mrp_routing_workcenter_id` → `mrp_routing_workcenter.id`: Links to the specific routing work center configuration.
    - `product_template_attribute_value_id` → `product_template_attribute_value.id`: Links to the specific product attribute value definition.
- **Natural keys (inferred):** The combination of `mrp_routing_workcenter_id` and `product_template_attribute_value_id` acts as the business key for this relationship.

## Caveats for downstream consumers

- This is a join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present in this table; it represents the current state of the relationship as exported from the source.
- Ensure that joins to parent tables handle potential orphans if the source system has experienced referential integrity issues during data extraction.
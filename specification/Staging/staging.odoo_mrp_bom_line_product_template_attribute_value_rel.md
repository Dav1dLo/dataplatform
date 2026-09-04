# odoo_mrp_bom_line_product_template_attribute_value_rel

## Source system
This table originates from Odoo ERP, specifically the Manufacturing (MRP) module. The naming convention `mrp_bom_line_..._rel` is characteristic of Odoo's internal many-to-many relationship tables used to link Bill of Materials (BOM) components with specific product attribute values (e.g., color, size).

## Functional process 
This table supports the Manufacturing Bill of Materials configuration process. It facilitates the mapping of specific product variants—defined by their attribute values—to individual lines within a Bill of Materials, allowing for dynamic BOMs where components are selected based on the chosen product configuration.

## Description
This table represents a many-to-many join relationship between Bill of Materials lines and product template attribute values. It acts as a raw landing of the Odoo relational link table, ensuring that specific product configurations are correctly associated with the materials required for their production.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mrp_bom_line_id | INTEGER | false | Foreign key to the BOM line | Links to the specific component line in the BOM. |
| product_template_attribute_value_id | INTEGER | false | Foreign key to the attribute value | Identifies the specific product variant attribute (e.g., 'Blue' or 'Large'). |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key consisting of both `mrp_bom_line_id` and `product_template_attribute_value_id`.
- **Foreign keys (inferred):** 
    - `mrp_bom_line_id` → `mrp_bom_line.id`: This column references the primary key of the BOM line definition table.
    - `product_template_attribute_value_id` → `product_template_attribute_value.id`: This column references the definition of specific attribute values for product templates.
- **Natural keys (inferred):** The combination of `(mrp_bom_line_id, product_template_attribute_value_id)` acts as the unique business key for this relationship.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; it is impossible to determine the creation or modification time of these relationships from this table alone.
- Ensure that joins to the target tables handle potential orphans if the source system's referential integrity is not strictly enforced during the extraction process.
- No sensitive PII is contained within this table.
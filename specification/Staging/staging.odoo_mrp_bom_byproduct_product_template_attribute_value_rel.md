# odoo_mrp_bom_byproduct_product_template_attribute_value_rel

## Source system
This table originates from Odoo ERP, specifically the Manufacturing (MRP) module. The naming convention `mrp_bom_byproduct_..._rel` is characteristic of Odoo's internal many-to-many relationship tables, which are automatically generated to link Bill of Materials (BOM) byproducts with specific product attribute values.

## Functional process 
This table supports the manufacturing configuration process, specifically linking byproduct definitions within a Bill of Materials to specific product variants. It ensures that when a manufacturing order is processed, the system can identify which specific product attribute values (e.g., color, size) are associated with a byproduct generated during the production of a parent product.

## Description
One row represents a single association between a specific MRP BOM byproduct record and a product template attribute value. This is a junction table used to resolve a many-to-many relationship between manufacturing byproducts and product variants in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mrp_bom_byproduct_id | INTEGER | false | Foreign key to the MRP BOM byproduct definition. | Links to the parent byproduct record. |
| product_template_attribute_value_id | INTEGER | false | Foreign key to the product template attribute value. | Identifies the specific variant attribute associated with the byproduct. |

## Keys

- **Primary key (inferred):** The combination of `mrp_bom_byproduct_id` and `product_template_attribute_value_id` forms a composite primary key.
- **Foreign keys (inferred):** 
    - `mrp_bom_byproduct_id` → `mrp_bom_byproduct.id` (Inferred from Odoo naming conventions for relational tables).
    - `product_template_attribute_value_id` → `product_template_attribute_value.id` (Inferred from Odoo naming conventions for relational tables).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table is a pure join table; it contains no business data other than the relationship identifiers.
- There are no timestamps or audit columns present in this table; it reflects the current state of the relationship as defined in the source Odoo database.
- Ensure that joins to the target tables handle potential orphans if the source system's referential integrity is not strictly enforced during the extraction process.
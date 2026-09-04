# odoo_product_variant_combination

## Source system
This table originates from Odoo ERP. The naming convention `product_template_attribute_value_id` is specific to the Odoo product configuration module, which manages variant combinations for configurable products.

## Functional process 
This table supports the product catalog and e-commerce configuration process. It acts as a junction table that maps specific product variants to the attribute values (e.g., color: red, size: XL) that define them.

## Description
One row in this table represents a single association between a specific product variant and a specific attribute value. It serves as a raw landing copy of the Odoo relational link table used to construct product variants from template attributes.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| product_product_id | INTEGER | false | Foreign key to the product variant | Links to the `product_product` table. |
| product_template_attribute_value_id | INTEGER | false | Foreign key to the attribute value | Links to the `product_template_attribute_value` table. |

## Keys

- **Primary key (inferred):** Not confidently inferable from the provided metadata; likely a composite key of `(product_product_id, product_template_attribute_value_id)`.
- **Foreign keys (inferred):** 
    - `product_product_id` → `product_product.id`: This column represents the specific variant being defined.
    - `product_template_attribute_value_id` → `product_template_attribute_value.id`: This column represents the specific attribute option selected for the variant.
- **Natural keys (inferred):** The combination of `product_product_id` and `product_template_attribute_value_id` acts as the business key for this relationship.

## Caveats for downstream consumers

- This table is a junction table; expect many-to-many relationships between products and attribute values.
- No audit timestamps (e.g., `created_at` or `updated_at`) are present in this staging table; incremental loading logic must rely on upstream source system logs or full-table refreshes.
- There are no sensitive columns (PII) in this table.
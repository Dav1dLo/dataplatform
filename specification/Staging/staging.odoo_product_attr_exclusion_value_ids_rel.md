# odoo_product_attr_exclusion_value_ids_rel

## Source system
This table originates from Odoo ERP. The naming convention `*_rel` is characteristic of Odoo's ORM, which uses dedicated join tables to manage many-to-many relationships between product template attributes and their excluded values.

## Functional process 
This table supports the product configuration and variant generation process. It defines constraints for product configurators by mapping specific attribute exclusions to the attribute values that trigger them, ensuring that incompatible product options cannot be selected together during the sales or manufacturing process.

## Description
One row in this table represents a single association between an exclusion rule and a specific attribute value that is excluded by that rule. It acts as a junction table in the Staging layer, providing a raw, normalized link between product template attribute exclusions and the values involved in those exclusions.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| product_template_attribute_exclusion_id | INTEGER | false | Foreign key to the exclusion rule definition. | Links to the parent exclusion record. |
| product_template_attribute_value_id | INTEGER | false | Foreign key to the specific attribute value being excluded. | Represents the value restricted by the exclusion rule. |

## Keys

- **Primary key (inferred):** Not confidently inferable from the provided metadata; likely a composite key of `(product_template_attribute_exclusion_id, product_template_attribute_value_id)`.
- **Foreign keys (inferred):** 
    - `product_template_attribute_exclusion_id` → `staging.product_template_attribute_exclusion.id` (Inferred from Odoo naming conventions).
    - `product_template_attribute_value_id` → `staging.product_template_attribute_value.id` (Inferred from Odoo naming conventions).
- **Natural keys (inferred):** The combination of `product_template_attribute_exclusion_id` and `product_template_attribute_value_id` acts as the business key for this relationship.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; incremental loading must rely on upstream source system logs or full-table snapshots.
- As a raw staging table, it may contain orphaned records if the upstream `product_template_attribute_exclusion` or `product_template_attribute_value` tables have been purged or updated.
- No sensitive PII is contained within this table.
# odoo_product_supplier_taxes_rel

## Source system
This table originates from Odoo ERP. The naming convention `product_supplier_taxes_rel` is characteristic of Odoo's internal ORM-generated join tables, which manage many-to-many relationships between product supplier records and tax definitions.

## Functional process 
This table supports the procurement and purchasing module, specifically the mapping of applicable taxes to supplier-product relationships. It ensures that when a product is sourced from a specific supplier, the correct tax rates are applied to the purchase order lines.

## Description
One row in this table represents a single association between a product-supplier record and a tax definition. It serves as a raw, junction-table copy from the Odoo database, capturing the many-to-many relationship required to resolve tax applicability for supplier-specific product pricing.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| prod_id | INTEGER | false | Foreign key to the product supplier record | Represents the link to the product-supplier relationship entity. |
| tax_id | INTEGER | false | Foreign key to the tax definition | References the specific tax rule or rate applied. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite key of `(prod_id, tax_id)`.
- **Foreign keys (inferred):** 
    - `prod_id` → `product_supplierinfo.id` (guess based on Odoo standard naming for supplier-product links).
    - `tax_id` → `account_tax.id` (guess based on Odoo standard naming for tax entities).
- **Natural keys (inferred):** The combination of `(prod_id, tax_id)` acts as the business key for this relationship.

## Caveats for downstream consumers

- This is a junction table; expect no descriptive attributes other than the two foreign keys.
- There is no audit timestamp or soft-delete flag present; this table reflects the current state of relationships as landed from the source.
- Ensure joins to `product_supplierinfo` and `account_tax` are handled as inner joins if you only require active, valid mappings.
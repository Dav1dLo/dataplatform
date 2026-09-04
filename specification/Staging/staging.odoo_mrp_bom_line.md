# odoo_mrp_bom_line

## Source system
This table originates from Odoo ERP, specifically the Manufacturing (MRP) module. The naming convention `mrp_bom_line` and the presence of columns like `bom_id`, `product_tmpl_id`, and `product_uom_id` are characteristic of Odoo's internal database schema for Bill of Materials components.

## Functional process 
This table supports the production planning and manufacturing process by defining the components required for a Bill of Materials (BOM). It links specific products to a parent BOM, specifying the quantity required (`product_qty`) and the unit of measure (`product_uom_id`) for each component used in the manufacturing of a finished good.

## Description
One row in this table represents a single component line item within a Bill of Materials, detailing the quantity and configuration of a specific product required for a manufacturing recipe. This is a raw landed copy of the Odoo `mrp.bom.line` model, serving as the staging layer source for downstream manufacturing analytics and cost-of-goods-sold (COGS) calculations.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated ID. |
| product_id | INTEGER | false | Foreign key to the product variant | Identifies the specific component item. |
| product_tmpl_id | INTEGER | true | Foreign key to the product template | Links to the base product definition. |
| company_id | INTEGER | true | Foreign key to the company | Multi-company context identifier. |
| product_uom_id | INTEGER | false | Foreign key to unit of measure | Defines the unit for `product_qty`. |
| sequence | INTEGER | true | Display order sequence | Used for UI sorting of BOM lines. |
| bom_id | INTEGER | false | Foreign key to the parent BOM | Links this line to its parent Bill of Materials. |
| operation_id | INTEGER | true | Foreign key to manufacturing operation | Links component to a specific work center step. |
| create_uid | INTEGER | true | User ID who created the record | Audit trail for record creation. |
| write_uid | INTEGER | true | User ID who last updated the record | Audit trail for record modification. |
| product_qty | NUMERIC | false | Quantity required | The amount of the product needed. |
| manual_consumption | BOOLEAN | true | Manual consumption flag | Indicates if consumption is tracked manually. |
| create_date | TIMESTAMP | true | Record creation timestamp | In UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | In UTC. |
| cost_share | NUMERIC | true | Cost allocation percentage | Used for byproduct cost distribution. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_id` → `product_product.id` (Standard Odoo link to product variants)
    - `bom_id` → `mrp_bom.id` (Links to the parent BOM header)
    - `product_uom_id` → `uom_uom.id` (Links to unit of measure definitions)
    - `company_id` → `res_company.id` (Standard Odoo multi-company link)
- **Natural keys (inferred):** Not confidently inferable; Odoo typically relies on the surrogate `id` for internal relationships.

## Caveats for downstream consumers

- **Timestamps:** All `create_date` and `write_date` values are stored in UTC.
- **Soft Deletes:** This table does not appear to implement a `deleted_at` flag; standard Odoo behavior is hard deletion, though some instances may use custom modules for archiving.
- **Data Integrity:** `product_tmpl_id` is nullable, which may occur if the BOM line refers to a specific variant rather than a generic template.
- **Precision:** `product_qty` and `cost_share` are `NUMERIC` types; ensure downstream transformations handle potential floating-point precision issues if casting to `FLOAT`.
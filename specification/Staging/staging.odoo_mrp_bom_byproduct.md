# odoo_mrp_bom_byproduct

## Source system
This table originates from Odoo ERP, specifically the Manufacturing (MRP) module. The naming convention `mrp_bom_byproduct` and the presence of Odoo-standard audit columns like `create_uid`, `write_uid`, and `company_id` are characteristic of Odoo's internal database schema.

## Functional process 
This table supports the manufacturing bill of materials (BOM) management process. It tracks secondary products produced alongside the main product during a manufacturing order, allowing for the allocation of costs and inventory tracking of byproducts.

## Description
One row represents a single byproduct definition associated with a specific Bill of Materials (BOM). It defines the quantity and cost share of a secondary product generated during the production process. This table serves as a raw landed copy of the Odoo `mrp.bom.byproduct` model within the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated ID. |
| product_id | INTEGER | false | Foreign key to product | References the byproduct item. |
| company_id | INTEGER | true | Foreign key to company | Multi-company context identifier. |
| product_uom_id | INTEGER | false | Foreign key to unit of measure | Defines the quantity unit for the byproduct. |
| bom_id | INTEGER | true | Foreign key to BOM | Links the byproduct to a parent BOM. |
| operation_id | INTEGER | true | Foreign key to operation | Links the byproduct to a specific manufacturing step. |
| sequence | INTEGER | true | Display sequence | Used for ordering byproducts in the UI. |
| create_uid | INTEGER | true | Creator user ID | References the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the record. |
| product_qty | NUMERIC | false | Byproduct quantity | The amount of byproduct produced. |
| cost_share | NUMERIC | true | Cost allocation percentage | Percentage of the total cost allocated to this byproduct. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_id` → `product_product.id` (Inferred from Odoo standard naming).
    - `company_id` → `res_company.id` (Inferred from Odoo standard naming).
    - `product_uom_id` → `uom_uom.id` (Inferred from Odoo standard naming).
    - `bom_id` → `mrp_bom.id` (Inferred from Odoo standard naming).
    - `operation_id` → `mrp_routing_workcenter.id` (Inferred from Odoo standard naming).
- **Natural keys (inferred):** Not confidently inferable; Odoo typically relies on the surrogate `id` for internal linking.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may be considered PII depending on organizational policy.
- **Timestamps:** Assumed to be in UTC, as is standard for Odoo PostgreSQL deployments.
- **Soft Deletes:** Odoo does not typically use soft-delete flags; records are usually physically deleted from the source.
- **Precision:** `product_qty` and `cost_share` are `NUMERIC` types; ensure downstream systems handle decimal precision correctly to avoid rounding errors.
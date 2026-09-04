# odoo_product_replenish

## Source system
This table originates from Odoo ERP, as evidenced by the naming convention of columns such as `product_tmpl_id`, `product_uom_id`, `create_uid`, and `write_uid`, which are characteristic of Odoo's ORM-based database schema.

## Functional process 
This table supports the inventory replenishment and supply chain management process. It tracks planned stock movements or procurement requests, linking specific products to warehouses, routes, and suppliers to ensure inventory levels meet demand requirements.

## Description
One row in this table represents a single planned replenishment event for a specific product or product variant within a designated warehouse. It serves as a raw landed copy of the Odoo replenishment model, capturing the quantity, timing, and sourcing parameters required for inventory fulfillment.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.product_replenish_id_seq`. |
| route_id | INTEGER | true | Foreign key to replenishment route | Defines the supply path (e.g., buy, manufacture, mto). |
| product_id | INTEGER | false | Foreign key to product variant | The specific item being replenished. |
| product_tmpl_id | INTEGER | false | Foreign key to product template | The base product definition. |
| product_uom_id | INTEGER | false | Foreign key to unit of measure | The measurement unit for the quantity. |
| warehouse_id | INTEGER | false | Foreign key to warehouse | The location where stock is to be replenished. |
| company_id | INTEGER | true | Foreign key to company | Multi-company context identifier. |
| create_uid | INTEGER | true | User ID who created the record | Reference to the system user. |
| write_uid | INTEGER | true | User ID who last modified the record | Reference to the system user. |
| product_has_variants | BOOLEAN | false | Variant flag | Indicates if the product has multiple variants. |
| date_planned | TIMESTAMP | false | Scheduled replenishment date | The target date for the stock to be available. |
| create_date | TIMESTAMP | true | Record creation timestamp | Ingestion/system timestamp. |
| write_date | TIMESTAMP | true | Last modification timestamp | Ingestion/system timestamp. |
| quantity | DOUBLE PRECISION | false | Replenishment quantity | The amount of stock to be replenished. |
| bom_id | INTEGER | true | Foreign key to Bill of Materials | Used if the replenishment is via manufacturing. |
| supplier_id | INTEGER | true | Foreign key to supplier | Used if the replenishment is via purchase. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_id` → `product.id` (Guess: links to Odoo product variant table)
    - `warehouse_id` → `stock_warehouse.id` (Guess: links to Odoo warehouse definition)
    - `supplier_id` → `res_partner.id` (Guess: links to Odoo vendor/partner table)
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains `create_uid` and `write_uid` which link to internal user tables; ensure these are handled according to internal access policies.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo deployments.
- **Data Integrity:** This is a staging table; verify if the source system performs hard or soft deletes, as this table may contain historical snapshots or only current active records.
- **Precision:** `quantity` is stored as `DOUBLE PRECISION`; ensure downstream aggregations account for potential floating-point rounding behaviors.
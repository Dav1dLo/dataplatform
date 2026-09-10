# Fully Qualified Name: dwh.DimProduct

## Description
Represents product variants and their master product definitions tracked within the inventory and catalog management processes. Combines SKU-level variant attributes, master product template classifications, and category hierarchy details to support inventory movement tracking, valuation, and stock reconciliation.

## Grain
One row per product variant (`staging.odoo_product_product.id`).

## SQL Dialect
PostgreSQL

## Columns
| Column Name | Column Type | Data Type | Precision / Sizing | Column-Level Transformations |
| --- | --- | --- | --- | --- |
| `ProductKey` | SK | integer | integer | System-generated surrogate primary key. |
| `ProductBK` | BK | integer | integer | Source product variant ID: `staging.odoo_product_product.id`. |
| `ProductTemplateID` | SCD1 | integer | integer | Foreign key to product template: `staging.odoo_product_product.product_tmpl_id`. |
| `DefaultCode` | SCD1 | varchar(255) | varchar(255) | Product SKU / internal reference, taking variant code if populated, else template code: `COALESCE(staging.odoo_product_product.default_code, staging.odoo_product_template.default_code)`. (source precision unknown → varchar(255)). |
| `Barcode` | SCD1 | varchar(255) | varchar(255) | EAN/UPC barcode: `staging.odoo_product_product.barcode`. (source precision unknown → varchar(255)). |
| `ProductName` | SCD1 | varchar(255) | varchar(255) | Product name extracted from multilingual JSONB: `COALESCE(staging.odoo_product_template.name->>'en_US', staging.odoo_product_template.name->>'en_GB', (SELECT value FROM jsonb_each_text(staging.odoo_product_template.name) LIMIT 1))`. (source precision unknown → varchar(255)). |
| `ProductType` | SCD1 | varchar(50) | varchar(50) | Type classification (e.g., 'consu', 'service', 'product'): `staging.odoo_product_template.type`. (source precision unknown → varchar(50)). |
| `ProductCategoryID` | SCD1 | integer | integer | Category identifier: `staging.odoo_product_template.categ_id`. |
| `CategoryName` | SCD1 | varchar(255) | varchar(255) | Name of the product category: `staging.odoo_product_category.name`. (source precision unknown → varchar(255)). |
| `CategoryCompleteName` | SCD1 | varchar(500) | varchar(500) | Full hierarchical path name of the category: `staging.odoo_product_category.complete_name`. (source precision unknown → varchar(500)). |
| `CategoryParentPath` | SCD1 | varchar(255) | varchar(255) | Materialized path for category tree traversal: `staging.odoo_product_category.parent_path`. (source precision unknown → varchar(255)). |
| `CategoryCostMethod` | SCD1 | varchar(50) | varchar(50) | Inventory costing method (e.g., standard, average, fifo): `staging.odoo_product_category.property_cost_method->>'value'`. (source precision unknown → varchar(50)). |
| `CategoryValuation` | SCD1 | varchar(50) | varchar(50) | Inventory valuation configuration (e.g., manual_periodic, real_time): `staging.odoo_product_category.property_valuation->>'value'`. (source precision unknown → varchar(50)). |
| `UnitOfMeasureID` | SCD1 | integer | integer | Default base unit of measure foreign key: `staging.odoo_product_template.uom_id`. |
| `PurchaseUnitOfMeasureID` | SCD1 | integer | integer | Purchase unit of measure foreign key: `staging.odoo_product_template.uom_po_id`. |
| `Tracking` | SCD1 | varchar(50) | varchar(50) | Serial/Lot tracking policy ('none', 'serial', 'lot'): `staging.odoo_product_template.tracking`. (source precision unknown → varchar(50)). |
| `ListPrice` | SCD1 | numeric(38,6) | numeric(38,6) | Sales catalog price: `staging.odoo_product_template.list_price`. (source precision unknown → numeric(38,6)). |
| `StandardPrice` | SCD1 | numeric(38,6) | numeric(38,6) | Cost price extracted from JSONB payload: `CAST(staging.odoo_product_product.standard_price->>'value' AS numeric(38,6))`. (source precision unknown → numeric(38,6)). |
| `Weight` | SCD1 | numeric(38,6) | numeric(38,6) | Product weight in kg, variant preferred over template: `COALESCE(staging.odoo_product_product.weight, staging.odoo_product_template.weight)`. (source precision unknown → numeric(38,6)). |
| `Volume` | SCD1 | numeric(38,6) | numeric(38,6) | Product volume in cubic meters, variant preferred over template: `COALESCE(staging.odoo_product_product.volume, staging.odoo_product_template.volume)`. (source precision unknown → numeric(38,6)). |
| `IsStorable` | SCD1 | boolean | boolean | Flag indicating whether the item is stockable: `staging.odoo_product_template.is_storable`. |
| `SaleOK` | SCD1 | boolean | boolean | Flag indicating if product can be sold: `staging.odoo_product_template.sale_ok`. |
| `PurchaseOK` | SCD1 | boolean | boolean | Flag indicating if product can be purchased: `staging.odoo_product_template.purchase_ok`. |
| `LotValuated` | SCD1 | boolean | boolean | Flag indicating whether lots are valued individually: `staging.odoo_product_template.lot_valuated`. |
| `IsActive` | SCD1 | boolean | boolean | Active status flag; true only if both variant and template are active: `(COALESCE(staging.odoo_product_product.active, true) AND COALESCE(staging.odoo_product_template.active, true))`. |
| `CombinationIndices` | SCD1 | varchar(255) | varchar(255) | Variant attribute combinations: `staging.odoo_product_product.combination_indices`. (source precision unknown → varchar(255)). |

## Transformation Logic
- **Source Selection**: Read base product variant records from `staging.odoo_product_product`.
- **Joins**:
  - Inner join to `staging.odoo_product_template` on `staging.odoo_product_product.product_tmpl_id = staging.odoo_product_template.id`.
  - Left outer join to `staging.odoo_product_category` on `staging.odoo_product_template.categ_id = staging.odoo_product_category.id`.
- **Filtering**: Include all records to maintain referential integrity for historical inventory movements and snapshots. Soft deletion is captured via `IsActive`.
- **JSON Extraction**:
  - Extract `ProductName` from the localized `staging.odoo_product_template.name` JSONB field (fallback to first available string).
  - Extract `StandardPrice` from `staging.odoo_product_product.standard_price->>'value'`.
  - Extract `CategoryCostMethod` from `staging.odoo_product_category.property_cost_method->>'value'`.
  - Extract `CategoryValuation` from `staging.odoo_product_category.property_valuation->>'value'`.
- **Type 1 Dimension**: Product attributes overwrite in place upon source update.

## Lineage
- Reads from: [staging.odoo_product_product](../Staging/staging.odoo_product_product.md)
- Reads from: [staging.odoo_product_template](../Staging/staging.odoo_product_template.md)
- Reads from: [staging.odoo_product_category](../Staging/staging.odoo_product_category.md)

## Notes
- `staging.odoo_product_product` provides the grain of specific saleable/trackable SKUs, while `staging.odoo_product_template` supplies shared commercial and tracking rules.
- Precision for unconstrained source numeric and varchar fields defaults to `numeric(38,6)` and safe varchar lengths according to Data Warehouse sizing standards.
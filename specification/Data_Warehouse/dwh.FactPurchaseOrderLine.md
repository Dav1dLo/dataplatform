# Fully Qualified Name: dwh.FactPurchaseOrderLine

## Description
This fact table captures the granular details of purchase order lines, recording the quantities ordered and received, unit prices, and financial totals. It serves as the primary source for analyzing procurement performance, supplier commitments, and inventory inflow across different warehouse locations.

## Grain
One row per purchase order line item. This is a transaction-level fact table.

## Columns
| Schema Name | Column Name | Column Type | Data Type | Precision / Sizing | Column Level transformations | Aggregation |
| --- | --- | --- | --- | --- | --- | --- |
| dwh | PurchaseOrderLineSK | PK | bigint | bigint | System-generated surrogate key. | |
| dwh | ProductKey | FK | integer | integer | Lookup `dwh.DimProduct.ProductKey` using `staging.odoo_purchase_order_line.product_id`. | |
| dwh | VendorKey | FK | integer | integer | Lookup `dwh.DimVendor.VendorKey` using `staging.odoo_purchase_order.partner_id`. | |
| dwh | WarehouseKey | FK | integer | integer | Lookup `dwh.DimWarehouse.WarehouseKey` using `staging.odoo_purchase_order.picking_type_id` (mapped to warehouse). | |
| dwh | PurchaseOrderLineBK | DD | integer | integer | Source `staging.odoo_purchase_order_line.id`. | |
| dwh | OrderDate | DD | date | date | Source `staging.odoo_purchase_order.date_order`. | |
| dwh | QuantityOrdered | ADD | numeric(18,4) | numeric(18,4) | Source `staging.odoo_purchase_order_line.product_qty`. | sum |
| dwh | QuantityReceived | ADD | numeric(18,4) | numeric(18,4) | Source `staging.odoo_purchase_order_line.qty_received`. | sum |
| dwh | UnitPrice | NON | numeric(18,4) | numeric(18,4) | Source `staging.odoo_purchase_order_line.price_unit`. | average |
| dwh | LineAmountTotal | ADD | numeric(18,4) | numeric(18,4) | Source `staging.odoo_purchase_order_line.price_subtotal`. | sum |
| dwh | LineTaxAmount | ADD | numeric(18,4) | numeric(18,4) | Source `staging.odoo_purchase_order_line.price_tax`. | sum |

## Transformation Logic
The table is populated by joining `staging.odoo_purchase_order_line` with `staging.odoo_purchase_order` on `order_id`. Surrogate keys are resolved by joining to the respective dimension tables: `dwh.DimProduct` on `product_id`, `dwh.DimVendor` on `partner_id`, and `dwh.DimWarehouse` on the warehouse associated with the purchase order's picking type.

## Lineage
- Reads from: [dwh.DimProduct](../Data Warehouse/Dimension/dwh.DimProduct.md)
- Reads from: [dwh.DimVendor](../Data Warehouse/Dimension/dwh.DimVendor.md)
- Reads from: [dwh.DimWarehouse](../Data Warehouse/Dimension/dwh.DimWarehouse.md)
- Reads from: [staging.odoo_purchase_order](../Staging/staging.odoo_purchase_order.md)
- Reads from: [staging.odoo_purchase_order_line](../Staging/staging.odoo_purchase_order_line.md)

## Notes
- `QuantityOrdered` and `QuantityReceived` are stored as `numeric(18,4)` to maintain precision for fractional units.
- `LineAmountTotal` represents the subtotal (excluding tax) as provided by the source system.
- The `WarehouseKey` resolution assumes a mapping between the purchase order's `picking_type_id` and the `dwh.DimWarehouse` entity.
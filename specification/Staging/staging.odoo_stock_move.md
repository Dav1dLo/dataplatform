# odoo_stock_move

## Source system
This table originates from Odoo ERP, specifically the Inventory/Warehouse management module. The naming convention (e.g., `picking_id`, `product_uom`, `procure_method`) and the presence of manufacturing-related foreign keys (`workorder_id`, `bom_line_id`) are characteristic of Odoo's internal stock movement architecture.

## Functional process 
This table supports the inventory management and logistics pipeline, tracking the physical movement of goods between locations. It records the lifecycle of stock transfers, including receipts, internal moves, and deliveries, while also linking to upstream procurement (purchase orders) and downstream sales or manufacturing consumption.

## Description
One row in this table represents a single stock movement event, detailing the transfer of a specific quantity of a product from a source location to a destination location. As a staging table, it provides a raw, landed copy of the Odoo `stock.move` model, capturing the state, quantity, and temporal attributes of inventory transactions at the grain of an individual move line.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| sequence | INTEGER | true | Display sequence | Used for ordering lines in UI. |
| company_id | INTEGER | false | Company identifier | Links to the multi-company entity. |
| product_id | INTEGER | false | Product identifier | Reference to the product master. |
| product_uom | INTEGER | false | Unit of measure ID | Reference to the UoM master. |
| location_id | INTEGER | false | Source location ID | Where the stock is coming from. |
| location_dest_id | INTEGER | false | Destination location ID | Where the stock is going. |
| location_final_id | INTEGER | true | Final destination ID | Used for complex routing. |
| partner_id | INTEGER | true | Partner identifier | Customer or vendor associated with the move. |
| picking_id | INTEGER | true | Picking identifier | Links to the parent picking document. |
| scrap_id | INTEGER | true | Scrap identifier | Links to a scrap record if applicable. |
| group_id | INTEGER | true | Procurement group ID | Groups moves for replenishment logic. |
| rule_id | INTEGER | true | Pull/Push rule ID | The rule that triggered this move. |
| picking_type_id | INTEGER | true | Picking type ID | Defines the operation type (e.g., Receipt, Delivery). |
| origin_returned_move_id | INTEGER | true | Original move ID | Links to the move being returned. |
| restrict_partner_id | INTEGER | true | Restricted partner ID | Limits stock to a specific partner. |
| warehouse_id | INTEGER | true | Warehouse identifier | The warehouse owning this move. |
| package_level_id | INTEGER | true | Package level ID | Links to the packaging hierarchy. |
| next_serial_count | INTEGER | true | Serial count | Number of serials to generate. |
| orderpoint_id | INTEGER | true | Reordering rule ID | Links to the automated replenishment rule. |
| product_packaging_id | INTEGER | true | Packaging ID | Specific product packaging used. |
| create_uid | INTEGER | true | Creator user ID | User who created the record. |
| write_uid | INTEGER | true | Last updater user ID | User who last modified the record. |
| name | VARCHAR | false | Move description | Descriptive name of the move. |
| priority | VARCHAR | true | Priority level | e.g., '0' (Normal), '1' (Urgent). |
| state | VARCHAR | true | Move status | e.g., 'draft', 'confirmed', 'assigned', 'done'. |
| origin | VARCHAR | true | Source document | Reference string (e.g., SO number). |
| procure_method | VARCHAR | false | Procurement method | 'make_to_stock' or 'make_to_order'. |
| reference | VARCHAR | true | Internal reference | Unique reference string for the move. |
| next_serial | VARCHAR | true | Next serial number | Serial number to be assigned. |
| reservation_date | DATE | true | Reservation date | Date when stock was reserved. |
| description_picking | TEXT | true | Picking description | Additional notes for warehouse staff. |
| product_qty | NUMERIC | true | Product quantity | Quantity in base UoM. |
| product_uom_qty | NUMERIC | false | Initial demand | Requested quantity. |
| quantity | NUMERIC | true | Done quantity | Actual quantity moved. |
| picked | BOOLEAN | true | Picked status | Flag indicating if item was picked. |
| scrapped | BOOLEAN | true | Scrapped status | Flag indicating if item was scrapped. |
| propagate_cancel | BOOLEAN | true | Propagate cancel | Whether to cancel linked moves. |
| is_inventory | BOOLEAN | true | Inventory flag | True if part of an inventory adjustment. |
| additional | BOOLEAN | true | Additional flag | True if added manually to a picking. |
| date | TIMESTAMP | false | Scheduled date | Expected date of the move. |
| date_deadline | TIMESTAMP | true | Deadline date | Latest date for the move. |
| delay_alert_date | TIMESTAMP | true | Delay alert date | Date for notification of delays. |
| create_date | TIMESTAMP | true | Creation timestamp | Record creation time. |
| write_date | TIMESTAMP | true | Last update timestamp | Record modification time. |
| price_unit | DOUBLE PRECISION | true | Unit price | Cost or value per unit. |
| is_done | BOOLEAN | true | Done flag | Indicates if the move is completed. |
| unit_factor | DOUBLE PRECISION | true | Unit factor | Conversion factor for UoM. |
| manual_consumption | BOOLEAN | true | Manual consumption | Flag for manual BOM consumption. |
| created_production_id | INTEGER | true | Created production ID | Links to a production order created. |
| production_id | INTEGER | true | Production ID | Links to the production order. |
| raw_material_production_id | INTEGER | true | Raw material prod ID | Links to production consuming this. |
| unbuild_id | INTEGER | true | Unbuild ID | Links to an unbuild order. |
| consume_unbuild_id | INTEGER | true | Consume unbuild ID | Links to unbuild consumption. |
| operation_id | INTEGER | true | Operation ID | Links to a manufacturing operation. |
| workorder_id | INTEGER | true | Workorder ID | Links to a manufacturing workorder. |
| bom_line_id | INTEGER | true | BOM line ID | Links to the Bill of Materials line. |
| byproduct_id | INTEGER | true | Byproduct ID | Links to a manufacturing byproduct. |
| order_finished_lot_id | INTEGER | true | Finished lot ID | Links to the lot/serial produced. |
| cost_share | NUMERIC | true | Cost share | Cost allocation percentage. |
| to_refund | BOOLEAN | true | To refund | Flag for return/refund logic. |
| purchase_line_id | INTEGER | true | Purchase line ID | Links to the purchase order line. |
| sale_line_id | INTEGER | true | Sale line ID | Links to the sale order line. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_id` → `product_product.id` (Standard Odoo product link)
    - `picking_id` → `stock_picking.id` (Links to the header document)
    - `location_id` → `stock_location.id` (Source location reference)
    - `location_dest_id` → `stock_location.id` (Destination location reference)
- **Natural keys (inferred):** 
    - `reference` (Often used as the business-level identifier for the move)

## Caveats for downstream consumers

- **Timestamps:** All `TIMESTAMP` fields are assumed to be in UTC, as is standard for Odoo PostgreSQL databases.
- **Soft Deletes:** Odoo typically does not use soft deletes; records are usually hard-deleted or marked as 'cancelled' in the `state` column.
- **Sensitive Data:** `partner_id` may link to tables containing PII (names, addresses). Ensure appropriate access controls are applied when joining to customer/vendor tables.
- **Quantities:** `product_qty` and `quantity` may differ based on the `state` of the move (e.g., reserved vs. actual). Always filter by `state = 'done'` for realized inventory movements.
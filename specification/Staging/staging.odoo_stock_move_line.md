# odoo_stock_move_line

## Source system
This table originates from Odoo ERP, specifically the Inventory/Warehouse management module. The naming convention (e.g., `picking_id`, `move_id`, `product_uom_id`) and the presence of Odoo-specific audit columns (`create_uid`, `write_uid`) are characteristic of the Odoo `stock.move.line` model.

## Functional process 
This table supports the inventory tracking and logistics process, specifically the granular movement of stock items. It records the actual execution of stock moves, tracking which specific products, in what quantities, and from which locations (or to which destinations) items were moved, including lot/serial number tracking and packaging details.

## Description
One row in this table represents a single line item of a stock movement, detailing the specific quantity of a product moved between two locations. It serves as a raw landed copy of the Odoo `stock.move.line` table, capturing the final state of inventory operations at the grain of individual product-lot-location movements.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| picking_id | INTEGER | true | Foreign key to picking | Reference to the parent stock picking operation. |
| move_id | INTEGER | true | Foreign key to stock move | Reference to the parent stock move record. |
| company_id | INTEGER | false | Company identifier | Multi-company context for the record. |
| product_id | INTEGER | true | Product identifier | The item being moved. |
| product_uom_id | INTEGER | false | Unit of measure identifier | The UoM used for this specific movement. |
| package_id | INTEGER | true | Source package identifier | The package from which the item is moved. |
| package_level_id | INTEGER | true | Package level identifier | Odoo internal reference for package hierarchy. |
| lot_id | INTEGER | true | Lot/Serial number identifier | Reference to the specific lot or serial number. |
| result_package_id | INTEGER | true | Destination package identifier | The package into which the item is moved. |
| owner_id | INTEGER | true | Owner identifier | The owner of the stock if different from the company. |
| location_id | INTEGER | false | Source location identifier | The origin warehouse location. |
| location_dest_id | INTEGER | false | Destination location identifier | The target warehouse location. |
| create_uid | INTEGER | true | Creator user identifier | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user identifier | ID of the user who last updated the record. |
| lot_name | VARCHAR | true | Lot/Serial number name | Human-readable name for the lot/serial. |
| state | VARCHAR | true | Movement state | Status of the move (e.g., 'draft', 'done'). |
| reference | VARCHAR | true | Document reference | External reference string for the move. |
| description_picking | TEXT | true | Picking description | Descriptive text associated with the picking. |
| quantity | NUMERIC | true | Quantity moved | The quantity in the product's default UoM. |
| quantity_product_uom | NUMERIC | true | Quantity in UoM | The quantity in the specified `product_uom_id`. |
| picked | BOOLEAN | true | Picked status | Flag indicating if the item has been picked. |
| date | TIMESTAMP | false | Movement date | The effective date of the stock movement. |
| create_date | TIMESTAMP | true | Record creation timestamp | Timestamp when the record was created. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp when the record was last modified. |
| workorder_id | INTEGER | true | Work order identifier | Link to manufacturing work order if applicable. |
| production_id | INTEGER | true | Production identifier | Link to manufacturing order if applicable. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `picking_id` → `stock_picking.id` (Standard Odoo relationship)
    - `move_id` → `stock_move.id` (Standard Odoo relationship)
    - `product_id` → `product_product.id` (Standard Odoo relationship)
    - `location_id` → `stock_location.id` (Standard Odoo relationship)
- **Natural keys (inferred):** Not confidently inferable; Odoo typically relies on the surrogate `id` for internal linking.

## Caveats for downstream consumers

- **Timestamps:** All timestamps (`date`, `create_date`, `write_date`) are assumed to be in UTC as per standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are generally immutable once marked as 'done'.
- **Precision:** `quantity` and `quantity_product_uom` are `NUMERIC` types; ensure downstream systems handle decimal precision correctly to avoid rounding errors.
- **PII:** No direct PII is present, though `create_uid` and `write_uid` link to user tables which may contain sensitive employee information.
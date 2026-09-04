# odoo_sale_order_line

## Source system
This table originates from Odoo ERP, an open-source business management suite. The naming convention (e.g., `sale_order_line`, `partner_id`, `product_uom`) and the presence of Odoo-specific fields like `analytic_distribution` and `display_type` are characteristic of the Odoo Sales module database schema.

## Functional process 
This table supports the Order-to-Cash process by capturing the granular details of individual items within a sales order. It tracks product quantities, pricing, discounts, and fulfillment status (delivered/invoiced) for each line item, facilitating revenue recognition and inventory allocation.

## Description
One row in this table represents a single line item within a sales order, detailing the specific product, quantity, and financial terms. It serves as a raw, landed staging entity representing the state of the `sale.order.line` model in Odoo, capturing both transactional data and audit metadata.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| order_id | INTEGER | false | Foreign key to parent sale order | Links line to the header record. |
| sequence | INTEGER | true | Display order index | Used for UI sorting. |
| company_id | INTEGER | true | Owning company ID | Multi-company context. |
| currency_id | INTEGER | true | Transaction currency ID | |
| order_partner_id | INTEGER | true | Customer/Partner ID | |
| salesman_id | INTEGER | true | Salesperson ID | |
| product_id | INTEGER | true | Product ID | |
| product_uom | INTEGER | true | Unit of Measure ID | |
| linked_line_id | INTEGER | true | Parent line reference | Used for bundles/kits. |
| combo_item_id | INTEGER | true | Combo product reference | |
| product_packaging_id | INTEGER | true | Packaging type ID | |
| create_uid | INTEGER | true | Creator user ID | |
| write_uid | INTEGER | true | Last modifier user ID | |
| state | VARCHAR | true | Line status | e.g., 'draft', 'sale', 'cancel'. |
| display_type | VARCHAR | true | Line type | e.g., 'line_section', 'line_note'. |
| virtual_id | VARCHAR | true | Virtual identifier | Used for temporary UI states. |
| linked_virtual_id | VARCHAR | true | Linked virtual identifier | |
| qty_delivered_method | VARCHAR | true | Delivery calculation method | |
| invoice_status | VARCHAR | true | Billing status | e.g., 'to invoice', 'invoiced'. |
| analytic_distribution | JSONB | true | Analytic accounting mapping | Stores cost center allocations. |
| name | TEXT | false | Line description | Often contains product details. |
| product_uom_qty | NUMERIC | false | Ordered quantity | |
| price_unit | NUMERIC | false | Unit price | |
| discount | NUMERIC | true | Discount percentage | |
| price_subtotal | NUMERIC | true | Subtotal (tax-excluded) | |
| price_total | NUMERIC | true | Total (tax-included) | |
| price_reduce_taxexcl | NUMERIC | true | Reduced price (tax-excl) | |
| price_reduce_taxinc | NUMERIC | true | Reduced price (tax-inc) | |
| qty_delivered | NUMERIC | true | Quantity delivered | |
| qty_invoiced | NUMERIC | true | Quantity invoiced | |
| qty_to_invoice | NUMERIC | true | Remaining quantity to invoice | |
| untaxed_amount_invoiced | NUMERIC | true | Invoiced amount (untaxed) | |
| untaxed_amount_to_invoice | NUMERIC | true | Remaining amount to invoice | |
| is_downpayment | BOOLEAN | true | Downpayment flag | |
| is_expense | BOOLEAN | true | Expense flag | |
| create_date | TIMESTAMP | true | Creation timestamp | |
| write_date | TIMESTAMP | true | Last modification timestamp | |
| technical_price_unit | DOUBLE PRECISION | true | Raw unit price | |
| price_tax | DOUBLE PRECISION | true | Tax amount | |
| product_packaging_qty | DOUBLE PRECISION | true | Packaging quantity | |
| customer_lead | DOUBLE PRECISION | false | Expected delivery lead time | |
| route_id | INTEGER | true | Logistics route ID | |
| warehouse_id | INTEGER | true | Warehouse ID | |
| is_service | BOOLEAN | true | Service product flag | |
| project_id | INTEGER | true | Linked project ID | |
| task_id | INTEGER | true | Linked task ID | |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `order_id` → `staging.odoo_sale_order.id` (Links line to the parent order header).
    - `product_id` → `staging.odoo_product_product.id` (Identifies the item being sold).
    - `warehouse_id` → `staging.odoo_stock_warehouse.id` (Identifies the fulfillment location).
- **Natural keys (inferred):** None. Odoo relies on internal surrogate IDs for relational integrity.

## Caveats for downstream consumers

- **Sensitive Data:** Contains `order_partner_id` which links to customer PII; ensure access controls are applied to downstream tables joining on this.
- **Timestamps:** Assumed to be in UTC as per standard Odoo configuration, but verify against source system settings.
- **Soft Deletes:** Odoo typically performs hard deletes on records; however, check for `active` flags if they exist in related tables.
- **Precision:** `NUMERIC` types are used for financial fields; ensure downstream systems maintain decimal precision to avoid rounding errors.
- **JSONB:** `analytic_distribution` is a complex object; parsing logic will be required for downstream reporting.
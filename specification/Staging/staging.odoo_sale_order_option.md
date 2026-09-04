# odoo_sale_order_option

## Source system
This table originates from Odoo ERP, specifically the Sales module. The naming convention `odoo_sale_order_option` and the presence of Odoo-specific fields like `create_uid`, `write_uid`, and `uom_id` are characteristic of the Odoo PostgreSQL schema structure.

## Functional process 
This table supports the "Quote-to-Cash" process by managing optional products or services associated with a sales quotation. It allows sales representatives to offer add-ons or alternative items to a customer during the negotiation phase, which can be converted into standard order lines if accepted.

## Description
One row in this table represents a single optional product or service linked to a specific sales order quotation. It acts as a raw landed copy of the Odoo `sale_order_option` model, capturing the item details, pricing, and quantity for potential upselling. The grain is one row per optional line item per sales order.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.sale_order_option_id_seq`. |
| order_id | INTEGER | true | Foreign key to the parent sales order | Links to the `sale_order` table. |
| product_id | INTEGER | false | Identifier for the optional product | Links to the `product_product` table. |
| line_id | INTEGER | true | Reference to the original quote line | Used if this option replaces an existing line. |
| sequence | INTEGER | true | Display order index | Determines the order in which options appear in the UI. |
| uom_id | INTEGER | false | Unit of measure identifier | Links to the `uom_uom` table. |
| create_uid | INTEGER | true | User ID who created the record | Links to `res_users`. |
| write_uid | INTEGER | true | User ID who last modified the record | Links to `res_users`. |
| name | TEXT | false | Description of the option | The display name or label for the optional item. |
| quantity | NUMERIC | false | Quantity offered | The amount of the product being proposed. |
| price_unit | NUMERIC | false | Unit price of the option | The price per unit before discounts. |
| discount | NUMERIC | true | Discount percentage | Applied to the unit price. |
| create_date | TIMESTAMP | true | Record creation timestamp | In UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | In UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `order_id` → `staging.odoo_sale_order.id` (Inferred from Odoo naming conventions).
    - `product_id` → `staging.odoo_product_product.id` (Inferred from Odoo naming conventions).
    - `uom_id` → `staging.odoo_uom_uom.id` (Inferred from Odoo naming conventions).
- **Natural keys (inferred):** Not confidently inferable; Odoo typically relies on the surrogate `id` for internal linking.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined with a user directory to identify specific employees.
- **Timestamps:** All `_date` fields are assumed to be in UTC, consistent with Odoo's internal storage.
- **Soft Deletes:** This table does not appear to have an `active` flag; assume all records are current unless filtered by business logic.
- **Precision:** `NUMERIC` types are used for financial data; ensure downstream systems handle rounding according to the source ERP's configuration.
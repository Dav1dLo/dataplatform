# odoo_pos_order_line

## Source system
This table originates from Odoo ERP, specifically the Point of Sale (POS) module. The naming convention (`odoo_pos_order_line`) and the presence of Odoo-specific audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's PostgreSQL database schema.

## Functional process 
This table supports the retail sales and transaction processing pipeline. It captures the granular line-item details for every POS transaction, including product quantities, pricing, discounts, and links to parent orders or related sale orders. It is essential for calculating revenue, cost of goods sold (COGS), and tracking product-level performance within the POS system.

## Description
One row in this table represents a single line item within a Point of Sale order, detailing the product sold, its quantity, and its associated financial values. This is a raw landed copy of the Odoo `pos_order_line` table, serving as the base staging entity for downstream sales reporting and inventory reconciliation.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| company_id | INTEGER | true | Foreign key to company | Identifies the business unit. |
| product_id | INTEGER | false | Foreign key to product | The item being sold. |
| order_id | INTEGER | false | Foreign key to parent order | Links line to the main POS order. |
| refunded_orderline_id | INTEGER | true | Reference to original line | Used for tracking returns/refunds. |
| combo_parent_id | INTEGER | true | Parent combo reference | Used for bundled product structures. |
| combo_item_id | INTEGER | true | Combo item reference | Specific item within a combo. |
| create_uid | INTEGER | true | Creator user ID | Audit: user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Audit: user who last updated the record. |
| name | VARCHAR | false | Line description | Often contains product name/variant info. |
| notice | VARCHAR | true | Internal notice | Optional text note for the line. |
| price_type | VARCHAR | true | Pricing strategy | e.g., 'fixed', 'percentage'. |
| full_product_name | VARCHAR | true | Detailed product name | Full display name including variants. |
| customer_note | VARCHAR | true | Customer-facing note | Note printed on receipt. |
| uuid | VARCHAR | true | External unique identifier | Used for synchronization. |
| note | VARCHAR | true | Internal note | General purpose text field. |
| price_unit | NUMERIC | true | Unit price | Price per single unit. |
| qty | NUMERIC | true | Quantity sold | Number of units. |
| price_subtotal | NUMERIC | false | Subtotal (excl. tax) | Calculated value. |
| price_subtotal_incl | NUMERIC | false | Subtotal (incl. tax) | Calculated value. |
| total_cost | NUMERIC | true | Total cost | Cost of goods for this line. |
| discount | NUMERIC | true | Discount percentage | Applied discount rate. |
| skip_change | BOOLEAN | true | Skip change flag | POS logic flag. |
| is_total_cost_computed | BOOLEAN | true | Cost calculation flag | Indicates if cost was auto-computed. |
| is_edited | BOOLEAN | true | Edit flag | Indicates if line was manually modified. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |
| price_extra | DOUBLE PRECISION | true | Extra price | Additional costs (e.g., customizations). |
| sale_order_origin_id | INTEGER | true | Origin sale order ID | Link to original sales order. |
| sale_order_line_id | INTEGER | true | Origin sale order line ID | Link to original sales order line. |
| down_payment_details | TEXT | true | Down payment info | JSON or text details for deposits. |
| qty_delivered | DOUBLE PRECISION | true | Delivered quantity | Actual quantity fulfilled. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `order_id` → `pos_order.id` (Links to the parent POS order header).
    - `product_id` → `product_product.id` (Links to the product catalog).
    - `company_id` → `res_company.id` (Links to the organizational entity).
- **Natural keys (inferred):**
    - `uuid` (Odoo uses this for cross-system synchronization).

## Caveats for downstream consumers

- **Sensitive Data:** The `customer_note` field may contain PII; ensure appropriate masking if exposing to non-authorized users.
- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC, consistent with standard Odoo deployments.
- **Data Integrity:** `price_subtotal` and `price_subtotal_incl` are calculated fields; verify against `price_unit` * `qty` during transformation.
- **Soft Deletes:** Odoo typically does not use soft-delete flags in this table; records are generally permanent once created.
- **Precision:** `NUMERIC` and `DOUBLE PRECISION` types are used; ensure downstream casting handles potential rounding differences during aggregation.
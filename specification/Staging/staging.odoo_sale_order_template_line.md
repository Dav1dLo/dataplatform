# odoo_sale_order_template_line

## Source system
This table originates from Odoo ERP. The naming convention (`sale_order_template_line`), the presence of Odoo-specific audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`), and the use of `JSONB` for localized fields are characteristic of the Odoo PostgreSQL schema.

## Functional process 
This table supports the "Quote/Proposal Management" process. It defines the individual line items (products, quantities, and display sections) associated with predefined sale order templates, allowing sales teams to quickly generate standardized quotes for customers.

## Description
One row represents a single line item within a specific sale order template, defining the product, quantity, and unit of measure. This table serves as a raw landed copy of the Odoo `sale.order.template.line` model, capturing the structural components of templates used for recurring sales proposals.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by Odoo sequence. |
| sale_order_template_id | INTEGER | false | Foreign key to the parent template | Links to `sale.order.template`. |
| sequence | INTEGER | true | Display order index | Determines the order of lines in the UI. |
| company_id | INTEGER | true | Multi-company identifier | Links to `res.company`. |
| product_id | INTEGER | true | Product identifier | Links to `product.product`. |
| product_uom_id | INTEGER | true | Unit of measure identifier | Links to `uom.uom`. |
| create_uid | INTEGER | true | Creator user ID | Links to `res.users`. |
| write_uid | INTEGER | true | Last modifier user ID | Links to `res.users`. |
| display_type | VARCHAR | true | Line type indicator | e.g., 'line_section' or 'line_note'. |
| name | JSONB | true | Line description | Localized text content stored as JSON. |
| product_uom_qty | NUMERIC | false | Quantity of the product | The amount to be included in the template. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `sale_order_template_id` → `staging.odoo_sale_order_template.id` (Required parent relationship)
    - `product_id` → `staging.odoo_product_product.id` (Optional product reference)
    - `company_id` → `staging.odoo_res_company.id` (Optional multi-company reference)
- **Natural keys (inferred):** Not confidently inferable; Odoo typically relies on the surrogate `id` for internal linking.

## Caveats for downstream consumers

- **Sensitive Data:** No direct PII, but `create_uid` and `write_uid` link to user tables which may contain employee names or emails.
- **Timestamps:** Timestamps are stored in the Odoo application time (typically UTC); verify against system configuration if local offsets are required.
- **Soft Deletes:** Odoo does not typically use soft-delete flags in this table; records are usually physically deleted.
- **JSONB:** The `name` column contains `JSONB` data; ensure downstream consumers are equipped to parse localized strings (e.g., `name->>'en_US'`).
- **Data Integrity:** `product_id` is nullable, which is common in Odoo for "Section" or "Note" lines that do not represent actual inventory items.
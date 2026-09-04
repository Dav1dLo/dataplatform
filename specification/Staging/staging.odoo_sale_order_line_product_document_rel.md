# odoo_sale_order_line_product_document_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` is characteristic of Odoo's internal ORM mechanism for managing many-to-many relationship tables between business entities.

## Functional process 
This table supports the Sales and Product Management modules by linking specific sales order line items to associated product documentation (such as manuals, specifications, or compliance certificates). It ensures that the correct documentation is associated with the specific items being sold in a transaction.

## Description
One row in this table represents a single association between a specific sales order line and a product document. It serves as a raw landing copy of the Odoo join table, facilitating the reconstruction of many-to-many relationships in downstream analytical models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| sale_order_line_id | INTEGER | false | Foreign key to the sales order line | Links to the primary key of the `sale_order_line` table. |
| product_document_id | INTEGER | false | Foreign key to the product document | Links to the primary key of the `product_document` table. |

## Keys

- **Primary key (inferred):** The composite of (`sale_order_line_id`, `product_document_id`).
- **Foreign keys (inferred):** 
    - `sale_order_line_id` → `sale_order_line.id`: Represents the specific line item within a sales order.
    - `product_document_id` → `product_document.id`: Represents the specific document associated with a product.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present in this table; state changes (insertions/deletions) in the source system will not be captured unless a full-load ingestion strategy is employed.
- Ensure that joins to this table are handled as a composite key to avoid Cartesian products if the relationship is not strictly unique in the source.
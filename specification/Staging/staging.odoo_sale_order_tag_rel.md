# odoo_sale_order_tag_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` is characteristic of Odoo's internal ORM mechanism for managing many-to-many relationship tables (often referred to as "relation tables" or "junction tables") between core business entities.

## Functional process 
This table supports the sales management process by enabling the categorization of sales orders. It facilitates the many-to-many relationship between sales orders and custom tags, allowing users to label orders for reporting, filtering, or workflow automation (e.g., "Urgent", "Priority", or "Wholesale").

## Description
One row in this table represents a single association between a specific sales order and a specific tag. It acts as a junction table at the grain of one row per order-tag pair. As a staging table, it provides a raw, normalized view of the link between the `sale.order` and `crm.tag` (or equivalent) entities as they exist in the Odoo database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| order_id | INTEGER | false | Foreign key to the sales order | Links to the primary key of the sales order table. |
| tag_id | INTEGER | false | Foreign key to the tag definition | Links to the primary key of the tag metadata table. |

## Keys

- **Primary key (inferred):** The combination of `(order_id, tag_id)` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `order_id` → `staging.odoo_sale_order.id`: This column references the unique identifier of the sales order.
    - `tag_id` → `staging.odoo_crm_tag.id`: This column references the unique identifier of the tag definition.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; incremental loading logic must rely on the upstream source's change tracking or full-table replacement.
- Ensure joins to `order_id` and `tag_id` are handled as inner joins if you only require orders that have at least one tag assigned.
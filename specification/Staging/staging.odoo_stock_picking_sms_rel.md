# odoo_stock_picking_sms_rel

## Source system
This table originates from Odoo ERP. The naming convention `odoo_stock_picking_sms_rel` is characteristic of Odoo's internal many-to-many relationship tables, which use the `_rel` suffix to link two distinct entities—in this case, stock picking operations and SMS notification records.

## Functional process 
This table supports the logistics and communication module within Odoo, specifically managing the association between inventory picking operations and sent SMS notifications. It ensures that multiple SMS alerts can be linked to a single stock picking event, or vice versa, facilitating audit trails for customer delivery notifications.

## Description
One row in this table represents a single link between a specific stock picking record and an SMS notification record. It serves as a raw junction table in the staging layer, capturing the many-to-many relationship required to track which SMS messages were triggered by or associated with specific warehouse picking activities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| confirm_stock_sms_id | INTEGER | false | Foreign key to the SMS record | Represents the ID of the SMS notification entity. |
| stock_picking_id | INTEGER | false | Foreign key to the stock picking record | Represents the ID of the inventory picking operation. |

## Keys

- **Primary key (inferred):** The combination of `(confirm_stock_sms_id, stock_picking_id)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `confirm_stock_sms_id` → `odoo_confirm_stock_sms.id` (Inferred based on Odoo naming conventions for junction tables).
    - `stock_picking_id` → `odoo_stock_picking.id` (Inferred based on Odoo naming conventions for junction tables).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no business data other than the relationship between two entities.
- There are no timestamps or soft-delete flags present; this table reflects the state of the relationship as captured during the ingestion process.
- Ensure joins to parent tables handle potential orphans if the source system's referential integrity is not strictly enforced at the database level.
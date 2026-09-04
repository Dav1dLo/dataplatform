# odoo_stock_scrap_stock_scrap_reason_tag_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` combined with the specific module prefixes `stock_scrap` and `stock_scrap_reason_tag` is characteristic of Odoo's automated many-to-many relationship tables, which are generated to link scrap records with their associated categorization tags.

## Functional process 
This table supports the inventory management and quality control process. It facilitates the many-to-many relationship between inventory scrap records (items removed from stock due to damage or obsolescence) and scrap reason tags, allowing a single scrap event to be associated with multiple classification labels for reporting and audit purposes.

## Description
One row in this table represents a single association between a specific scrap record and a specific reason tag. It serves as a raw junction table in the staging layer, maintaining the link between inventory scrap events and their descriptive metadata tags.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| stock_scrap_id | INTEGER | false | Foreign key to the scrap record | Links to the primary scrap event. |
| stock_scrap_reason_tag_id | INTEGER | false | Foreign key to the scrap reason tag | Links to the specific tag definition. |

## Keys

- **Primary key (inferred):** The composite key `(stock_scrap_id, stock_scrap_reason_tag_id)` is the inferred primary key, as this is a standard junction table structure in Odoo.
- **Foreign keys (inferred):** 
    - `stock_scrap_id` → `staging.odoo_stock_scrap.id`: This column references the parent scrap event record.
    - `stock_scrap_reason_tag_id` → `staging.odoo_stock_scrap_reason_tag.id`: This column references the definition of the scrap reason tag.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; expect no descriptive attributes other than the two foreign keys.
- There are no timestamps or soft-delete flags present in this table; it reflects the current state of associations as captured from the source.
- Ensure joins to parent tables handle potential missing records if the source system performs hard deletes on scrap events or tags.
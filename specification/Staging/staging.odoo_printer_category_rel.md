# odoo_printer_category_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` is a standard pattern used by the Odoo ORM to represent many-to-many relationship tables (link tables) between two entities, in this case, printers and categories.

## Functional process 
This table supports the configuration and organization of printing hardware within the Odoo environment. It facilitates the many-to-many mapping between printer devices and their respective functional or departmental categories, allowing a single printer to be associated with multiple categories and vice versa.

## Description
One row in this table represents a single association between a printer record and a category record. It serves as a raw landing of the Odoo join table, maintaining the link between the `printer` and `category` entities at the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| printer_id | INTEGER | false | Foreign key to the printer entity | Links to the primary key of the printer table. |
| category_id | INTEGER | false | Foreign key to the category entity | Links to the primary key of the category table. |

## Keys

- **Primary key (inferred):** The composite key `(printer_id, category_id)` is the inferred primary key, as this is a standard join table structure.
- **Foreign keys (inferred):** 
    - `printer_id` → `printer.id`: This column references the unique identifier of a printer record.
    - `category_id` → `category.id`: This column references the unique identifier of a category record.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table contains no non-key attributes; it is strictly a relationship mapping table.
- There are no timestamps or audit columns present; it is impossible to determine the creation or modification time of these relationships from this table alone.
- As a raw staging table, it may contain orphaned records if the upstream Odoo system has not enforced referential integrity during the extraction process.
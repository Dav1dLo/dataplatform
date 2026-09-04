# odoo_pos_config_printer_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` combined with the column names `config_id` and `printer_id` is characteristic of Odoo's internal many-to-many relationship tables, which are used to link Point of Sale (POS) configurations to specific receipt or order printers.

## Functional process 
This table supports the POS hardware configuration process. It defines the mapping between a POS terminal configuration (which defines the store settings and environment) and the physical or network printers assigned to that terminal for printing receipts and kitchen orders.

## Description
One row in this table represents a single association between a POS configuration and a printer. It is a raw landing of a join table used to resolve the many-to-many relationship between POS settings and hardware devices.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| config_id | INTEGER | false | Foreign key to the POS configuration | Links to the primary key of the POS configuration table. |
| printer_id | INTEGER | false | Foreign key to the printer definition | Links to the primary key of the printer/hardware table. |

## Keys

- **Primary key (inferred):** The combination of `(config_id, printer_id)` acts as the composite primary key.
- **Foreign keys (inferred):** 
    - `config_id` → `pos_config.id` (Inferred based on Odoo standard naming conventions for POS configuration entities).
    - `printer_id` → `pos_printer.id` (Inferred based on Odoo standard naming conventions for POS printer entities).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; it is impossible to determine the history of these associations from this table alone.
- Ensure that joins to `pos_config` and `pos_printer` handle potential missing records if the source system has experienced referential integrity issues.
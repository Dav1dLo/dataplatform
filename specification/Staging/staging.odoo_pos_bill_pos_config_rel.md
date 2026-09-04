# odoo_pos_bill_pos_config_rel

## Source system
This table originates from Odoo ERP, specifically the Point of Sale (POS) module. The naming convention `_rel` and the structure of linking two IDs strongly indicate a standard Odoo many-to-many join table used to associate POS configurations with specific bill or receipt templates.

## Functional process 
This table supports the POS configuration management process, specifically defining the relationship between POS hardware/software configurations and the bill/receipt formats assigned to them. It ensures that when a transaction is processed at a specific POS terminal, the system knows which bill template to trigger.

## Description
One row in this table represents a single association between a POS configuration and a bill template. It serves as a raw landing copy of the join table from the Odoo database, maintaining the many-to-many relationship between `pos.config` and `pos.bill` entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| pos_config_id | INTEGER | false | Foreign key to the POS configuration entity. | Links to the primary key of the `pos_config` table. |
| pos_bill_id | INTEGER | false | Foreign key to the POS bill template entity. | Links to the primary key of the `pos_bill` table. |

## Keys

- **Primary key (inferred):** The composite key `(pos_config_id, pos_bill_id)` is the inferred primary key.
- **Foreign keys (inferred):** 
    - `pos_config_id` → `pos_config.id`: This column references the configuration settings for a POS terminal.
    - `pos_bill_id` → `pos_bill.id`: This column references the specific bill or receipt layout definition.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; incremental loading logic should rely on upstream source system logs or full-table refreshes.
- Ensure that joins to `pos_config` or `pos_bill` handle potential orphans if the source system does not enforce strict referential integrity at the database level.
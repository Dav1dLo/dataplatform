# odoo_pos_config_pos_note_rel

## Source system
This table originates from Odoo ERP, specifically the Point of Sale (POS) module. The naming convention `_rel` is characteristic of Odoo's ORM, which automatically generates junction tables for many-to-many relationships between entities.

## Functional process 
This table supports the configuration of Point of Sale interfaces by mapping specific POS configurations to available POS notes. It facilitates the many-to-many relationship where a single POS configuration can be associated with multiple notes, and a note can be shared across multiple POS configurations.

## Description
One row in this table represents a single association between a POS configuration and a POS note. It serves as a raw landed junction table in the staging layer, maintaining the link between configuration settings and note definitions as extracted from the Odoo database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| pos_config_id | INTEGER | false | Foreign key to the POS configuration | Links to the primary key of the `pos_config` table. |
| pos_note_id | INTEGER | false | Foreign key to the POS note | Links to the primary key of the `pos_note` table. |

## Keys

- **Primary key (inferred):** The composite key `(pos_config_id, pos_note_id)` is the inferred primary key, as this is a standard junction table structure.
- **Foreign keys (inferred):** 
    - `pos_config_id` → `pos_config.id`: This column references the configuration entity.
    - `pos_note_id` → `pos_note.id`: This column references the note entity.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table contains no surrogate primary key; ensure joins are performed on the composite key `(pos_config_id, pos_note_id)`.
- As a junction table, it does not contain descriptive attributes, only relationship mappings.
- The table is expected to be highly normalized; check for orphaned records if referential integrity is not enforced at the source database level.
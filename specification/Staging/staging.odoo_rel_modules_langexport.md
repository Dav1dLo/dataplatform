# odoo_rel_modules_langexport

## Source system
This table originates from an Odoo ERP system. The naming convention `odoo_rel_modules_langexport` strongly suggests a join table (rel) managing the relationship between modules and language export wizard sessions within the Odoo framework.

## Functional process 
This table supports the localization and translation management process. It tracks which specific software modules are associated with a particular language export wizard instance, allowing users to bundle specific module translations for export.

## Description
One row in this table represents a single association between a language export wizard session and a specific module. It serves as a raw landing copy of the many-to-many relationship table used by the Odoo backend to manage translation exports.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| wiz_id | INTEGER | false | Foreign key to the language export wizard session | Links to the parent wizard record. |
| module_id | INTEGER | false | Foreign key to the software module | Identifies the module included in the export. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite key of (`wiz_id`, `module_id`).
- **Foreign keys (inferred):** 
    - `wiz_id` → `wizard_lang_export.id` (guess: links to the wizard session header).
    - `module_id` → `ir_module_module.id` (guess: standard Odoo table for installed modules).
- **Natural keys (inferred):** None. This is a technical join table.

## Caveats for downstream consumers

- This table contains no timestamps or audit metadata; it represents a snapshot of the relationship state.
- As a join table, expect many-to-many cardinality; ensure joins to parent tables are handled to avoid row duplication.
- There is no soft-delete flag; assume this table is truncated and reloaded or managed via standard Odoo ORM deletion logic.
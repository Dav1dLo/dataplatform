# odoo_res_lang_install_rel

## Source system
Odoo ERP. The naming convention `res_lang_install_rel` is characteristic of Odoo's internal ORM-generated many-to-many relationship tables, which link configuration entities (in this case, language installation wizards to specific language records).

## Functional process 
Localization and system configuration. This table supports the process of installing and enabling specific languages within an Odoo instance, tracking which languages have been selected or processed via a specific installation wizard session.

## Description
One row represents a single association between a language installation wizard instance and a specific language record. This is a raw landing of a join table used to manage the many-to-many relationship between language configuration wizards and the system's language library.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| language_wizard_id | INTEGER | false | Foreign key to the language installation wizard | Links to the parent wizard session. |
| lang_id | INTEGER | false | Foreign key to the language definition | Links to the specific language being installed. |

## Keys

- **Primary key (inferred):** Not confidently inferable. Odoo join tables often use a composite primary key consisting of both columns, but this is not explicitly defined in the metadata.
- **Foreign keys (inferred):** 
    - `language_wizard_id` → `res_lang_install_wizard.id` (guess based on Odoo naming patterns).
    - `lang_id` → `res_lang.id` (guess based on Odoo naming patterns).
- **Natural keys (inferred):** The combination of `(language_wizard_id, lang_id)` acts as the unique business key for this relationship.

## Caveats for downstream consumers

- This table is a technical join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; the temporal context of the installation must be inferred from the parent wizard table.
- As a raw staging table, it may contain orphaned records if the parent wizard or language records were deleted without a cascading cleanup.
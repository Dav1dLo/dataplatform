# odoo_base_language_import

## Source system
This table originates from Odoo, an open-source ERP system. The naming convention (`base_language_import`), the presence of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`), and the use of Odoo-specific sequence generators for the primary key strongly indicate an Odoo backend database.

## Functional process 
This table supports the localization and translation management process within Odoo. It tracks the import of language files (typically `.po` or `.csv` files) used to translate the user interface and system content into different languages, allowing administrators to manage multi-language support across the platform.

## Description
One row in this table represents a single language file import event or configuration record. It stores the metadata and the binary content of the translation file being imported into the system. This is a raw staging table representing a direct landing of the Odoo `base_language_import` model.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `staging.base_language_import_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References the Odoo user table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the Odoo user table. |
| name | VARCHAR | false | Display name of the language import | Human-readable label for the import task. |
| code | VARCHAR | false | Language code | Likely ISO 639-1 format (e.g., 'en_US'). |
| filename | VARCHAR | false | Original name of the uploaded file | Includes file extension. |
| overwrite | BOOLEAN | true | Overwrite existing translations flag | If true, replaces existing terms with imported ones. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC based on Odoo standard. |
| write_date | TIMESTAMP | true | Last modification timestamp | Inferred UTC based on Odoo standard. |
| data | BYTEA | false | Binary content of the language file | Contains the actual translation data. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo pattern for audit fields).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for audit fields).
- **Natural keys (inferred):** 
    - `code` (In the context of language imports, the language code is typically unique).

## Caveats for downstream consumers

- **Binary Data:** The `data` column contains raw binary content (`BYTEA`). This will require specific handling (e.g., `decode` or application-level processing) if you intend to inspect the file contents.
- **Timezones:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Sensitive Data:** While this table contains translation files, ensure that imported files do not contain PII or proprietary configuration strings before exposing this data to broader reporting layers.
- **Soft Deletes:** Odoo does not typically use soft-delete flags; this table represents the current state of the import logs as captured during the last ingestion.
# odoo_barcode_nomenclature

## Source system
This table originates from Odoo ERP, as evidenced by the naming convention (`odoo_barcode_nomenclature`), the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`), and the specific functional domain of barcode nomenclature management.

## Functional process 
This table supports the inventory and warehouse management process by defining how barcode scanners interpret scanned data. It maps barcode patterns to specific product or action identifiers, ensuring that GS1 standards or custom nomenclature rules are applied consistently during scanning operations in the warehouse.

## Description
One row in this table represents a single barcode nomenclature configuration profile used by the Odoo system to parse incoming barcode strings. It serves as a raw landed copy of the Odoo `barcode.nomenclature` model, capturing the ruleset for barcode conversion and GS1 compliance.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; managed by Odoo. |
| create_uid | INTEGER | true | User ID who created the record | References the Odoo `res.users` table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the Odoo `res.users` table. |
| name | VARCHAR | false | Name of the nomenclature | Human-readable label for the ruleset. |
| upc_ean_conv | VARCHAR | false | UPC/EAN conversion rule | Defines how to convert between barcode standards. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed; standard Odoo audit field. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed; standard Odoo audit field. |
| gs1_separator_fnc1 | VARCHAR | true | GS1 FNC1 separator character | Used for parsing GS1-128 barcodes. |
| is_gs1_nomenclature | BOOLEAN | true | GS1 compliance flag | Indicates if the nomenclature follows GS1 standards. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for user tracking).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for user tracking).
- **Natural keys (inferred):** 
    - `name` (Likely unique within the Odoo instance).

## Caveats for downstream consumers

- **Timestamps:** All `_date` columns are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Sensitive Data:** No PII is present; however, `create_uid` and `write_uid` link to internal user records which may contain sensitive employee information in other tables.
- **Soft Deletes:** This table does not appear to implement a `deleted_at` flag; standard Odoo behavior is hard deletion, though audit columns are preserved.
- **Data Precision:** `VARCHAR` lengths are not explicitly constrained in the metadata; downstream consumers should account for variable length strings and potential truncation if mapping to fixed-width fields.
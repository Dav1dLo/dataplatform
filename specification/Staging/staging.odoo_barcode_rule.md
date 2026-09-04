# odoo_barcode_rule

## Source system
This table originates from Odoo ERP, as evidenced by the naming convention (`odoo_barcode_rule`), the use of Odoo-specific audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`), and the presence of barcode nomenclature and GS1-related fields typical of Odoo's inventory and point-of-sale modules.

## Functional process 
This table supports the barcode scanning and interpretation process within the inventory or retail management workflow. It defines the rules for how the system parses scanned barcodes into actionable data, such as identifying product SKUs, quantities, or units of measure, based on the specified `pattern` and `encoding`.

## Description
One row in this table represents a single barcode parsing rule configured within a specific barcode nomenclature. This is a raw landing table in the Staging layer, containing the direct configuration state of barcode rules as extracted from the Odoo database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated ID. |
| barcode_nomenclature_id | INTEGER | true | Foreign key to the parent nomenclature | Links the rule to a specific barcode configuration set. |
| sequence | INTEGER | true | Display/processing order | Determines the priority of rule evaluation. |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who created the rule. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the user who last updated the rule. |
| name | VARCHAR | false | Rule name | Human-readable label for the barcode rule. |
| encoding | VARCHAR | false | Barcode encoding standard | e.g., 'ean13', 'upca'. |
| type | VARCHAR | false | Rule type | Defines the action (e.g., 'product', 'weight', 'price'). |
| pattern | VARCHAR | false | Regex pattern | The regular expression used to parse the barcode string. |
| alias | VARCHAR | false | Alias name | Alternative identifier for the rule. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the Odoo application. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the Odoo application. |
| associated_uom_id | INTEGER | true | Unit of measure ID | Links the rule to a specific UoM if applicable. |
| gs1_content_type | VARCHAR | true | GS1 content type | Specifies the GS1 data type if the rule is GS1-compliant. |
| gs1_decimal_usage | BOOLEAN | true | Decimal usage flag | Indicates if the rule handles decimal values. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `barcode_nomenclature_id` → `staging.odoo_barcode_nomenclature.id` (Likely reference to the parent nomenclature entity).
    - `create_uid` → `staging.odoo_res_users.id` (Standard Odoo pattern for audit user references).
    - `write_uid` → `staging.odoo_res_users.id` (Standard Odoo pattern for audit user references).
    - `associated_uom_id` → `staging.odoo_uom_uom.id` (Likely reference to the unit of measure table).
- **Natural keys (inferred):** Not confidently inferable; while `name` or `pattern` might be unique in practice, Odoo typically relies on the surrogate `id` for internal references.

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are stored in UTC as per standard Odoo behavior.
- **Data Sensitivity:** This table contains configuration metadata and does not contain PII or sensitive financial data.
- **Soft Deletes:** Odoo typically performs hard deletes on configuration tables; assume this table contains only active records unless an `active` boolean column is present (which is absent here).
- **Precision:** `VARCHAR` lengths are not explicitly defined in the source metadata; assume standard Odoo field lengths (typically 255 for names/patterns) but verify against source DDL if performing bulk loads.
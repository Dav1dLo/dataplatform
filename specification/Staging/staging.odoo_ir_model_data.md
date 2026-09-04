# odoo_ir_model_data

## Source system
This table originates from Odoo ERP. The naming convention `ir_model_data` is a core component of the Odoo framework, specifically the "IrModelData" model, which acts as the registry for mapping external XML IDs to internal database record IDs.

## Functional process 
This table supports the Odoo module management and data synchronization process. It maps external identifiers (used in XML data files during module installation or updates) to internal database records, ensuring that subsequent updates to modules correctly identify and modify existing records rather than creating duplicates.

## Description
One row represents a single mapping between an external identifier (defined by a module and a name) and an internal record ID within a specific Odoo model. This is a raw landed copy of the Odoo metadata registry, serving as the primary lookup table for resolving external references during data integration or migration tasks.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; internal to the staging layer. |
| create_uid | INTEGER | true | Creator user ID | References the user who created this mapping. |
| create_date | TIMESTAMP | true | Creation timestamp | Defaults to UTC; records when the mapping was first created. |
| write_date | TIMESTAMP | true | Last update timestamp | Defaults to UTC; records the last modification to this mapping. |
| write_uid | INTEGER | true | Modifier user ID | References the user who last updated this mapping. |
| res_id | INTEGER | true | Resource ID | The internal ID of the record in the target model. |
| noupdate | BOOLEAN | true | No-update flag | If true, prevents the Odoo engine from overwriting this record during module updates. |
| name | VARCHAR | false | External identifier | The unique name assigned to the record within the module. |
| module | VARCHAR | false | Module name | The name of the Odoo module that owns this external ID. |
| model | VARCHAR | false | Model name | The technical name of the Odoo model (e.g., 'res.partner'). |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for audit fields).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for audit fields).
- **Natural keys (inferred):** 
    - `(module, name)`: This combination uniquely identifies an external record across the Odoo system.

## Caveats for downstream consumers

- **Timestamps:** All timestamps (`create_date`, `write_date`) are stored in UTC.
- **Data Integrity:** The `res_id` column may be null if the external ID refers to a record that has been deleted or has not yet been linked to an internal object.
- **Sensitivity:** This table contains metadata about system records; while it does not contain PII directly, it maps identifiers to business data that may be sensitive.
- **Soft Deletes:** This table does not implement soft deletes; it reflects the state of the Odoo `ir_model_data` table as captured during the last ingestion.
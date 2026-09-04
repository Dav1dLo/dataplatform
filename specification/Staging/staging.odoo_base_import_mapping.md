# odoo_base_import_mapping

## Source system
This table originates from Odoo, an open-source ERP system. The naming convention `base_import_mapping` and the presence of audit columns like `create_uid` and `write_uid` are characteristic of Odoo's internal ORM metadata tables used to track user-defined field mappings during data import processes.

## Functional process 
This table supports the data import functionality within Odoo. It stores the mapping configurations that users define when importing external data (e.g., CSV files) into specific Odoo models, linking source file columns to target system fields.

## Description
One row represents a single field-to-field mapping configuration for a specific data import template. It records how a column from an external source file is mapped to a specific field within an Odoo model. This table serves as a raw landing copy of the Odoo `base_import_mapping` system table, capturing the state of import configurations.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.base_import_mapping_id_seq`. |
| create_uid | INTEGER | true | ID of the user who created the mapping | References `res_users.id`. |
| write_uid | INTEGER | true | ID of the user who last updated the mapping | References `res_users.id`. |
| res_model | VARCHAR | true | The target Odoo model name | e.g., 'res.partner', 'sale.order'. |
| column_name | VARCHAR | true | The name of the column in the source file | The header name from the imported file. |
| field_name | VARCHAR | true | The target field name in the Odoo model | The internal technical name of the field. |
| create_date | TIMESTAMP | true | Creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern for record creation).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern for record modification).
- **Natural keys (inferred):** Not confidently inferable; mappings are likely scoped by a hidden `import_id` or user session context not present in this staging extract.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Sensitivity:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against a user dimension to identify specific personnel.
- **Soft Deletes:** Odoo typically uses hard deletes for this table; however, verify if your ingestion process captures historical snapshots or only the current state.
- **Precision:** `VARCHAR` lengths are not explicitly defined in the source metadata; downstream systems should handle variable-length strings appropriately to avoid truncation.
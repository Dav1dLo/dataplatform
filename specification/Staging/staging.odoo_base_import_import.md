# odoo_base_import_import

## Source system
This table originates from Odoo, an open-source ERP system. The naming convention `base_import_import` and the presence of columns like `res_model`, `create_uid`, and `write_uid` are characteristic of Odoo's internal data import management module, which tracks bulk data uploads into the system.

## Functional process 
This table supports the data import management process within Odoo. It tracks the metadata and binary content of files uploaded by users to perform bulk imports into specific business models (e.g., importing contacts, products, or sales orders).

## Description
One row in this table represents a single file import session initiated by a user. It records the target model, the file metadata, and the raw binary content of the uploaded file. This is a raw landing table in the Staging layer, capturing the state of import requests as they exist in the Odoo database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; unique identifier for the import record. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the user who initiated the import. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the user who last updated the import record. |
| res_model | VARCHAR | true | Target model name | The Odoo technical name of the model (e.g., 'res.partner') being imported into. |
| file_name | VARCHAR | true | Original filename | The name of the file as provided by the user during upload. |
| file_type | VARCHAR | true | File extension/format | The format of the uploaded file (e.g., 'csv', 'xlsx'). |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp when the import record was created. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp when the import record was last modified. |
| file | BYTEA | true | Binary file content | The actual file data stored as a byte array. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo pattern for audit fields).
    - `write_uid` → `res_users.id` (guess: standard Odoo pattern for audit fields).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Binary Data:** The `file` column contains raw binary data (`BYTEA`). Querying this column directly in large result sets may cause performance issues or memory errors in client tools.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Sensitive Data:** The `file` column may contain sensitive business data depending on what users are uploading; ensure appropriate access controls are applied.
- **Data Retention:** This table tracks the import *request* metadata; it does not necessarily indicate that the import was successful or that the data was successfully committed to the target model.
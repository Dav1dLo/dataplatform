# odoo_res_partner_autocomplete_sync

## Source system
This table originates from Odoo ERP. The naming convention `res_partner_autocomplete_sync` is characteristic of Odoo's internal module structure, where `res_partner` refers to the core business object for contacts (customers, vendors, partners).

## Functional process 
This table supports the contact data enrichment and synchronization process. It tracks the status of automated partner data lookups or external service synchronizations, ensuring that contact records are kept up-to-date with external business registries or autocomplete services.

## Description
One row in this table represents a single synchronization event or status record for a specific partner contact. It serves as a raw landing copy of the Odoo internal sync state, used to track whether a partner record has been processed or requires further synchronization.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; unique identifier for this sync record. |
| partner_id | INTEGER | true | Foreign key to partner | References the `res_partner` table. |
| create_uid | INTEGER | true | Creator user ID | References the `res_users` table for the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | References the `res_users` table for the user who last updated this record. |
| synched | BOOLEAN | true | Sync status flag | Indicates if the autocomplete sync has been successfully completed. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp of when the sync record was created. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of the last modification to this sync record. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `partner_id` → `res_partner.id`: Links the sync status to the specific contact record.
    - `create_uid` → `res_users.id`: Identifies the system user responsible for the record creation.
    - `write_uid` → `res_users.id`: Identifies the system user responsible for the last update.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are stored in the Odoo application server time, which is typically UTC, but verify against the source system configuration.
- This table contains audit fields (`create_uid`, `write_uid`) which are internal Odoo identifiers; these will require joins to the `res_users` table to resolve to human-readable names.
- The `synched` boolean is the primary filter for identifying pending vs. completed synchronization tasks.
- No soft-delete flag is present; assume standard Odoo behavior where records are either present or deleted from the source.
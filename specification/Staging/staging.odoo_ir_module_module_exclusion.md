# odoo_ir_module_module_exclusion

## Source system
This table originates from Odoo ERP. The naming convention `ir_module_module_exclusion` follows Odoo's internal "ir" (Irrelevant/Internal Record) module structure, which manages system-level configurations and module dependencies.

## Functional process 
This table supports the module management and dependency resolution process within the Odoo platform. It tracks exclusion rules between different software modules, ensuring that conflicting or incompatible modules are not installed or activated simultaneously.

## Description
One row in this table represents a single exclusion rule defined between two Odoo modules. This is a raw landed copy of the Odoo system table, intended to provide visibility into module dependency constraints for downstream audit or environment configuration analysis.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.ir_module_module_exclusion_id_seq`. |
| module_id | INTEGER | true | Foreign key to the module being restricted | References the primary module involved in the exclusion. |
| create_uid | INTEGER | true | User ID who created the record | References `res.users`. |
| write_uid | INTEGER | true | User ID who last modified the record | References `res.users`. |
| name | VARCHAR | true | Name or description of the exclusion rule | Likely contains the technical name of the excluded module. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Record last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `module_id` → `staging.ir_module_module.id` (Guess: standard Odoo pattern for linking to the module definition table).
    - `create_uid` → `staging.res_users.id` (Guess: standard Odoo audit column).
    - `write_uid` → `staging.res_users.id` (Guess: standard Odoo audit column).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** Odoo typically uses active/inactive flags (e.g., `active` column) rather than hard deletes; check for an `active` column if filtering for current records, though none is present in this specific schema.
- **Data Integrity:** As this is a staging table, ensure that `module_id` references are validated against the `ir_module_module` table before performing joins.
- **Sensitivity:** No PII is expected in this table, as it contains system configuration metadata.
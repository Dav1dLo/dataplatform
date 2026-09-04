# odoo_ir_model_constraint

## Source system
This table originates from Odoo ERP, a modular business management software. The naming convention `ir_model_constraint` is characteristic of Odoo's internal registry (IR) tables, which manage metadata and database schema constraints within the Odoo framework.

## Functional process 
This table supports the Odoo framework's internal schema management and data integrity process. It tracks database-level constraints (such as unique keys or check constraints) defined on Odoo models, allowing the application to enforce business rules and data validation directly at the database layer.

## Description
One row in this table represents a single database constraint associated with a specific Odoo model. It serves as a raw landed copy of the Odoo `ir_model_constraint` system table, capturing the definition, type, and audit metadata for constraints within the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.ir_model_constraint_id_seq`. |
| model | INTEGER | false | Foreign key to the model | References the `ir_model` table. |
| module | INTEGER | false | Foreign key to the module | References the `ir_module_module` table. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users`. |
| write_uid | INTEGER | true | User ID who last updated the record | References `res_users`. |
| name | VARCHAR | false | Constraint name | The identifier of the constraint in the DB. |
| definition | VARCHAR | true | SQL definition | The raw SQL clause for the constraint. |
| type | VARCHAR(1) | false | Constraint type | 'u' for unique, 'c' for check, etc. |
| message | JSONB | true | Error message | Localized error message for the constraint. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of the last modification. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `model` → `staging.ir_model.id`: Links the constraint to the specific Odoo model definition.
    - `module` → `staging.ir_module_module.id`: Links the constraint to the Odoo module that introduced it.
    - `create_uid` / `write_uid` → `staging.res_users.id`: Links to the user who performed the action.
- **Natural keys (inferred):** 
    - `name`: In Odoo, constraint names are typically unique within the database schema.

## Caveats for downstream consumers

- **Sensitive Data:** Contains `create_uid` and `write_uid`, which link to user identity tables; ensure access is restricted if user PII is exposed in `res_users`.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not implement soft deletes; it reflects the current state of the Odoo system catalog.
- **Data Types:** `definition` and `name` are defined as `VARCHAR` without explicit length; verify actual data distribution if planning to cast to fixed-width types in downstream models.
# odoo_ir_module_module_dependency

## Source system
This table originates from Odoo ERP, specifically the `ir_module_module_dependency` table within the Odoo internal registry. The naming convention `ir_` (Internal Registry) is a standard prefix for Odoo's core metadata and configuration tables.

## Functional process 
This table supports the Odoo module management system, specifically tracking the dependency graph between installed or available modules. It ensures that when a module is installed, all its required prerequisite modules are identified and managed by the system's dependency resolver.

## Description
Each row represents a single dependency relationship where one module requires another module to be present in the system. This is a raw landing of the Odoo metadata table, capturing the structural requirements of the application's modular architecture.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.ir_module_module_dependency_id_seq`. |
| name | VARCHAR | true | Name of the required module | The technical name of the dependency. |
| module_id | INTEGER | true | Foreign key to the parent module | References the module that holds this dependency. |
| auto_install_required | BOOLEAN | true | Auto-install flag | Indicates if the dependency is required for auto-installation. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `module_id` → `staging.ir_module_module.id`: This column links the dependency record to the specific module definition that requires it.
- **Natural keys (inferred):** 
    - `(module_id, name)`: The combination of the parent module and the required module name uniquely identifies a dependency edge in the Odoo registry.

## Caveats for downstream consumers

- The `name` column contains the technical string identifier of the dependency (e.g., 'base', 'sale'), not a human-readable display name.
- The `auto_install_required` column defaults to `true` in the source system; nulls should be treated as `true` if performing logic on auto-installation behavior.
- This table is a structural metadata table; it does not contain transactional business data but is critical for understanding the system's configuration state.
- Timestamps are not present in this table; there is no audit trail for when these dependencies were created or modified.
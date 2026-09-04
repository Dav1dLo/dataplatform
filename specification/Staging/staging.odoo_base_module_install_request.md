# odoo_base_module_install_request

## Source system
This table originates from Odoo ERP. The naming convention `base_module_install_request` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of the Odoo framework's internal module management and installation tracking system.

## Functional process 
This table supports the administrative process of tracking requests to install or update software modules within the Odoo environment. It captures the intent and context behind module installation requests, linking specific users to the modules they have requested to install.

## Description
One row in this table represents a single request for a module installation or update, including the associated user and the HTML-formatted body of the request. As a staging table, it serves as a raw, landed copy of the Odoo `base.module.install.request` model, intended for use in downstream transformation pipelines.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by sequence `base_module_install_request_id_seq`. |
| module_id | INTEGER | false | Foreign key to the requested module | References the Odoo `ir.module.module` table. |
| user_id | INTEGER | false | Foreign key to the requesting user | References the Odoo `res.users` table. |
| create_uid | INTEGER | true | ID of the user who created the record | Audit field for record creation. |
| write_uid | INTEGER | true | ID of the user who last updated the record | Audit field for record modification. |
| body_html | TEXT | true | HTML content of the request | Contains descriptive text or logs regarding the install request. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC. |
| write_date | TIMESTAMP | true | Timestamp of last record update | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `module_id` → `ir_module_module.id` (Standard Odoo naming convention for module references).
    - `user_id` → `res_users.id` (Standard Odoo naming convention for user references).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `body_html` column may contain internal system logs or user-provided notes that could inadvertently expose system paths or user information.
- **Timestamps:** All `TIMESTAMP` fields are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Retention:** This table represents a raw landing; it does not explicitly indicate if it implements soft deletes. Check for an `active` column in the source system if filtering for active requests is required.
- **Precision:** `INTEGER` types are standard 32-bit integers; `TEXT` fields have no length limit.
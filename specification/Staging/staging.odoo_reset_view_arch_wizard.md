# odoo_reset_view_arch_wizard

## Source system
This table originates from Odoo ERP. The naming convention `reset_view_arch_wizard` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's transient model architecture used for UI-driven wizard processes.

## Functional process 
This table supports the "View Architecture Reset" process, which allows administrators to revert customized UI views back to their original state. It tracks the configuration of the reset operation, specifically identifying which view is being reset and the mode of the reset operation.

## Description
One row represents a single instance of a view architecture reset wizard session initiated by a user. This is a raw landing table in the staging layer, capturing the state of the wizard configuration before the reset action is applied to the system metadata.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.reset_view_arch_wizard_id_seq`. |
| view_id | INTEGER | true | Foreign key to the view being reset | References the `ir_ui_view` table in Odoo. |
| compare_view_id | INTEGER | true | Foreign key to the comparison view | Used if the reset involves comparing against a baseline view. |
| create_uid | INTEGER | true | User ID who initiated the wizard | References `res_users` table. |
| write_uid | INTEGER | true | User ID who last modified the wizard record | References `res_users` table. |
| reset_mode | VARCHAR | false | The method or scope of the reset | Likely defines if the reset is 'soft' or 'hard' (full revert). |
| create_date | TIMESTAMP | true | Timestamp of wizard creation | Inferred UTC. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Inferred UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `view_id` → `ir_ui_view.id` (Inferred from Odoo naming conventions for view references).
    - `compare_view_id` → `ir_ui_view.id` (Inferred from Odoo naming conventions for view references).
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table represents a "wizard" state; records may be transient and could be purged or archived by the source system after the reset process completes.
- No PII is explicitly present, but `create_uid` and `write_uid` link to user identity tables which may contain sensitive information.
- The `reset_mode` column is a `VARCHAR` without a defined length; downstream consumers should account for variable string lengths.
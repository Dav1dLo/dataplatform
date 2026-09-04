# odoo_ir_act_server

## Source system
This table originates from the Odoo ERP system. The naming convention `ir_act_server` corresponds to the standard Odoo "Server Actions" model, which manages automated actions, server-side scripts, and workflow triggers within the Odoo framework.

## Functional process 
This table supports the Odoo automation and workflow engine. It stores definitions for server-side actions that can be triggered by user interface events, scheduled tasks, or automated triggers, allowing for dynamic execution of code, email/SMS dispatch, or data updates across the ERP modules.

## Description
One row represents a single server action definition, including its execution logic, target model, and configuration parameters. This is a raw landed copy of the Odoo `ir_act_server` table, serving as the staging entity for auditing and analyzing automated business processes configured within the ERP.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| binding_model_id | INTEGER | true | Target model for action binding | Links to `ir_model`. |
| create_uid | INTEGER | true | User ID who created the action | Links to `res_users`. |
| write_uid | INTEGER | true | User ID who last modified the action | Links to `res_users`. |
| type | VARCHAR | false | Action type identifier | e.g., 'code', 'email', 'sms'. |
| path | VARCHAR | true | URL path for web-based actions | |
| binding_type | VARCHAR | false | Binding type (e.g., 'action', 'report') | |
| binding_view_types | VARCHAR | true | Comma-separated view types | |
| name | JSONB | false | Action display name | Multi-language support via JSONB. |
| help | JSONB | true | Action description/help text | Multi-language support via JSONB. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Record last modification timestamp | UTC assumed. |
| sequence | INTEGER | true | Execution order sequence | |
| model_id | INTEGER | false | Primary model associated with action | Links to `ir_model`. |
| crud_model_id | INTEGER | true | Model for CRUD operations | |
| link_field_id | INTEGER | true | Field ID for linking | |
| update_field_id | INTEGER | true | Field ID for updates | |
| update_related_model_id | INTEGER | true | Related model for updates | |
| selection_value | INTEGER | true | Selection field value | |
| usage | VARCHAR | false | Usage context (e.g., 'ir_actions_server') | |
| state | VARCHAR | false | Action state/status | |
| model_name | VARCHAR | true | Technical name of the model | |
| update_path | VARCHAR | true | Path for update operations | |
| update_m2m_operation | VARCHAR | true | Many-to-many operation type | |
| update_boolean_value | VARCHAR | true | Boolean value for updates | |
| evaluation_type | VARCHAR | true | Evaluation logic type | |
| resource_ref | VARCHAR | true | Resource reference string | |
| webhook_url | VARCHAR | true | Webhook endpoint URL | |
| code | TEXT | true | Python code block to execute | Sensitive: contains executable logic. |
| value | TEXT | true | Action value/payload | |
| template_id | INTEGER | true | Email template ID | Links to `mail_template`. |
| activity_type_id | INTEGER | true | Activity type ID | Links to `mail_activity_type`. |
| activity_date_deadline_range | INTEGER | true | Deadline range value | |
| activity_user_id | INTEGER | true | Assigned user ID | Links to `res_users`. |
| mail_post_method | VARCHAR | true | Email posting method | |
| activity_summary | VARCHAR | true | Activity summary text | |
| activity_date_deadline_range_type | VARCHAR | true | Deadline range unit | |
| activity_user_type | VARCHAR | true | Activity assignment type | |
| activity_user_field_name | VARCHAR | true | Field name for user assignment | |
| activity_note | TEXT | true | Activity notes | |
| mail_post_autofollow | BOOLEAN | true | Auto-follow flag | |
| sms_template_id | INTEGER | true | SMS template ID | Links to `sms_template`. |
| sms_method | VARCHAR | true | SMS sending method | |
| website_path | VARCHAR | true | Website URL path | |
| website_published | BOOLEAN | true | Published status | |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Inferred from Odoo standard naming)
    - `write_uid` → `res_users.id` (Inferred from Odoo standard naming)
    - `model_id` → `ir_model.id` (Inferred from Odoo standard naming)
    - `template_id` → `mail_template.id` (Inferred from Odoo standard naming)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** The `code` column contains raw Python logic that may perform sensitive operations or expose internal system details; treat as high-risk.
- **Timestamps:** All `create_date` and `write_date` values are assumed to be in UTC, consistent with Odoo's internal storage.
- **JSONB:** The `name` and `help` columns are `JSONB` and likely contain localized strings (e.g., `{"en_US": "Action Name", "fr_FR": "Nom de l'action"}`).
- **Soft Deletes:** This table does not explicitly implement a soft-delete flag; assume rows are physically removed if deleted in the source.
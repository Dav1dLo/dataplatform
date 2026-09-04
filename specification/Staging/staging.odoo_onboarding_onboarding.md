# odoo_onboarding_onboarding

## Source system
This table originates from Odoo ERP. The naming convention `odoo_onboarding_onboarding` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and `JSONB` fields (common in Odoo for multi-language support) are characteristic of the Odoo framework's internal metadata tables.

## Functional process 
This table supports the user onboarding and configuration guidance process within the Odoo interface. It tracks the state and display configuration of onboarding panels or widgets shown to users, managing the sequence of steps, the text displayed upon completion, and the actions triggered when a user closes an onboarding panel.

## Description
One row in this table represents a single onboarding configuration entity or panel definition within the Odoo system. It serves as a raw landed copy of the Odoo `onboarding.onboarding` model, capturing the structural definition and audit metadata for onboarding flows.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.onboarding_onboarding_id_seq`. |
| sequence | INTEGER | true | Display order index | Determines the order in which panels appear. |
| create_uid | INTEGER | true | User ID who created the record | References the Odoo `res.users` table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the Odoo `res.users` table. |
| route_name | VARCHAR | false | Internal route identifier | The technical name of the onboarding route. |
| text_completed | VARCHAR | true | Completion message | Text displayed to the user when the onboarding is finished. |
| panel_close_action_name | VARCHAR | true | Action triggered on close | The name of the action executed when the panel is dismissed. |
| name | JSONB | true | Display name | Multi-language label for the onboarding panel. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Inferred UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern).
- **Natural keys (inferred):** 
    - `route_name` (Likely the unique business identifier for the onboarding flow).

## Caveats for downstream consumers

- **PII/Sensitive Data:** The `name` column contains JSONB data which may include localized strings; ensure no user-specific data is embedded in these labels.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are current unless Odoo's internal logic dictates otherwise.
- **JSONB:** The `name` column requires extraction (e.g., `name->>'en_US'`) to be used in downstream reporting.
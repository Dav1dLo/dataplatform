# odoo_onboarding_progress

## Source system
This table originates from Odoo ERP. The naming convention (e.g., `create_uid`, `write_uid`, `write_date`) and the specific structure of the onboarding tracking columns are characteristic of Odoo's internal ORM-managed tables.

## Functional process 
This table supports the customer onboarding and implementation tracking process. It monitors the progress state of new company setups within the ERP, allowing administrators to track which onboarding steps have been completed or closed for specific company entities.

## Description
Each row represents the current onboarding status for a specific company within the Odoo environment. This table acts as a raw landing copy of the Odoo `onboarding.progress` model, capturing the state, closure status, and audit metadata for each onboarding record.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `staging.onboarding_progress_id_seq`. |
| company_id | INTEGER | true | Foreign key to the company | Links to the company entity undergoing onboarding. |
| onboarding_id | INTEGER | false | Identifier for the onboarding process | References the specific onboarding template or flow. |
| create_uid | INTEGER | true | User ID who created the record | References the system user who initiated the onboarding. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user who last modified the status. |
| onboarding_state | VARCHAR | true | Current status of the onboarding | Represents the lifecycle stage (e.g., 'not_started', 'in_progress', 'done'). |
| is_onboarding_closed | BOOLEAN | true | Completion flag | Indicates if the onboarding process has been explicitly closed. |
| create_date | TIMESTAMP | true | Record creation timestamp | In UTC as per Odoo standard. |
| write_date | TIMESTAMP | true | Last modification timestamp | In UTC as per Odoo standard. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Guess: Standard Odoo pattern for company-linked records).
    - `create_uid` → `res_users.id` (Guess: Standard Odoo audit column referencing the user table).
    - `write_uid` → `res_users.id` (Guess: Standard Odoo audit column referencing the user table).
- **Natural keys (inferred):** 
    - `onboarding_id` + `company_id` (Likely unique combination representing a specific company's progress through a specific onboarding flow).

## Caveats for downstream consumers

- **Timestamps:** All `create_date` and `write_date` values are stored in UTC.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume records are hard-deleted if removed from the source.
- **Data Quality:** `company_id` is nullable; records without a company association may represent system-level or orphaned onboarding processes.
- **PII:** This table contains internal audit IDs (`create_uid`, `write_uid`) which, while not direct PII, link to user identity tables.
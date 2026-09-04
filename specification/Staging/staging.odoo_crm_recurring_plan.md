# odoo_crm_recurring_plan

## Source system
This table originates from Odoo ERP, specifically the CRM module. The naming convention (`crm_recurring_plan`) and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal ORM structure.

## Functional process 
This table supports the subscription management and recurring revenue process within the CRM. It defines the available billing cycles or duration plans (e.g., "Monthly", "Quarterly", "Annual") that can be associated with recurring revenue opportunities or contracts.

## Description
One row represents a single recurring billing plan configuration available for use within the CRM module. This is a raw landed copy of the Odoo `crm.recurring.plan` model, serving as a lookup table for subscription duration logic.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.crm_recurring_plan_id_seq`. |
| number_of_months | INTEGER | false | Duration of the plan in months | Defines the interval length for the recurring plan. |
| sequence | INTEGER | true | Display order index | Used by the UI to sort plans in dropdowns. |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the user who last updated the record. |
| name | JSONB | false | Plan name | Multilingual label for the plan; likely contains key-value pairs for different locales. |
| active | BOOLEAN | true | Soft-delete flag | If false, the plan is hidden from the CRM interface. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC based on Odoo standard behavior. |
| write_date | TIMESTAMP | true | Last modification timestamp | Inferred UTC based on Odoo standard behavior. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for audit fields).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for audit fields).
- **Natural keys (inferred):** 
    - `name` (Assuming the name is unique within the Odoo instance configuration).

## Caveats for downstream consumers

- **Sensitive Data:** No PII is present, but `create_uid` and `write_uid` link to internal user identities.
- **Timestamps:** Assumed to be in UTC, consistent with Odoo's default database storage.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should typically filter by `WHERE active = TRUE` to retrieve only current, valid plans.
- **JSONB:** The `name` column is stored as `JSONB`. Downstream consumers will need to use PostgreSQL JSON operators (e.g., `name->>'en_US'`) to extract human-readable strings.
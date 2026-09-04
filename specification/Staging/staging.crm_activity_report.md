# crm_activity_report

## Source system
The table likely originates from an Odoo CRM or similar ERP system, evidenced by the specific naming convention of columns like `mail_activity_type_id`, `partner_id`, and the combination of lead-tracking fields (`lead_create_date`, `stage_id`) alongside activity logging fields.

## Functional process 
This table supports the Sales and Lead Management process, specifically tracking the lifecycle of sales activities and lead progression. It captures the interaction history between users, teams, and potential customers, facilitating reporting on conversion rates, sales velocity, and team performance.

## Description
One row in this table represents a single activity or interaction record associated with a lead or sales opportunity. It serves as a raw landed staging entity, preserving the state of CRM activities at the time of ingestion from the source system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | true | Surrogate primary key | Likely the internal ID from the source system. |
| lead_create_date | TIMESTAMP | true | Lead creation timestamp | UTC assumed. |
| date_conversion | TIMESTAMP | true | Lead-to-opportunity conversion date | Null if not yet converted. |
| date_deadline | DATE | true | Expected completion date | Used for pipeline forecasting. |
| date_closed | TIMESTAMP | true | Activity or lead closure timestamp | |
| subtype_id | INTEGER | true | Activity subtype identifier | Categorizes the specific nature of the activity. |
| mail_activity_type_id | INTEGER | true | Email/Communication type ID | Links to communication templates or categories. |
| author_id | INTEGER | true | ID of the user who created the activity | |
| date | TIMESTAMP | true | Activity occurrence timestamp | |
| body | TEXT | true | Content of the activity/note | May contain unstructured communication logs. |
| lead_id | INTEGER | true | Associated lead identifier | Foreign key to lead entity. |
| user_id | INTEGER | true | Assigned sales representative ID | |
| team_id | INTEGER | true | Sales team identifier | |
| country_id | INTEGER | true | Geographic identifier | |
| company_id | INTEGER | true | Associated company/account ID | |
| stage_id | INTEGER | true | Current pipeline stage ID | |
| partner_id | INTEGER | true | Associated partner/customer ID | |
| lead_type | VARCHAR | true | Classification of the lead | e.g., 'opportunity', 'lead'. |
| active | BOOLEAN | true | Soft-delete flag | True if record is active, false if archived. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `lead_id` → `crm_lead.id` (Likely links to the primary lead record).
    - `user_id` → `res_users.id` (Likely links to the internal system user).
    - `team_id` → `crm_team.id` (Likely links to the sales team definition).
    - `stage_id` → `crm_stage.id` (Likely links to the pipeline stage definition).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `body` column may contain PII or sensitive communication content; ensure appropriate masking if exposing to non-authorized users.
- **Timestamps:** All timestamps are assumed to be in UTC.
- **Soft Deletes:** The `active` column should be used to filter out archived records (i.e., `WHERE active = TRUE`).
- **Data Quality:** As a staging table, expect potential nulls in foreign key fields if the source system allows orphaned records or partial data entry.
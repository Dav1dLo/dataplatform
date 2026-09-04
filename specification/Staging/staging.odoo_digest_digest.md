# odoo_digest_digest

## Source system
This table originates from Odoo ERP, as evidenced by the naming convention (`digest_digest`), the use of `JSONB` for localized names, and the specific set of `kpi_*` boolean flags which correspond to Odoo's automated email digest configuration module.

## Functional process 
This table supports the automated reporting and performance monitoring process within Odoo. It manages the configuration of periodic email digests that summarize key business metrics (KPIs) such as sales, CRM leads, and project tasks for specific companies.

## Description
One row in this table represents a single digest configuration record, defining which KPIs should be included in a periodic summary email and when the next report is scheduled to run. As a staging table, it serves as a raw, direct copy of the Odoo `digest.digest` model, capturing the current state of digest settings.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `staging.digest_digest_id_seq`. |
| company_id | INTEGER | true | Foreign key to the company | Links the digest to a specific Odoo company. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the digest record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| periodicity | VARCHAR | false | Frequency of the digest | Expected values: 'daily', 'weekly', 'monthly'. |
| state | VARCHAR | true | Current status | Likely 'activated' or 'deactivated'. |
| next_run_date | DATE | true | Scheduled execution date | The date the next digest email is triggered. |
| name | JSONB | false | Digest name | Multi-language name stored as JSON. |
| kpi_res_users_connected | BOOLEAN | true | KPI: Users connected | Flag to include user connection stats. |
| kpi_mail_message_total | BOOLEAN | true | KPI: Total messages | Flag to include email/message volume. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the ingestion job. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the ingestion job. |
| kpi_account_total_revenue | BOOLEAN | true | KPI: Total revenue | Flag to include accounting revenue. |
| kpi_crm_lead_created | BOOLEAN | true | KPI: Leads created | Flag to include CRM lead generation stats. |
| kpi_crm_opportunities_won | BOOLEAN | true | KPI: Opportunities won | Flag to include CRM win rate stats. |
| kpi_project_task_opened | BOOLEAN | true | KPI: Tasks opened | Flag to include project management stats. |
| kpi_pos_total | BOOLEAN | true | KPI: POS total | Flag to include Point of Sale revenue. |
| kpi_all_sale_total | BOOLEAN | true | KPI: Total sales | Flag to include overall sales volume. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Standard Odoo multi-company architecture).
    - `create_uid` / `write_uid` → `res_users.id` (Standard Odoo user tracking).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need masking if exposed to non-admin reporting roles.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database storage.
- **Soft Deletes:** Odoo typically uses `active` flags for soft deletes; since no `active` column is present, assume this table contains only active or current records as provided by the source extract.
- **JSONB:** The `name` column requires `->>` or `->` operators to extract specific language values (e.g., `name->>'en_US'`).
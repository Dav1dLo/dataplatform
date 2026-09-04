# odoo_privacy_lookup_wizard

## Source system
This table originates from Odoo ERP. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the specific table name structure are characteristic of Odoo's internal ORM-managed models, which track administrative or utility wizard processes.

## Functional process 
This table supports the GDPR/Privacy compliance process within the ERP, specifically the "Right to be Forgotten" or data subject access request (DSAR) lookup functionality. It tracks the execution of privacy lookup wizards initiated by users to identify or anonymize personal data associated with a specific email address.

## Description
One row in this table represents a single execution instance of a privacy lookup wizard session. It acts as a raw landing record of the audit trail for privacy-related data queries, capturing who initiated the request, the target email, and the resulting execution logs.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence. |
| log_id | INTEGER | true | Reference to a related audit log | Likely links to a broader system audit trail. |
| create_uid | INTEGER | true | User ID who created the record | References the `res_users` table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the `res_users` table. |
| name | VARCHAR | false | Name of the lookup session | Typically a descriptive label or identifier for the wizard run. |
| email | VARCHAR | false | Target email address | The subject of the privacy lookup request. |
| execution_details | TEXT | true | Log output or status summary | Contains technical details or results of the lookup. |
| create_date | TIMESTAMP | true | Record creation timestamp | In UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | In UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo pattern for record ownership).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for record modification).
- **Natural keys (inferred):** Not confidently inferable. While `email` is present, multiple lookup sessions may exist for the same email over time.

## Caveats for downstream consumers

- **PII:** The `email` column contains personally identifiable information and should be masked or restricted according to data privacy policies.
- **Timestamps:** All `_date` columns are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Retention:** This table represents a transactional log of wizard executions; there is no evidence of soft-delete flags, implying rows are likely immutable once created.
- **Type Precision:** The `VARCHAR` and `TEXT` types do not specify length constraints in the source metadata; downstream consumers should handle variable-length strings defensively.
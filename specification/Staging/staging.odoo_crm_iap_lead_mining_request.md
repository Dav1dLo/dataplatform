# odoo_crm_iap_lead_mining_request

## Source system
This table originates from Odoo ERP, specifically the CRM module's In-App Purchase (IAP) lead mining feature. The naming convention `crm_iap_lead_mining_request` and the presence of Odoo-standard audit columns like `create_uid`, `write_uid`, and `*_date` are characteristic of Odoo's internal data structures.

## Functional process 
This table supports the lead generation and prospecting pipeline. It tracks requests sent to Odoo's IAP service to fetch external lead data based on specific firmographic and demographic criteria, such as company size, contact roles, and seniority levels.

## Description
One row in this table represents a single lead mining request submitted by a user to the Odoo IAP service. It acts as a raw landing record in the staging layer, capturing the configuration parameters of the search and the current processing state of the request.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `crm_iap_lead_mining_request_id_seq`. |
| lead_number | INTEGER | false | Count of leads requested | The target quantity of leads for this mining session. |
| team_id | INTEGER | true | Sales team identifier | Foreign key to the CRM team responsible for the request. |
| user_id | INTEGER | true | Owner user identifier | Foreign key to the user who initiated the request. |
| company_size_min | INTEGER | true | Minimum company size | Lower bound for firmographic filtering. |
| company_size_max | INTEGER | true | Maximum company size | Upper bound for firmographic filtering. |
| contact_number | INTEGER | true | Requested contact count | Number of contacts to retrieve per lead. |
| preferred_role_id | INTEGER | true | Target role identifier | Foreign key to the preferred job role filter. |
| seniority_id | INTEGER | true | Target seniority identifier | Foreign key to the seniority level filter. |
| create_uid | INTEGER | true | Creator user ID | Audit field for record creation. |
| write_uid | INTEGER | true | Last modifier user ID | Audit field for record modification. |
| name | VARCHAR | false | Request description | Human-readable name or label for the mining request. |
| state | VARCHAR | false | Processing status | Current lifecycle state (e.g., 'draft', 'done', 'error'). |
| search_type | VARCHAR | false | Search category | Defines the scope or method of the lead mining search. |
| error_type | VARCHAR | true | Error description | Populated if the IAP request failed. |
| lead_type | VARCHAR | false | Lead classification | Categorization of the lead (e.g., 'lead', 'opportunity'). |
| contact_filter_type | VARCHAR | true | Contact filter strategy | Defines how contacts are filtered during the search. |
| filter_on_size | BOOLEAN | true | Size filter toggle | Flag indicating if company size constraints are applied. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Modification timestamp | UTC timestamp of last update. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `team_id` → `crm_team.id` (Likely reference to the Odoo CRM team table).
    - `user_id` → `res_users.id` (Likely reference to the Odoo system users table).
    - `create_uid` → `res_users.id` (Standard Odoo audit reference).
    - `write_uid` → `res_users.id` (Standard Odoo audit reference).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user identifiers (`user_id`, `create_uid`, `write_uid`) which may need to be mapped to anonymized IDs if PII policies require.
- **Timestamps:** Assumed to be in UTC, consistent with Odoo's standard database configuration.
- **Soft Deletes:** Odoo typically does not use soft-delete flags in this table; records are generally permanent unless purged by system maintenance.
- **Data Quality:** The `error_type` column should be monitored to identify failed mining requests that may result in missing lead data downstream.
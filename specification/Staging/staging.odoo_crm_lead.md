# odoo_crm_lead

## Source system
This table originates from Odoo ERP, specifically the CRM module. The naming conventions (e.g., `crm_lead_id_seq`, `partner_id`, `stage_id`, `create_uid`) and the specific structure of lead management fields are characteristic of the Odoo `crm.lead` model.

## Functional process 
This table supports the Lead-to-Opportunity pipeline. It tracks the lifecycle of sales leads and opportunities, capturing marketing attribution (`campaign_id`, `source_id`), sales team assignment (`team_id`, `user_id`), financial forecasting (`expected_revenue`, `recurring_revenue`), and contact details.

## Description
One row represents a single lead or opportunity within the Odoo CRM system. It captures the current state of the prospect, including contact information, sales stage, and associated revenue metrics. This table serves as a raw landed copy of the Odoo `crm.lead` model, intended for use in the staging layer for downstream transformation.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| campaign_id | INTEGER | true | Marketing campaign ID | Foreign key to marketing campaign. |
| source_id | INTEGER | true | Marketing source ID | Foreign key to marketing source. |
| medium_id | INTEGER | true | Marketing medium ID | Foreign key to marketing medium. |
| message_bounce | INTEGER | true | Bounce count | Number of bounced emails. |
| user_id | INTEGER | true | Salesperson ID | Owner of the lead. |
| team_id | INTEGER | true | Sales team ID | Assigned sales team. |
| company_id | INTEGER | true | Company ID | Multi-company context. |
| stage_id | INTEGER | true | Pipeline stage ID | Current stage in the sales funnel. |
| color | INTEGER | true | UI color index | Used for Kanban board visualization. |
| recurring_plan | INTEGER | true | Recurring revenue plan ID | Link to subscription plan. |
| partner_id | INTEGER | true | Customer/Partner ID | Link to the related contact/company. |
| title | INTEGER | true | Honorific title ID | e.g., Mr., Ms. |
| lang_id | INTEGER | true | Language ID | Preferred language. |
| state_id | INTEGER | true | State/Province ID | Geographic region. |
| country_id | INTEGER | true | Country ID | Geographic country. |
| lost_reason_id | INTEGER | true | Lost reason ID | Reason for lost opportunity. |
| create_uid | INTEGER | true | Creator user ID | User who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | User who last updated the record. |
| phone_sanitized | VARCHAR | true | Sanitized phone number | E.164 formatted phone. |
| email_normalized | VARCHAR | true | Normalized email | Lowercase/cleaned email. |
| email_cc | VARCHAR | true | CC email addresses | Comma-separated list. |
| name | VARCHAR | false | Lead/Opportunity name | Subject or title of the lead. |
| referred | VARCHAR | true | Referral source | Free-text referral info. |
| type | VARCHAR | false | Record type | 'lead' or 'opportunity'. |
| priority | VARCHAR | true | Priority level | e.g., 0-3 stars. |
| contact_name | VARCHAR | true | Contact person name | Individual name. |
| partner_name | VARCHAR | true | Company name | Business entity name. |
| function | VARCHAR | true | Job title | Role of the contact. |
| email_from | VARCHAR | true | Sender email | Original email address. |
| email_domain_criterion | VARCHAR | true | Domain filter | Used for deduplication. |
| phone | VARCHAR | true | Phone number | Raw phone string. |
| mobile | VARCHAR | true | Mobile number | Raw mobile string. |
| phone_state | VARCHAR | true | Phone validation status | e.g., 'correct', 'incorrect'. |
| email_state | VARCHAR | true | Email validation status | e.g., 'correct', 'incorrect'. |
| website | VARCHAR | true | Website URL | Prospect website. |
| street | VARCHAR | true | Address line 1 | |
| street2 | VARCHAR | true | Address line 2 | |
| zip | VARCHAR | true | Postal code | |
| city | VARCHAR | true | City name | |
| date_deadline | DATE | true | Expected closing date | |
| lead_properties | JSONB | true | Custom properties | Flexible metadata storage. |
| description | TEXT | true | Internal notes | |
| expected_revenue | NUMERIC | true | Expected revenue | Currency units. |
| prorated_revenue | NUMERIC | true | Prorated revenue | |
| recurring_revenue | NUMERIC | true | Recurring revenue | |
| recurring_revenue_monthly | NUMERIC | true | Monthly recurring revenue | |
| recurring_revenue_monthly_prorated | NUMERIC | true | Monthly prorated MRR | |
| recurring_revenue_prorated | NUMERIC | true | Prorated recurring revenue | |
| active | BOOLEAN | true | Active flag | Soft-delete indicator. |
| date_closed | TIMESTAMP | true | Closing date | |
| date_automation_last | TIMESTAMP | true | Last automation run | |
| date_open | TIMESTAMP | true | Date opened | |
| date_last_stage_update | TIMESTAMP | true | Last stage change date | |
| date_conversion | TIMESTAMP | true | Conversion date | Lead to opportunity. |
| create_date | TIMESTAMP | true | Creation timestamp | |
| write_date | TIMESTAMP | true | Last update timestamp | |
| day_open | DOUBLE PRECISION | true | Days to open | |
| day_close | DOUBLE PRECISION | true | Days to close | |
| probability | DOUBLE PRECISION | true | Success probability | 0.0 to 100.0. |
| automated_probability | DOUBLE PRECISION | true | System-calculated probability | |
| reveal_id | VARCHAR | true | Reveal ID | External enrichment ID. |
| iap_enrich_done | BOOLEAN | true | Enrichment status | In-App Purchase enrichment. |
| lead_mining_request_id | INTEGER | true | Lead mining request ID | |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `res_users.id` (Guess: links to system users)
    - `team_id` → `crm_team.id` (Guess: links to sales teams)
    - `partner_id` → `res_partner.id` (Guess: links to customer master)
    - `stage_id` → `crm_stage.id` (Guess: links to pipeline stages)
- **Natural keys (inferred):** 
    - None confidently inferable; Odoo typically relies on the surrogate `id` for internal linking.

## Caveats for downstream consumers

- **Sensitive Data:** Contains PII including `email_from`, `phone`, `mobile`, `street`, and `contact_name`. Masking is recommended for non-authorized users.
- **Timestamps:** All `TIMESTAMP` columns are assumed to be in UTC, consistent with standard Odoo deployments.
- **Soft Deletes:** The `active` column acts as a soft-delete flag. Queries should generally filter by `WHERE active = TRUE` unless performing audit or historical analysis.
- **Revenue:** Financial columns (`expected_revenue`, etc.) are `NUMERIC`. Ensure downstream models handle currency conversion if the Odoo instance is multi-currency.
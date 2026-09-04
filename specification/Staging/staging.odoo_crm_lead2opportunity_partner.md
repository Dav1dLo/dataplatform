# odoo_crm_lead2opportunity_partner

## Source system
This table originates from Odoo ERP, specifically the CRM module. The naming convention `crm_lead2opportunity_partner` and the presence of columns like `lead_id`, `partner_id`, and `team_id` are characteristic of Odoo's internal relational mapping for the lead-to-opportunity conversion wizard.

## Functional process 
This table supports the lead-to-opportunity conversion process within the CRM pipeline. It tracks the transient data or configuration settings used when a sales representative converts a lead into an opportunity, including the assignment of the partner (customer), the sales team, and the responsible user.

## Description
One row in this table represents a single execution or configuration instance of the lead-to-opportunity conversion wizard. It acts as a staging record capturing the state of the conversion process at a specific point in time. This table serves as a raw landed copy of the Odoo internal wizard state, intended for auditing or tracking conversion history.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `crm_lead2opportunity_partner_id_seq`. |
| lead_id | INTEGER | false | Foreign key to the lead being converted | Links to the source lead record. |
| partner_id | INTEGER | true | Foreign key to the customer partner | The customer record associated with the opportunity. |
| user_id | INTEGER | true | Foreign key to the assigned salesperson | The user responsible for the resulting opportunity. |
| team_id | INTEGER | true | Foreign key to the sales team | The CRM team assigned to the opportunity. |
| create_uid | INTEGER | true | Foreign key to the creator user | The user who initiated the conversion. |
| write_uid | INTEGER | true | Foreign key to the last modifier user | The user who last updated this record. |
| name | VARCHAR | true | Name of the conversion action | Descriptive label for the conversion event. |
| action | VARCHAR | true | Conversion action type | Defines the specific logic applied during conversion. |
| force_assignment | BOOLEAN | true | Assignment override flag | Indicates if the assignment was forced manually. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Inferred UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `lead_id` → `crm_lead.id` (Standard Odoo CRM relationship).
    - `partner_id` → `res_partner.id` (Standard Odoo partner relationship).
    - `user_id` → `res_users.id` (Standard Odoo user relationship).
    - `team_id` → `crm_team.id` (Standard Odoo CRM team relationship).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are assumed to be in UTC, consistent with Odoo's standard database configuration.
- **Data Sensitivity:** Contains user IDs and partner IDs; ensure appropriate access controls are applied when joining with PII-heavy tables.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume records are immutable once the conversion wizard process is completed.
- **Precision:** `VARCHAR` lengths were not specified in the source metadata; downstream consumers should handle variable-length strings accordingly.
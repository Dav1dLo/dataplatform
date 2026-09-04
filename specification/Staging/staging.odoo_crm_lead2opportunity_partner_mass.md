# odoo_crm_lead2opportunity_partner_mass

## Source system
This table originates from Odoo ERP, specifically the CRM module. The naming convention `crm_lead2opportunity_partner_mass` is characteristic of Odoo's internal wizard or transient models used for bulk processing lead-to-opportunity conversions and partner matching.

## Functional process 
This table supports the lead-to-opportunity conversion pipeline, specifically the "mass" or bulk processing functionality. It tracks the configuration and execution of converting multiple leads into opportunities simultaneously, including logic for deduplication and partner assignment.

## Description
One row in this table represents a single execution or configuration record for a bulk lead-to-opportunity conversion task. It acts as a staging record for the wizard process that maps leads to existing or new partners within the Odoo CRM system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| lead_id | INTEGER | true | Foreign key to the lead being processed | References the source lead record. |
| partner_id | INTEGER | true | Foreign key to the target partner | The partner associated with the opportunity. |
| user_id | INTEGER | true | Foreign key to the assigned salesperson | The user responsible for the resulting opportunity. |
| team_id | INTEGER | true | Foreign key to the sales team | The CRM team handling the conversion. |
| create_uid | INTEGER | true | User ID who created the record | References the system user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user table. |
| name | VARCHAR | true | Descriptive name of the mass action | Often contains a label for the batch process. |
| action | VARCHAR | true | The specific conversion action taken | e.g., 'create', 'merge', or 'link'. |
| force_assignment | BOOLEAN | true | Flag to override existing assignments | If true, forces the partner/user assignment. |
| deduplicate | BOOLEAN | true | Flag to enable deduplication logic | If true, the process checks for existing duplicates. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `lead_id` → `crm_lead.id` (Inferred from Odoo naming conventions)
    - `partner_id` → `res_partner.id` (Inferred from Odoo naming conventions)
    - `user_id` → `res_users.id` (Inferred from Odoo naming conventions)
    - `team_id` → `crm_team.id` (Inferred from Odoo naming conventions)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** All `create_date` and `write_date` values are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Retention:** This table represents a transient/wizard state; rows may be purged or archived by Odoo's internal cleanup routines depending on system configuration.
- **PII:** While this table primarily contains IDs and configuration flags, ensure that any joined `name` or `partner` data is handled according to your organization's PII/GDPR policies.
- **Nullability:** Many fields are nullable as they represent optional configuration parameters for the conversion wizard.
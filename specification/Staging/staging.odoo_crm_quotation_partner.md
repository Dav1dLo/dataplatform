# odoo_crm_quotation_partner

## Source system
This table originates from Odoo ERP, specifically the CRM module. The naming convention `crm_quotation_partner` and the presence of `lead_id` and `partner_id` are characteristic of Odoo's relational structure for linking sales leads or quotations to specific business partners (customers/contacts).

## Functional process 
This table supports the lead-to-cash pipeline by maintaining the association between CRM leads/quotations and the entities (partners) involved in the transaction. It tracks the audit trail of who created or modified these associations and the specific actions taken during the sales qualification or quotation process.

## Description
One row represents a single association record between a CRM lead or quotation and a partner entity. It serves as a raw landing copy of the Odoo database table, capturing the relationship state and audit metadata at the grain of a single link event.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.crm_quotation_partner_id_seq`. |
| lead_id | INTEGER | false | Foreign key to the lead or quotation | Links to the primary CRM document. |
| partner_id | INTEGER | true | Foreign key to the partner | The customer or contact associated with the lead. |
| create_uid | INTEGER | true | User ID who created the record | References the internal Odoo user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the internal Odoo user table. |
| action | VARCHAR | false | Type of action or relationship status | Describes the nature of the link. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC per Odoo standard. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC per Odoo standard. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `lead_id` → `staging.crm_lead.id` (Guess: standard Odoo CRM lead/opportunity reference).
    - `partner_id` → `staging.res_partner.id` (Guess: standard Odoo partner/customer reference).
    - `create_uid` → `staging.res_users.id` (Guess: standard Odoo user reference).
    - `write_uid` → `staging.res_users.id` (Guess: standard Odoo user reference).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC, consistent with Odoo's internal storage format.
- **Data Sensitivity:** Contains internal user IDs (`create_uid`, `write_uid`) which may need to be joined with a user directory to identify specific employees.
- **Soft Deletes:** Odoo often uses `active` flags (not present here); verify if records are physically deleted or if this table represents a historical log.
- **Precision:** `VARCHAR` length for `action` is not specified in the source; downstream consumers should handle variable-length strings safely.
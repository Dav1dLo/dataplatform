# odoo_crm_iap_lead_mining_request_crm_iap_lead_role_rel

## Source system
This table originates from Odoo ERP, specifically the CRM module's "Lead Mining" feature. The naming convention `_rel` combined with the two foreign key columns indicates this is a standard Odoo join table used to manage a many-to-many relationship between lead mining requests and lead roles.

## Functional process 
This table supports the Lead-to-cash pipeline by mapping specific lead mining requests to the roles (e.g., job titles or seniority levels) targeted during the lead generation process. It ensures that a single mining request can be associated with multiple lead roles, and vice versa.

## Description
One row in this table represents a single association between a lead mining request and a specific lead role. It serves as a raw landed junction table in the staging layer, facilitating the resolution of many-to-many relationships for downstream analytical models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| crm_iap_lead_mining_request_id | INTEGER | false | Foreign key to the lead mining request | Links to the parent request entity. |
| crm_iap_lead_role_id | INTEGER | false | Foreign key to the lead role definition | Links to the specific role/title being mined. |

## Keys

- **Primary key (inferred):** The composite of `(crm_iap_lead_mining_request_id, crm_iap_lead_role_id)`.
- **Foreign keys (inferred):** 
    - `crm_iap_lead_mining_request_id` → `crm_iap_lead_mining_request.id`: This column references the primary mining request record.
    - `crm_iap_lead_role_id` → `crm_iap_lead_role.id`: This column references the definition of the lead role.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present in this table; rely on the parent entities for ingestion metadata.
- As a many-to-many relationship table, ensure joins are handled carefully to avoid fan-out effects in downstream reporting.
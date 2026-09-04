# odoo_crm_iap_lead_industry_crm_iap_lead_mining_request_rel

## Source system
This table originates from Odoo ERP, specifically the CRM module's In-App Purchase (IAP) lead mining feature. The naming convention `_rel` and the presence of two foreign key IDs strongly indicate this is a standard Odoo many-to-many join table used to link lead mining requests to specific industry classifications.

## Functional process 
This table supports the lead generation and enrichment process within the CRM. It maps specific lead mining requests (which define search criteria for potential leads) to the industry sectors (e.g., "Software", "Retail") that the user has selected to target during the lead mining operation.

## Description
One row in this table represents a single association between a lead mining request and an industry category. It acts as a junction table to resolve the many-to-many relationship between `crm_iap_lead_mining_request` and `crm_iap_lead_industry`. It serves as a raw landed copy of the Odoo relational mapping.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| crm_iap_lead_mining_request_id | INTEGER | false | Foreign key to the lead mining request | Links to the parent request record. |
| crm_iap_lead_industry_id | INTEGER | false | Foreign key to the industry definition | Links to the specific industry category. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key on (`crm_iap_lead_mining_request_id`, `crm_iap_lead_industry_id`).
- **Foreign keys (inferred):** 
    - `crm_iap_lead_mining_request_id` → `crm_iap_lead_mining_request.id`: This column references the primary request entity.
    - `crm_iap_lead_industry_id` → `crm_iap_lead_industry.id`: This column references the industry lookup table.
- **Natural keys (inferred):** The combination of (`crm_iap_lead_mining_request_id`, `crm_iap_lead_industry_id`) acts as the unique business identifier for the relationship.

## Caveats for downstream consumers

- This is a junction table; it contains no business data other than the relationship between the two entities.
- There are no timestamps or soft-delete flags; if a row is missing, the relationship has been removed in the source system.
- Ensure inner joins are used when aggregating, as this table only exists to facilitate relational lookups.
# odoo_crm_iap_lead_mining_request_res_country_state_rel

## Source system
This table originates from Odoo ERP. The naming convention `crm_iap_lead_mining_request_res_country_state_rel` is characteristic of Odoo's automated many-to-many relationship tables, which link core CRM lead mining requests to geographical state definitions.

## Functional process 
This table supports the Lead-to-cash pipeline by managing the geographical filtering criteria for IAP (In-App Purchase) lead mining requests. It allows the system to associate specific lead generation requests with one or more target states or provinces within a country.

## Description
One row in this table represents a single association between a lead mining request and a specific geographical state. It serves as a raw junction table in the staging layer, enabling the resolution of many-to-many relationships between CRM lead mining configurations and country state entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| crm_iap_lead_mining_request_id | INTEGER | false | Foreign key to the lead mining request | Links to the parent request configuration. |
| res_country_state_id | INTEGER | false | Foreign key to the country state definition | Links to the specific state/province entity. |

## Keys

- **Primary key (inferred):** The combination of `crm_iap_lead_mining_request_id` and `res_country_state_id` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `crm_iap_lead_mining_request_id` → `crm_iap_lead_mining_request.id`: This column references the primary configuration record for the lead mining job.
    - `res_country_state_id` → `res_country_state.id`: This column references the master list of geographical states.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no business data other than the relationship between the two entities.
- There are no timestamps or audit columns present in this table; rely on the parent tables for creation or modification context.
- Ensure that joins to this table are handled as composite joins on both columns to avoid Cartesian products.
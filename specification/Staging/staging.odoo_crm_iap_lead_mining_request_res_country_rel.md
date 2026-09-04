# odoo_crm_iap_lead_mining_request_res_country_rel

## Source system
This table originates from Odoo ERP. The naming convention `crm_iap_lead_mining_request_res_country_rel` is characteristic of Odoo's automated many-to-many relationship tables, which link core CRM lead mining requests to country definitions.

## Functional process 
This table supports the Lead-to-cash pipeline by managing the geographical filtering criteria for IAP (In-App Purchase) lead mining requests. It allows the system to associate specific lead generation campaigns or requests with one or more target countries.

## Description
One row in this table represents a single association between a lead mining request and a target country. It acts as a join table to resolve a many-to-many relationship, ensuring that lead mining activities can be scoped to specific regional markets.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| crm_iap_lead_mining_request_id | INTEGER | false | Foreign key to the lead mining request | Links to the primary request entity. |
| res_country_id | INTEGER | false | Foreign key to the country definition | Links to the master country list. |

## Keys

- **Primary key (inferred):** The composite of `(crm_iap_lead_mining_request_id, res_country_id)`.
- **Foreign keys (inferred):** 
    - `crm_iap_lead_mining_request_id` → `crm_iap_lead_mining_request.id`: This column references the parent lead mining request record.
    - `res_country_id` → `res_country.id`: This column references the standard Odoo country master table.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a link table; queries should expect to perform `JOIN` operations against both the `crm_iap_lead_mining_request` and `res_country` tables to retrieve meaningful business attributes.
- There are no timestamps or soft-delete flags in this table; it reflects the current state of associations as defined in the source Odoo instance.
- Ensure that joins are performed on both columns to avoid Cartesian products when analyzing specific request-to-country mappings.
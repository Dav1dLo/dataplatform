# odoo_crm_lead_crm_lead2opportunity_partner_rel

## Source system
This table originates from Odoo ERP, specifically the CRM module. The naming convention `_rel` and the presence of two foreign key columns indicate this is a standard Odoo many-to-many join table used to link CRM leads to partner (customer) records during the lead-to-opportunity conversion process.

## Functional process 
This table supports the lead-to-opportunity conversion pipeline. It tracks the association between a specific lead record and the partner entity created or linked during the qualification process, ensuring that the sales pipeline maintains a historical link between the initial lead and the resulting business partner.

## Description
One row in this table represents a single relationship link between a CRM lead and a partner record. As a staging table, it provides a raw, un-transformed copy of the join table from the Odoo PostgreSQL database, serving as the base for downstream models that reconstruct the lead-to-customer conversion history.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| crm_lead2opportunity_partner_id | INTEGER | false | Surrogate key for the relationship record | Primary identifier for this specific link. |
| crm_lead_id | INTEGER | false | Foreign key to the CRM lead | References the source lead record. |

## Keys

- **Primary key (inferred):** `crm_lead2opportunity_partner_id`
- **Foreign keys (inferred):** 
    - `crm_lead_id` → `crm_lead.id`: This column links the relationship to the specific lead being converted.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a join table; expect it to be used primarily in `JOIN` operations between lead and partner entities.
- There is no audit timestamp (e.g., `created_at`) provided in this schema; downstream consumers should rely on the parent tables for temporal context.
- The table structure suggests a many-to-many relationship; ensure queries handle potential duplicates if a lead is associated with multiple partners or vice versa.
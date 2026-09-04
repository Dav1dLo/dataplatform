# odoo_crm_lead_website_visitor_rel

## Source system
This table originates from Odoo ERP, specifically the CRM module. The naming convention `crm_lead_website_visitor_rel` is characteristic of Odoo's internal many-to-many relationship tables, which are automatically generated to link CRM leads with website visitor tracking data.

## Functional process 
This table supports the lead attribution and tracking process. It maps anonymous or identified website visitors to specific CRM leads, allowing the sales team to see the web activity history associated with a particular sales opportunity.

## Description
One row in this table represents a single association between a CRM lead and a website visitor record. It serves as a raw junction table in the staging layer, enabling the reconstruction of many-to-many relationships between lead entities and web tracking sessions captured by the Odoo website module.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| crm_lead_id | INTEGER | false | Foreign key to the CRM lead record | Links to the primary lead entity. |
| website_visitor_id | INTEGER | false | Foreign key to the website visitor record | Links to the web tracking session/visitor profile. |

## Keys

- **Primary key (inferred):** The combination of `(crm_lead_id, website_visitor_id)` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `crm_lead_id` → `crm_lead.id`: This column references the unique identifier of a lead in the CRM module.
    - `website_visitor_id` → `website_visitor.id`: This column references the unique identifier of a visitor tracked by the Odoo website module.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; queries should expect a many-to-many relationship between leads and visitors.
- No timestamps are present in this table; temporal analysis of the relationship must be joined through the parent `crm_lead` or `website_visitor` tables.
- This table does not contain PII directly, but it links PII-containing lead records to web tracking data.
- As a raw staging table, it may contain orphaned records if the upstream Odoo system has not enforced referential integrity during data extraction.
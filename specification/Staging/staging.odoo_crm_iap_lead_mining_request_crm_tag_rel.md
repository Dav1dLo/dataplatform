# odoo_crm_iap_lead_mining_request_crm_tag_rel

## Source system
Odoo ERP. The naming convention `_rel` combined with the specific module prefix `crm_iap_lead_mining_request` strongly indicates this is a standard Odoo many-to-many join table used to link lead mining requests to CRM tags.

## Functional process 
This table supports the Lead-to-Cash pipeline by managing the categorization of automated lead generation requests. It allows multiple CRM tags (e.g., "Cold Lead", "High Priority", "Industry-Specific") to be associated with a single IAP (In-App Purchase) lead mining request, facilitating downstream segmentation and lead routing.

## Description
One row in this table represents a single association between a specific lead mining request and a CRM tag. This is a junction table at the staging layer, providing a raw, normalized link between the lead mining request entity and the tag entity.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| crm_iap_lead_mining_request_id | INTEGER | false | Foreign key to the lead mining request. | Links to the primary request record. |
| crm_tag_id | INTEGER | false | Foreign key to the CRM tag definition. | Identifies the tag applied to the request. |

## Keys

- **Primary key (inferred):** The composite key `(crm_iap_lead_mining_request_id, crm_tag_id)` is the inferred primary key.
- **Foreign keys (inferred):** 
    - `crm_iap_lead_mining_request_id` → `crm_iap_lead_mining_request.id`: This column references the parent lead mining request record.
    - `crm_tag_id` → `crm_tag.id`: This column references the definition of the CRM tag.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or soft-delete flags present; assume this table reflects the current state of associations as captured during the last ingestion.
- Ensure inner joins are used when filtering by both request and tag to avoid orphaned records if the source system has referential integrity gaps.
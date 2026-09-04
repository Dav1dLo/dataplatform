# odoo_crm_tag_rel

## Source system
This table originates from Odoo ERP, specifically the CRM module. The naming convention `_rel` is characteristic of Odoo's internal implementation for many-to-many relationship tables, which are used to link CRM leads to their associated tags.

## Functional process 
This table supports the lead management and categorization process. It maintains the association between CRM leads and user-defined tags, allowing for the segmentation and filtering of sales opportunities within the pipeline.

## Description
One row in this table represents a single association between a CRM lead and a specific tag. It is a raw landed copy of an Odoo join table, serving as the bridge to resolve the many-to-many relationship between leads and tags in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| lead_id | INTEGER | false | Foreign key to the lead record | Links to the primary key of the CRM lead table. |
| tag_id | INTEGER | false | Foreign key to the tag definition | Links to the primary key of the CRM tag definition table. |

## Keys

- **Primary key (inferred):** The composite key `(lead_id, tag_id)` is the inferred primary key, as this is a standard join table structure.
- **Foreign keys (inferred):** 
    - `lead_id` → `crm_lead.id`: This column references the unique identifier of the lead record.
    - `tag_id` → `crm_tag.id`: This column references the unique identifier of the tag definition.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; incremental loading must rely on the source system's replication logic or full table refreshes.
- Ensure that joins to this table are handled as inner joins unless you are specifically looking for leads without tags (which would require a left join from the lead table).
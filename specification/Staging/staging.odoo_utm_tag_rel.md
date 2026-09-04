# odoo_utm_tag_rel

## Source system
This table originates from Odoo, an open-source ERP and CRM platform. The naming convention `utm_tag_rel` is characteristic of Odoo's internal relational mapping tables, which are used to manage many-to-many relationships between marketing entities (UTM tags and campaigns).

## Functional process 
This table supports the marketing attribution and campaign management process. It acts as a junction table that links specific UTM tags to marketing campaigns, allowing a single campaign to be associated with multiple tags (and vice versa) for granular performance tracking and segmentation.

## Description
One row in this table represents a single association between a specific UTM tag and a marketing campaign. It serves as a raw, normalized junction record within the staging layer, facilitating the reconstruction of many-to-many relationships between marketing metadata entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| tag_id | INTEGER | false | Foreign key to the UTM tag definition | Links to the primary key of the `utm_tag` table. |
| campaign_id | INTEGER | false | Foreign key to the marketing campaign | Links to the primary key of the `utm_campaign` table. |

## Keys

- **Primary key (inferred):** The combination of `(tag_id, campaign_id)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `tag_id` → `utm_tag.id`: This column references the unique identifier for a UTM tag.
    - `campaign_id` → `utm_campaign.id`: This column references the unique identifier for a marketing campaign.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only relational keys.
- There are no timestamps or audit columns present; incremental loading logic should rely on upstream source system logs or full-table refreshes.
- Ensure that joins to `utm_tag` and `utm_campaign` handle potential orphans if the source system's referential integrity is not strictly enforced.
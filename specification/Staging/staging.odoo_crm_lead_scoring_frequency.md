# odoo_crm_lead_scoring_frequency

## Source system
This table originates from Odoo CRM. The naming convention (`crm_lead_scoring_frequency`), the presence of Odoo-standard audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`), and the specific functional focus on lead scoring metrics strongly indicate an Odoo ERP/CRM backend.

## Functional process 
This table supports the lead scoring and qualification process within the CRM. It tracks the frequency of specific variables and values associated with lead outcomes (won vs. lost), allowing the system to calculate conversion probabilities or scoring weights for incoming leads based on historical performance.

## Description
One row in this table represents a specific frequency metric for a lead scoring variable (e.g., a specific industry or source) within a sales team. It acts as a raw landed copy of the Odoo `crm.lead.scoring.frequency` model, capturing the counts of won and lost leads associated with a particular attribute value to inform predictive lead scoring models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `crm_lead_scoring_frequency_id_seq`. |
| team_id | INTEGER | true | Foreign key to the sales team | Links the frequency metric to a specific CRM sales team. |
| create_uid | INTEGER | true | Creator user ID | References the user who created this record. |
| write_uid | INTEGER | true | Last updater user ID | References the user who last modified this record. |
| variable | VARCHAR | true | Scoring variable name | The attribute being measured (e.g., 'country_id', 'source_id'). |
| value | VARCHAR | true | Attribute value | The specific value of the variable being tracked. |
| won_count | NUMERIC | true | Count of won leads | Number of leads with this attribute that resulted in a 'won' stage. |
| lost_count | NUMERIC | true | Count of lost leads | Number of leads with this attribute that resulted in a 'lost' stage. |
| create_date | TIMESTAMP | true | Record creation timestamp | In UTC as per Odoo standard. |
| write_date | TIMESTAMP | true | Last modification timestamp | In UTC as per Odoo standard. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `team_id` → `crm_team.id` (Likely target based on Odoo standard schema).
    - `create_uid` → `res_users.id` (Standard Odoo audit link).
    - `write_uid` → `res_users.id` (Standard Odoo audit link).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined to a user directory to identify individuals.
- **Timezone:** Timestamps are stored in UTC, consistent with Odoo's internal storage format.
- **Data Quality:** `won_count` and `lost_count` are `NUMERIC` types; ensure downstream aggregations handle potential nulls as zeros if necessary.
- **Soft Deletes:** This table does not appear to have an `active` boolean flag, which is common in Odoo; assume all rows are currently active unless otherwise specified by the source system logic.
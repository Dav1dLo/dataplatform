# odoo_crm_iap_lead_industry

## Source system
This table originates from Odoo ERP, specifically the CRM module's "In-App Purchase" (IAP) lead enrichment service. The naming convention `crm_iap_lead_industry` and the presence of Odoo-standard audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal data structures.

## Functional process 
This table supports the lead enrichment and segmentation process within the Odoo CRM. It stores industry classifications used to categorize leads generated or enriched via Odoo's IAP services, allowing sales teams to filter and prioritize prospects based on their business sector.

## Description
One row in this table represents a single industry category definition used for lead enrichment. It serves as a raw landed copy of the Odoo configuration table, capturing the metadata required to map external lead data to internal industry segments.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.crm_iap_lead_industry_id_seq`. |
| color | INTEGER | true | UI color index | Used for visual representation in the Odoo frontend. |
| sequence | INTEGER | true | Sort order | Determines the display order of industries in dropdowns. |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who created this record. |
| write_uid | INTEGER | true | Last updater user ID | Reference to the user who last modified this record. |
| reveal_ids | VARCHAR | false | IAP mapping IDs | Likely a comma-separated list of IDs used by the IAP service for matching. |
| name | JSONB | false | Industry name | Multilingual name stored as a JSON object (e.g., `{"en_US": "Technology"}`). |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the Odoo application. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the Odoo application. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for record ownership).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for record modification).
- **Natural keys (inferred):** 
    - `reveal_ids` (This acts as the business key for the IAP service integration).

## Caveats for downstream consumers

- **JSONB Handling:** The `name` column is a `JSONB` object. Query writers must use the `->>` operator to extract specific language values (e.g., `name->>'en_US'`).
- **Timestamps:** All `create_date` and `write_date` values are stored in UTC.
- **Data Integrity:** This is a staging table; it may contain historical records or duplicates if the ingestion process is not idempotent.
- **Sensitivity:** No PII is present in this table; it contains configuration and metadata for industry categorization.
# odoo_utm_medium

## Source system
This table originates from Odoo ERP, an open-source business management software. The naming convention `utm_medium` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal ORM-managed tables used for tracking marketing campaign attribution.

## Functional process 
This table supports the marketing attribution and campaign management process. It defines the "medium" (e.g., email, social, cpc) used in UTM parameters to track the source of traffic or leads within the Odoo ecosystem, allowing the business to categorize and report on the effectiveness of various marketing channels.

## Description
One row in this table represents a single marketing medium definition used for tracking campaign traffic. This is a raw landed copy of the Odoo `utm.medium` model, serving as a reference dimension for marketing analytics. It captures the configuration and audit metadata for each medium defined in the source system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.utm_medium_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References the Odoo user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the Odoo user table. |
| name | VARCHAR | false | Name of the marketing medium | The human-readable label (e.g., 'Email', 'Social'). |
| active | BOOLEAN | true | Soft-delete flag | If false, the medium is hidden from UI/selection. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC based on Odoo standard behavior. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC based on Odoo standard behavior. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit column linking to user who created the record).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit column linking to user who last modified the record).
- **Natural keys (inferred):** 
    - `name`: In Odoo, the `name` field for `utm.medium` is typically unique within the system to prevent duplicate attribution categories.

## Caveats for downstream consumers

- **Sensitive Data:** No PII is present in this table.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with Odoo's internal storage format.
- **Soft Deletes:** The `active` column indicates a soft-delete pattern; ensure queries filter by `active = TRUE` if only current, valid media are required.
- **Data Precision:** The `VARCHAR` type for `name` does not specify a length; downstream transformations should account for potential long strings if the source Odoo instance has custom constraints.
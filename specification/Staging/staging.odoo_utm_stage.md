# odoo_utm_stage

## Source system
This table originates from Odoo ERP, specifically the marketing automation or campaign management module. The naming convention (`utm_stage`), the presence of `create_uid`/`write_uid` audit columns, and the use of `JSONB` for the `name` field are characteristic of Odoo's internal ORM structure for tracking UTM campaign stages.

## Functional process 
This table supports the marketing campaign management process by defining the various stages a UTM-tracked campaign can transition through. It is used to categorize marketing efforts and track their progression within the Odoo marketing pipeline.

## Description
One row in this table represents a single stage definition within a UTM campaign workflow. It serves as a raw landed copy of the Odoo `utm.stage` model, capturing the configuration and audit metadata for each stage.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; internal Odoo ID. |
| sequence | INTEGER | true | Display order | Used to sort stages in the UI. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the Odoo res_users table. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the Odoo res_users table. |
| name | JSONB | false | Stage name | Often contains multi-language translations in Odoo. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **PII/Sensitivity:** No direct PII, but `create_uid` and `write_uid` link to internal user identities.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with Odoo's default database storage.
- **Data Format:** The `name` column is `JSONB`; downstream queries will likely need to use the `->>` operator (e.g., `name->>'en_US'`) to extract human-readable strings.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume rows are physically removed if deleted in the source.
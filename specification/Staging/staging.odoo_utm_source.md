# odoo_utm_source

## Source system
This table originates from Odoo, an open-source ERP and CRM platform. The naming convention (`utm_source`, `create_uid`, `write_uid`) and the use of Odoo-specific sequence patterns (`nextval('staging.utm_source_id_seq'::regclass)`) are characteristic of Odoo's internal database schema for tracking marketing campaign sources.

## Functional process 
This table supports the marketing attribution and lead tracking process. It acts as a lookup table for UTM source parameters (e.g., "google", "newsletter", "social_media") used across the Odoo ecosystem to identify the origin of incoming traffic or leads, allowing the system to aggregate performance metrics by source.

## Description
One row in this table represents a unique marketing source entity defined within the Odoo system. It serves as a raw landed copy of the source configuration, providing the master list of UTM sources used for tracking campaign effectiveness.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.utm_source_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References the Odoo `res_users` table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the Odoo `res_users` table. |
| name | VARCHAR | false | The human-readable name of the UTM source | This is the business identifier used in tracking URLs. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC; Odoo standard. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC; Odoo standard. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit column for record creation).
    - `write_uid` → `res_users.id` (Standard Odoo audit column for record modification).
- **Natural keys (inferred):** 
    - `name` (The unique string identifier for the marketing source).

## Caveats for downstream consumers

- **Timestamps:** Timestamps are assumed to be in UTC, consistent with Odoo's default application behavior.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records present are currently active in the source system.
- **Data Integrity:** The `name` column is the business-critical field for joins with web traffic or lead tables; ensure case sensitivity is handled if the source system allows variations (e.g., "Google" vs "google").
- **Audit Columns:** `create_uid` and `write_uid` are internal Odoo user IDs and will not resolve to meaningful names without joining against the `res_users` table.
# odoo_website_route

## Source system
This table originates from Odoo, an open-source ERP and CRM platform. The naming convention (`website_route`), the presence of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`), and the use of Odoo-style sequence generators for the primary key are characteristic of Odoo's internal PostgreSQL schema.

## Functional process 
This table supports the website routing and URL management process within the Odoo web framework. It tracks specific URL paths registered within the system, likely used to map incoming web requests to specific controllers or website pages.

## Description
One row represents a single registered URL path within the Odoo website module. This is a raw landing table in the staging layer, providing a direct copy of the Odoo `website_route` table to facilitate downstream analysis of web traffic patterns or site structure.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Generated via `staging.website_route_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | Foreign key to an Odoo user table. |
| write_uid | INTEGER | true | User ID who last modified the record | Foreign key to an Odoo user table. |
| path | VARCHAR | true | The URL path string | The actual route path (e.g., '/shop/product'). |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo audit pattern for record creation).
    - `write_uid` → `res_users.id` (guess: standard Odoo audit pattern for record modification).
- **Natural keys (inferred):** 
    - `path`: In the context of website routing, the URL path is typically unique within the application.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** Odoo typically performs hard deletes on configuration tables; however, verify if rows disappear from this table after being removed in the Odoo UI.
- **Data Precision:** The `path` column is defined as `VARCHAR` without a specified length; downstream consumers should account for potentially long URL strings.
- **Audit Columns:** `create_uid` and `write_uid` refer to internal Odoo user IDs; these will not resolve to meaningful names without joining against the `res_users` table.
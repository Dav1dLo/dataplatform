# odoo_website_rewrite

## Source system
This table originates from Odoo ERP, specifically the website management module. The naming convention (e.g., `create_uid`, `write_uid`, `write_date`) and the specific structure of URL redirection management are characteristic of Odoo's internal ORM-based schema.

## Functional process 
This table supports the website content management and SEO redirection process. It tracks URL mapping rules used to handle legacy or deprecated URL paths, ensuring that traffic is correctly routed to new destinations (`url_to`) via specific HTTP redirect types, which is essential for maintaining site health and search engine rankings.

## Description
One row in this table represents a single URL rewrite or redirection rule configured for a specific website instance. It acts as a raw landed copy of the Odoo `website.rewrite` model, capturing the source path, destination path, and the status of the redirection rule.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.website_rewrite_id_seq`. |
| website_id | INTEGER | true | Foreign key to the website | Links to the specific website instance. |
| route_id | INTEGER | true | Foreign key to route definition | Identifies the associated route if applicable. |
| sequence | INTEGER | true | Display/Execution order | Determines the priority of the rewrite rule. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| name | VARCHAR | false | Rule name or description | Human-readable label for the rewrite rule. |
| url_from | VARCHAR | true | Source URL path | The incoming URL pattern to be redirected. |
| url_to | VARCHAR | true | Destination URL path | The target URL where traffic is redirected. |
| redirect_type | VARCHAR | true | HTTP redirect status code | e.g., '301' (permanent) or '302' (temporary). |
| active | BOOLEAN | true | Soft-delete flag | If false, the rewrite rule is disabled. |
| create_date | TIMESTAMP | true | Record creation timestamp | Recorded in UTC by Odoo. |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded in UTC by Odoo. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `website_id` → `website.id` (Guess: standard Odoo naming convention for website association).
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit column for user tracking).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit column for user tracking).
- **Natural keys (inferred):** 
    - `url_from` (In the context of a specific `website_id`, this is the business key for the redirection).

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may map to internal employee names in other tables.
- **Timestamps:** All `create_date` and `write_date` values are stored in UTC.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should filter by `WHERE active = TRUE` to retrieve only currently enabled redirects.
- **Data Quality:** `url_from` and `url_to` may contain relative or absolute paths; ensure consistent parsing logic when building downstream reporting on URL traffic.
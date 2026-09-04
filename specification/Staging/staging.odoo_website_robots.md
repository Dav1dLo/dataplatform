# odoo_website_robots

## Source system
This table originates from Odoo ERP, specifically the website module. The naming convention `website_robots` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal ORM structure for managing website-specific configurations.

## Functional process 
This table supports the website configuration process, specifically managing the `robots.txt` file content for Odoo-hosted websites. It allows administrators to define search engine crawling rules directly within the ERP interface, which are then rendered as the site's `robots.txt` file.

## Description
One row in this table represents a specific `robots.txt` configuration record associated with a website instance. It serves as a raw landing copy of the Odoo `website.robots` model, capturing the text content of the robots file and the audit trail of its creation and modification.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.website_robots_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References `res.users` in the source system. |
| write_uid | INTEGER | true | User ID who last updated the record | References `res.users` in the source system. |
| content | TEXT | true | The raw text content of the robots.txt file | Contains directives for web crawlers. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC; Odoo standard. |
| write_date | TIMESTAMP | true | Timestamp of last record update | Assumed UTC; Odoo standard. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Inferred from Odoo standard naming for creator references).
    - `write_uid` → `res_users.id` (Inferred from Odoo standard naming for modifier references).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** All `_date` columns are assumed to be in UTC, consistent with Odoo's internal storage format.
- **Sensitive Data:** This table contains configuration text; while generally public-facing, ensure that no internal path disclosures or sensitive site-map information is inadvertently included in the `content` field.
- **Soft Deletes:** Odoo typically does not use soft-delete flags in this model; however, verify if records are physically removed or if an `active` boolean column (not present here) was omitted from the source extract.
- **Data Integrity:** As this is a staging table, `content` may contain malformed text or legacy configurations; validate the syntax before using it to generate production `robots.txt` files.
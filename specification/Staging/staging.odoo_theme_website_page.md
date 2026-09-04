# odoo_theme_website_page

## Source system
This table originates from Odoo, an open-source ERP and business management suite. The naming convention `theme_website_page` and the presence of Odoo-specific audit columns like `create_uid` and `write_uid` are characteristic of Odoo's internal ORM structure for managing website content and theme configurations.

## Functional process 
This table supports the website content management process within the Odoo platform. It tracks the configuration, visibility, and indexing status of individual web pages associated with specific website themes, enabling the CMS to render pages correctly based on user-defined settings for headers, footers, and search engine indexing.

## Description
One row represents a single website page configuration record within an Odoo theme. It captures the metadata, publication status, and visual settings (such as header/footer visibility) for a specific page. This table serves as a raw landed copy of the Odoo `theme.website.page` model, intended for use in downstream staging or transformation layers.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; internal Odoo ID. |
| view_id | INTEGER | false | Foreign key to the view definition | Links to the underlying QWeb view template. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| url | VARCHAR | true | Page URL path | The relative URL path for the page. |
| header_color | VARCHAR | true | Header color configuration | CSS or hex code for header styling. |
| website_indexed | BOOLEAN | true | SEO indexing flag | Indicates if the page should be indexed by search engines. |
| is_published | BOOLEAN | true | Publication status | Indicates if the page is live and visible to the public. |
| is_new_page_template | BOOLEAN | true | Template flag | Indicates if this record acts as a template for new pages. |
| header_overlay | BOOLEAN | true | Header overlay setting | Whether the header is configured to overlay page content. |
| header_visible | BOOLEAN | true | Header visibility toggle | Whether the header is rendered on this page. |
| footer_visible | BOOLEAN | true | Footer visibility toggle | Whether the footer is rendered on this page. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of the last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `view_id` → `ir_ui_view.id` (Guess: Odoo standard pattern where `view_id` links to the `ir.ui.view` system table).
    - `create_uid` → `res_users.id` (Guess: Odoo standard pattern for audit user references).
    - `write_uid` → `res_users.id` (Guess: Odoo standard pattern for audit user references).
- **Natural keys (inferred):** 
    - `url` (In the context of a specific website, the URL path is typically unique).

## Caveats for downstream consumers

- **Sensitive Data:** `create_uid` and `write_uid` link to user records; ensure access controls are in place if mapping these to human-readable names.
- **Timestamps:** Timestamps are stored in the Odoo server's timezone (typically UTC).
- **Soft Deletes:** Odoo typically uses hard deletes for this model; however, check for `active` columns (not present here) in related tables to confirm if soft-delete patterns are used elsewhere.
- **Data Quality:** The `url` field may contain relative paths; ensure consistency when joining with other website-related tables.
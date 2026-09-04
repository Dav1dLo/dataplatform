# odoo_website_track

## Source system
This table originates from Odoo, an open-source ERP and CRM platform. The naming convention `website_track` and the presence of `visitor_id` and `page_id` are characteristic of Odoo's website analytics and visitor tracking module, which logs user interactions with web pages.

## Functional process 
This table supports the digital marketing and customer engagement process by tracking website traffic. It captures the clickstream data necessary to build customer journey maps, identify high-intent visitors, and attribute web activity to specific visitor profiles within the Odoo ecosystem.

## Description
One row in this table represents a single page view or tracking event initiated by a visitor on the website. It serves as a raw, append-only landing record of web traffic, capturing the timestamp, the specific URL visited, and the associated visitor and page identifiers.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence value. |
| visitor_id | INTEGER | false | Foreign key to visitor profile | Identifies the unique visitor session or profile. |
| page_id | INTEGER | true | Foreign key to website page | Identifies the specific page content being viewed. |
| url | TEXT | true | Uniform Resource Locator | The full path or URL of the page visited. |
| visit_datetime | TIMESTAMP | false | Event timestamp | The exact date and time the tracking event occurred. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `visitor_id` → `staging.odoo_visitor.id` (Likely reference to a visitor master table).
    - `page_id` → `staging.odoo_website_page.id` (Likely reference to a page definition table).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are stored in `TIMESTAMP` format; verify if these are in UTC or the Odoo instance's local time zone before performing time-series analysis.
- **Data Quality:** `page_id` is nullable, which may occur for tracking events that do not map to a standard page (e.g., API calls, tracking pixels, or external redirects).
- **Soft Deletes:** As this is a raw staging table, it is assumed to be an append-only log; there is no evidence of soft-delete flags.
- **PII:** The `url` column may occasionally contain sensitive query parameters (e.g., email addresses or session tokens) depending on how the Odoo website is configured.
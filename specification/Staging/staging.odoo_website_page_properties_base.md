# odoo_website_page_properties_base

## Source system
This table originates from Odoo ERP, specifically the website module. The naming convention `website_page_properties_base` and the presence of Odoo-standard audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal ORM structure for tracking website page metadata.

## Functional process 
This table supports the website content management process, specifically tracking the configuration and routing properties of pages within the Odoo website builder. It links specific URLs to target models, facilitating the dynamic routing and rendering of content pages across different website instances.

## Description
One row in this table represents a single page property configuration record associated with a specific website instance. It serves as a raw landed copy of the Odoo `website.page` or related property metadata, capturing the mapping between a URL and its underlying data model.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.website_page_properties_base_id_seq`. |
| website_id | INTEGER | false | Foreign key to the website instance | Identifies which website this page property belongs to. |
| create_uid | INTEGER | true | User ID who created the record | References the internal Odoo user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the internal Odoo user table. |
| target_model_id | VARCHAR | false | Target model identifier | The technical name of the Odoo model associated with the page. |
| url | VARCHAR | false | Page URL path | The relative URL path for the website page. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC based on Odoo standard practices. |
| write_date | TIMESTAMP | true | Record last update timestamp | Inferred UTC based on Odoo standard practices. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `website_id` → `staging.website.id` (Inferred from Odoo naming conventions).
    - `create_uid` → `staging.res_users.id` (Inferred from Odoo audit column patterns).
    - `write_uid` → `staging.res_users.id` (Inferred from Odoo audit column patterns).
- **Natural keys (inferred):** 
    - `(website_id, url)`: In Odoo, a URL is typically unique within the scope of a specific website instance.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are assumed to be in UTC, consistent with Odoo's internal storage format.
- **Data Sensitivity:** No direct PII is present, though `create_uid` and `write_uid` link to user identities.
- **Soft Deletes:** This table represents a raw landing; check for existence of an `active` column in the source system if filtering for "deleted" records is required, as it is absent here.
- **Precision:** `VARCHAR` lengths were not explicitly defined in the source DDL; downstream consumers should account for potentially long URL strings.
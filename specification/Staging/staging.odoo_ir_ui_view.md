# odoo_ir_ui_view

## Source system
This table originates from Odoo ERP, specifically the `ir_ui_view` model within the Odoo framework's internal registry. The naming convention (`ir_ui_view`) and the presence of Odoo-specific columns like `arch_db`, `arch_fs`, and `website_id` are characteristic of Odoo's metadata-driven user interface architecture.

## Functional process 
This table supports the Odoo UI rendering and customization engine. It stores the XML/JSON definitions for views (forms, lists, kanban, etc.) used across the ERP and website modules, managing how data is presented to users and how website pages are structured and themed.

## Description
One row represents a single UI view definition or customization within the Odoo system. This table acts as a raw landing copy of the Odoo `ir.ui.view` model, capturing both base view definitions and user-defined customizations at the grain of a single view record.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| priority | INTEGER | false | View rendering priority | Lower numbers indicate higher priority. |
| inherit_id | INTEGER | true | Parent view ID | References another view if this is an extension. |
| create_uid | INTEGER | true | Creator user ID | References the system user who created the view. |
| write_uid | INTEGER | true | Last modifier user ID | References the system user who last updated the view. |
| name | VARCHAR | false | View name | Descriptive label for the view. |
| model | INTEGER | true | Associated Odoo model | The technical name of the model this view applies to. |
| key | VARCHAR | true | Unique view key | Used for programmatic lookup of specific views. |
| type | VARCHAR | true | View type | e.g., 'form', 'tree', 'kanban', 'qweb'. |
| arch_fs | VARCHAR | true | File system path | Path to the view definition on the server disk. |
| mode | VARCHAR | false | View mode | 'primary' or 'extension'. |
| arch_db | JSONB | true | View architecture | The XML/JSON structure of the view stored in the DB. |
| arch_prev | TEXT | true | Previous architecture | Backup of the previous view definition. |
| arch_updated | BOOLEAN | true | Update flag | Indicates if the view architecture has been modified. |
| active | BOOLEAN | true | Soft-delete flag | If false, the view is hidden/deactivated. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of last modification. |
| customize_show | BOOLEAN | true | Customization visibility | Flag for showing customization options in UI. |
| website_id | INTEGER | true | Website ID | Links the view to a specific website instance. |
| theme_template_id | INTEGER | true | Theme template ID | Links to the theme template if applicable. |
| website_meta_og_img | VARCHAR | true | Open Graph image URL | SEO metadata for social sharing. |
| visibility | VARCHAR | true | Visibility restriction | Access control setting for the view. |
| visibility_password | VARCHAR | true | Visibility password | Password required to access the view. |
| website_meta_title | JSONB | true | SEO Title | Localized meta title. |
| website_meta_description | JSONB | true | SEO Description | Localized meta description. |
| website_meta_keywords | JSONB | true | SEO Keywords | Localized meta keywords. |
| seo_name | JSONB | true | SEO Name | Localized SEO-friendly name. |
| track | BOOLEAN | true | Tracking enabled | Whether view access is tracked for analytics. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `inherit_id` → `staging.odoo_ir_ui_view.id` (Self-referencing parent view).
    - `website_id` → `staging.odoo_website.id` (Likely target, though table not provided).
- **Natural keys (inferred):** 
    - `key` (When present, this is often used by Odoo to uniquely identify specific views across environments).

## Caveats for downstream consumers

- **Sensitive Data:** `visibility_password` may contain plain-text or hashed passwords; ensure this column is masked or excluded from general reporting.
- **Timestamps:** All `_date` columns are assumed to be in UTC, consistent with Odoo's internal storage.
- **Soft Deletes:** The `active` column acts as a soft-delete flag. Queries should generally filter by `WHERE active = true` unless auditing deleted records.
- **JSONB Complexity:** `arch_db` and various `website_meta_*` columns contain JSONB data. Downstream consumers will need to use PostgreSQL JSONB operators (e.g., `->>`) to extract specific values.
- **Data Pattern:** This is a raw staging table; schema evolution in the source Odoo instance may result in new columns appearing or existing ones changing type.
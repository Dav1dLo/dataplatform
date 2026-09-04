# odoo_ir_asset

## Source system
This table originates from Odoo ERP, specifically the `ir_asset` model within the Odoo framework's technical infrastructure. The presence of columns like `create_uid`, `write_uid`, and the `ir_asset` naming convention are characteristic of Odoo's internal metadata management for web assets (CSS/JS bundles).

## Functional process 
This table supports the Odoo web framework's asset management process, which handles the compilation, bundling, and delivery of static web resources (JavaScript and CSS files) to the frontend. It tracks which files belong to which asset bundles and their loading order, ensuring the correct theme and website-specific assets are served to users.

## Description
One row in this table represents a single asset definition (such as a specific CSS or JS file) associated with a web bundle in the Odoo environment. This is a raw landed copy of the Odoo `ir.asset` model, serving as the staging entity for tracking web resource configurations, paths, and their active status across different website themes.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `staging.ir_asset_id_seq` for generation. |
| sequence | INTEGER | false | Display/loading order | Determines the priority of asset loading. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the Odoo user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the Odoo user who last updated the record. |
| name | VARCHAR | false | Asset name | Human-readable identifier for the asset. |
| bundle | VARCHAR | false | Asset bundle name | The group (e.g., 'web.assets_frontend') this asset belongs to. |
| directive | VARCHAR | true | Asset directive | Specific instruction for the asset compiler. |
| path | VARCHAR | false | File system path | The relative path to the asset file. |
| target | VARCHAR | true | Target location | The destination or target context for the asset. |
| active | BOOLEAN | true | Soft-delete flag | Indicates if the asset is currently enabled. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the Odoo ORM. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the Odoo ORM. |
| website_id | INTEGER | true | Website ID | Foreign key to the specific website this asset is scoped to. |
| theme_template_id | INTEGER | true | Theme template ID | Foreign key to the associated theme template. |
| key | VARCHAR | true | Unique asset key | A technical identifier used for asset lookup. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit column)
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit column)
    - `website_id` → `website.id` (Guess: links to the website configuration)
- **Natural keys (inferred):** 
    - `key` (Odoo often uses a unique technical key for asset identification)

## Caveats for downstream consumers

- **Sensitive Data:** Contains no PII, but exposes internal file paths and system configuration details.
- **Timestamps:** Timestamps (`create_date`, `write_date`) are typically stored in UTC by Odoo; verify against the source instance configuration.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; ensure queries filter by `active = true` if only current assets are required.
- **Data Precision:** `VARCHAR` lengths are not explicitly defined in the source metadata; assume standard Odoo field lengths (typically 255 or unlimited depending on the specific Odoo version).
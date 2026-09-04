# odoo_theme_ir_asset

## Source system
This table originates from Odoo ERP, specifically the `ir.asset` model within the framework's internal registry. The naming convention `ir_asset` (Internal Resource Asset) is a standard pattern used by Odoo to manage web assets like CSS, JS, and SCSS files that are bundled and served to the frontend.

## Functional process 
This table supports the web asset management and theme customization process. It tracks the registration, ordering, and pathing of static assets required for rendering the Odoo web interface, allowing the system to bundle and minify resources dynamically based on the active theme.

## Description
One row in this table represents a single static asset record (such as a stylesheet or script) registered within the Odoo framework. This is a raw landing copy of the `ir.asset` table, capturing the metadata, file path, and bundle association for each asset at the grain of a single asset definition.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.theme_ir_asset_id_seq`. |
| sequence | INTEGER | false | Display/loading order | Determines the priority or order in which assets are loaded. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the system user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the system user who last updated the record. |
| key | VARCHAR | true | Unique asset key | Often used for programmatic identification of the asset. |
| name | VARCHAR | false | Asset name | Descriptive name of the asset. |
| bundle | VARCHAR | false | Asset bundle name | The group (e.g., 'web.assets_common') to which this asset belongs. |
| directive | VARCHAR | true | Asset directive | Specific instruction for the asset compiler (e.g., 'include', 'append'). |
| path | VARCHAR | false | File system path | The relative path to the asset file in the Odoo module structure. |
| target | VARCHAR | true | Target location | Defines where the asset should be injected in the DOM. |
| active | BOOLEAN | true | Soft-delete flag | Indicates if the asset is currently enabled in the system. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the Odoo ORM upon record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the Odoo ORM upon last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for user tracking).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for user tracking).
- **Natural keys (inferred):** 
    - `key` (Often acts as the unique identifier for assets within the Odoo registry).

## Caveats for downstream consumers

- **Timestamps:** Timestamps are stored in the Odoo server's local time (usually UTC, but verify against Odoo system configuration).
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should filter by `active = TRUE` to retrieve only currently enabled assets.
- **Data Precision:** `VARCHAR` lengths are not explicitly defined in the source metadata; assume standard Odoo defaults (often 255 or unlimited depending on the underlying Postgres version).
- **Sensitivity:** This table contains system configuration data; it does not contain PII or sensitive business transaction data.
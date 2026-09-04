# odoo_theme_website_menu

## Source system
This table originates from Odoo ERP, specifically the Website module. The naming convention `theme_website_menu` and the presence of Odoo-standard audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal ORM structure.

## Functional process 
This table supports the website navigation and menu management process. It defines the hierarchical structure of website menus, including links to specific pages, mega-menu configurations, and display order, enabling the dynamic rendering of navigation bars across the Odoo website frontend.

## Description
One row in this table represents a single menu item within a website theme configuration. It captures the menu's label, its URL, its position in the hierarchy (via `parent_id`), and its display sequence. This is a raw landed copy of the Odoo `theme.website.menu` model, intended for use in building navigation trees or site maps.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated ID. |
| page_id | INTEGER | true | Foreign key to website page | Links to the specific page record if applicable. |
| sequence | INTEGER | true | Display order | Used to sort menu items. |
| parent_id | INTEGER | true | Parent menu ID | Self-referencing key for hierarchy. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| url | VARCHAR | true | Target URL | The destination path for the menu item. |
| mega_menu_classes | VARCHAR | true | CSS classes for mega menu | Styling hooks for mega menu layouts. |
| name | JSONB | false | Menu label | Multilingual label stored as JSON. |
| mega_menu_content | TEXT | true | HTML content | Raw HTML for mega menu blocks. |
| new_window | BOOLEAN | true | Open in new tab flag | Determines link target behavior. |
| use_main_menu_as_parent | BOOLEAN | true | Parent inheritance flag | Logic flag for menu nesting. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by Odoo ORM. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by Odoo ORM. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `parent_id` → `staging.odoo_theme_website_menu.id`: Self-referencing hierarchy for nested menus.
    - `create_uid` / `write_uid` → `res_users.id` (assumed): Likely links to the Odoo users table.
- **Natural keys (inferred):** Not confidently inferable. Odoo typically relies on the surrogate `id` for internal linking.

## Caveats for downstream consumers

- **PII/Sensitive Data:** The `name` (JSONB) may contain user-defined labels; ensure downstream processes handle JSON parsing correctly.
- **Timestamps:** Timestamps are stored in the Odoo server's timezone (typically UTC); verify against the Odoo system configuration.
- **Soft Deletes:** Odoo typically performs hard deletes on records; however, check for `active` flags if they exist in other Odoo tables (not present here).
- **JSONB:** The `name` column is a `JSONB` object; query writers must use `->>` or `->` operators to extract string values (e.g., `name->>'en_US'`).
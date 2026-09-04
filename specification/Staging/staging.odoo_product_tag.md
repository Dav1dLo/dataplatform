# odoo_product_tag

## Source system
This table originates from Odoo ERP, as evidenced by the characteristic naming conventions such as `create_uid`, `write_uid`, `create_date`, `write_date`, and the use of `JSONB` for multi-language field storage (`name`).

## Functional process 
This table supports the product catalog management process, specifically the categorization and tagging of products for filtering, reporting, or storefront display. It acts as a lookup or reference table for product attributes within the Odoo inventory or e-commerce modules.

## Description
One row in this table represents a single product tag definition used to categorize items within the Odoo product catalog. As a staging table, it provides a raw, direct copy of the Odoo `product_tag` entity, preserving the system-generated metadata and localized naming structures.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated ID from Odoo. |
| sequence | INTEGER | true | Display order index | Used to determine the sort order of tags in the UI. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the Odoo user who created the tag. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the Odoo user who last updated the tag. |
| color | VARCHAR | true | UI color identifier | Represents a color index or CSS class name for the tag. |
| name | JSONB | false | Tag name | Multi-language string stored as a JSON object. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of the last record modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Likely reference to the user who created the record).
    - `write_uid` → `res_users.id` (Likely reference to the user who last modified the record).
- **Natural keys (inferred):** Not confidently inferable. While `name` is descriptive, Odoo typically relies on the surrogate `id` for internal linking.

## Caveats for downstream consumers

- **JSONB Handling:** The `name` column contains a JSON object (e.g., `{"en_US": "New", "fr_FR": "Nouveau"}`). Downstream consumers must parse this to extract the relevant language.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with Odoo's internal storage format.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume standard Odoo behavior where records are either present or removed.
- **Data Sensitivity:** No PII is present in this table; it contains only structural metadata for product categorization.
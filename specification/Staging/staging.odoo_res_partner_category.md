# odoo_res_partner_category

## Source system
This table originates from Odoo ERP, a modular business management software. The naming convention `res_partner_category` is standard for Odoo's core "Resource" (res) module, which manages shared entities like partners, companies, and their associated tags or categories.

## Functional process 
This table supports the customer relationship management (CRM) and contact management processes by providing a hierarchical tagging system for partners. It allows users to categorize contacts (e.g., "VIP", "Wholesale", "Lead") to facilitate segmentation, reporting, and automated workflows within the Odoo ecosystem.

## Description
One row in this table represents a single category or tag definition used to classify partner records. It functions as a raw landed copy of the Odoo `res.partner.category` model, capturing the category's name, its hierarchical position in the tree structure, and its active status.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated ID from the source system. |
| color | INTEGER | true | UI color index | Represents the color assigned to the category in the Odoo interface. |
| parent_id | INTEGER | true | Parent category reference | Self-referencing foreign key to create a category hierarchy. |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who created this category. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the user who last updated this category. |
| parent_path | VARCHAR | true | Materialized path | A string representation of the category tree path for efficient recursive queries. |
| name | JSONB | false | Category name | Multilingual label stored as a JSON object. |
| active | BOOLEAN | true | Soft-delete flag | Indicates if the category is currently enabled for use. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp of record creation; timezone typically UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of the last modification; timezone typically UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `parent_id` → `staging.odoo_res_partner_category.id`: References the parent category in the same table to support tree structures.
    - `create_uid` → `staging.odoo_res_users.id` (guess): Likely references the system user who created the record.
    - `write_uid` → `staging.odoo_res_users.id` (guess): Likely references the system user who last modified the record.
- **Natural keys (inferred):** Not confidently inferable. While `name` is descriptive, Odoo categories are typically managed via the surrogate `id`.

## Caveats for downstream consumers

- **Multilingual Data:** The `name` column is `JSONB`. Query writers must extract the specific language key (e.g., `name->>'en_US'`) to retrieve a readable string.
- **Soft Deletes:** The `active` column acts as a soft-delete flag. Queries should generally filter by `WHERE active = TRUE` unless historical analysis of deleted categories is required.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Hierarchy:** The `parent_path` column is a materialized path (e.g., "1/5/12"). This is useful for performance but should be treated as a derived field that may require re-indexing if the hierarchy is restructured.
# odoo_res_partner_title

## Source system
This table originates from Odoo ERP, specifically the `res_partner_title` model. The naming convention (`res_partner_title`), the use of `create_uid`/`write_uid` audit columns, and the `JSONB` data types for translatable fields are characteristic of the Odoo PostgreSQL schema.

## Functional process 
This table supports the management of contact titles (e.g., "Mr.", "Mrs.", "Dr.", "Prof.") used within the CRM and Partner management modules. It provides a standardized list of honorifics or professional titles that can be associated with partner records to ensure consistent communication and documentation.

## Description
One row in this table represents a single contact title definition available for assignment to partner records. It serves as a raw landed copy of the Odoo configuration table, capturing both the internal identifier and the localized display names stored as JSONB objects.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.res_partner_title_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users` table. |
| write_uid | INTEGER | true | User ID who last updated the record | References `res_users` table. |
| name | JSONB | false | Display name of the title | Likely contains multi-language strings; check keys for locale codes. |
| shortcut | JSONB | true | Abbreviated version of the title | Likely contains multi-language strings. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **JSONB Handling:** The `name` and `shortcut` columns contain JSONB data. Query writers must use the `->>` operator (e.g., `name->>'en_US'`) to extract specific language values.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all rows are currently active unless Odoo's internal logic dictates otherwise.
- **Audit Columns:** `create_uid` and `write_uid` are internal Odoo user IDs and may not correspond to IDs in your local data warehouse unless the `res_users` table is also synchronized.
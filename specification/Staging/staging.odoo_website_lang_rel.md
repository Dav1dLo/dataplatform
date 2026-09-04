# odoo_website_lang_rel

## Source system
This table originates from Odoo ERP, a modular business management software. The naming convention `_rel` is characteristic of Odoo's internal ORM mechanism for managing many-to-many relationship tables between two entities.

## Functional process 
This table supports the multi-language website configuration process. It maps which languages are enabled or available for specific website instances within the Odoo ecosystem, allowing the platform to serve content in the appropriate locale based on the website context.

## Description
One row in this table represents a single association between a specific website and a supported language. It acts as a join table to resolve the many-to-many relationship between website definitions and language definitions. As a staging table, it provides a raw, unjoined view of these associations as they exist in the source Odoo database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| website_id | INTEGER | false | Foreign key to the website definition | Links to the primary key of the website table. |
| lang_id | INTEGER | false | Foreign key to the language definition | Links to the primary key of the language table. |

## Keys

- **Primary key (inferred):** The combination of `(website_id, lang_id)` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `website_id` → `website.id`: This column references the unique identifier of a website record.
    - `lang_id` → `res_lang.id`: This column references the unique identifier of a language record in Odoo's `res_lang` table.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; it is impossible to determine when an association was created or modified from this table alone.
- Ensure that joins to `website` and `res_lang` tables are handled as inner joins if you only require active associations, or left joins if you are performing data integrity checks.
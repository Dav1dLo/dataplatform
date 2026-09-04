# odoo_base_language_install_website_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` is characteristic of Odoo's internal ORM, which automatically generates junction tables for many-to-many relationships between models.

## Functional process 
This table supports the multi-website localization configuration process. It maps specific language installation records to the websites where those languages have been enabled or deployed, ensuring that the correct language assets are loaded for the corresponding web storefronts.

## Description
One row in this table represents a single association between a language installation record and a website record. It is a raw landing copy of an Odoo many-to-many join table, serving as the bridge to resolve which languages are active on which websites.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| base_language_install_id | INTEGER | false | Foreign key to the base_language_install table | Represents the specific language installation event. |
| website_id | INTEGER | false | Foreign key to the website table | Represents the website entity where the language is installed. |

## Keys

- **Primary key (inferred):** The combination of `(base_language_install_id, website_id)` acts as the composite primary key.
- **Foreign keys (inferred):** 
    - `base_language_install_id` → `base_language_install.id`: Links to the language installation record.
    - `website_id` → `website.id`: Links to the website configuration record.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present in this table; it reflects the current state of the Odoo ORM relationship.
- Ensure that joins to `base_language_install` and `website` are handled as inner joins if you only require active associations.
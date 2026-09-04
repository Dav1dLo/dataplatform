# odoo_res_lang

## Source system
This table originates from Odoo ERP, specifically the `res_lang` model. The naming convention (`res_` prefix) and the presence of Odoo-specific audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of the Odoo framework's core resource tables.

## Functional process 
This table supports the localization and internationalization (i18n) process within the ERP. It defines the available languages for the system interface and document generation, dictating how dates, times, and numeric formats are rendered for different locales.

## Description
One row in this table represents a single language configuration available within the Odoo environment. It acts as a raw landed copy of the system's language registry, providing the necessary metadata to format data according to regional standards.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users`. |
| write_uid | INTEGER | true | User ID who last modified the record | References `res_users`. |
| name | VARCHAR | false | Full name of the language | e.g., "English (US)". |
| code | VARCHAR | false | Language code | e.g., "en_US". |
| iso_code | VARCHAR | true | ISO 639-1/2 language code | Optional standard identifier. |
| url_code | VARCHAR | false | Code used in website URLs | e.g., "en". |
| direction | VARCHAR | false | Text direction | Usually "ltr" or "rtl". |
| date_format | VARCHAR | false | Date format string | Python-style strftime format. |
| time_format | VARCHAR | false | Time format string | Python-style strftime format. |
| short_time_format | VARCHAR | false | Short time format string | Python-style strftime format. |
| week_start | VARCHAR | false | First day of the week | Integer index or day name. |
| grouping | VARCHAR | false | Numeric grouping definition | Defines digit grouping for numbers. |
| decimal_point | VARCHAR | false | Decimal separator character | e.g., "." or ",". |
| thousands_sep | VARCHAR | true | Thousands separator character | e.g., "," or ".". |
| active | BOOLEAN | true | Soft-delete flag | If false, language is hidden in UI. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit field).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit field).
- **Natural keys (inferred):** 
    - `code` (The unique language identifier used by the application).

## Caveats for downstream consumers

- **Soft Deletes:** The `active` column indicates a soft-delete pattern; ensure queries filter by `active = TRUE` unless historical data is required.
- **Timezones:** Timestamps (`create_date`, `write_date`) are typically stored in UTC by Odoo.
- **Data Precision:** All `VARCHAR` fields are defined without length constraints in the source; downstream systems should be prepared for varying string lengths.
- **Formatting:** The format strings (`date_format`, `time_format`) follow Python's `strftime` syntax, which may require translation if used in non-Python reporting tools.
# odoo_payment_country_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` combined with the column pattern `payment_id` and `country_id` is characteristic of Odoo's internal many-to-many relationship tables, which are automatically generated to link payment methods or configurations to specific countries.

## Functional process 
This table supports the configuration of payment gateway availability. It defines which countries are permitted or associated with specific payment methods within the Odoo payment processing module, ensuring that users are only presented with valid payment options based on their geographic location.

## Description
One row in this table represents a single association between a payment entity and a country. It serves as a raw, junction-table copy from the Odoo database, maintaining the many-to-many relationship required to map payment methods to their applicable regions.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| payment_id | INTEGER | false | Foreign key to the payment configuration table. | Links to the primary key of the payment method record. |
| country_id | INTEGER | false | Foreign key to the country master table. | Links to the primary key of the country record. |

## Keys

- **Primary key (inferred):** Not confidently inferable. Odoo relationship tables often use a composite primary key on `(payment_id, country_id)`.
- **Foreign keys (inferred):** 
    - `payment_id` → `odoo_payment_acquirer.id` (guess based on Odoo schema patterns).
    - `country_id` → `odoo_res_country.id` (guess based on Odoo schema patterns).
- **Natural keys (inferred):** The composite pair `(payment_id, country_id)` acts as the unique business key for this relationship.

## Caveats for downstream consumers

- This table is a junction table; it contains no descriptive attributes, only identifiers.
- There are no audit timestamps (e.g., `create_date` or `write_date`) present in this staging extract; incremental loading based on time is not possible.
- Ensure inner joins are used when filtering by country or payment method to avoid orphaned records if the source system has referential integrity gaps.
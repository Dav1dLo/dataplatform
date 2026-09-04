# odoo_payment_method_res_country_rel

## Source system
This table originates from Odoo ERP. The naming convention `_res_country_rel` is a standard pattern used by the Odoo ORM to manage many-to-many relationship tables between a primary entity (in this case, payment methods) and the `res.country` model.

## Functional process 
This table supports the configuration of payment gateway availability by geographic region. It defines which payment methods are permitted or enabled for specific countries, likely used in the checkout or payment processing logic to filter available options based on the customer's billing or shipping address.

## Description
One row in this table represents a single association between a specific payment method and a country. It is a raw landed copy of an Odoo join table, serving as a bridge to resolve many-to-many relationships between payment configurations and geographic entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| payment_method_id | INTEGER | false | Foreign key to the payment method definition. | Links to the primary payment method record. |
| res_country_id | INTEGER | false | Foreign key to the country definition. | Links to the `res.country` table. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key on `(payment_method_id, res_country_id)`.
- **Foreign keys (inferred):** 
    - `payment_method_id` → `payment_method.id` (guess: standard Odoo naming convention for join tables).
    - `res_country_id` → `res_country.id` (guess: standard Odoo naming convention for join tables).
- **Natural keys (inferred):** The combination of `(payment_method_id, res_country_id)` acts as the unique business key for this relationship.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; it is impossible to determine when a relationship was created or modified from this table alone.
- As a staging table, it should be joined with the corresponding master tables (`payment_method` and `res_country`) to provide human-readable context for the IDs.
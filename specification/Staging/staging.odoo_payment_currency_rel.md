# odoo_payment_currency_rel

## Source system
This table originates from Odoo ERP. The naming convention `odoo_payment_currency_rel` is characteristic of Odoo's internal many-to-many relationship tables, which use the `_rel` suffix to link two distinct entities (in this case, payment providers and currencies).

## Functional process 
This table supports the payment configuration process, specifically defining which currencies are supported or enabled for specific payment providers. It acts as a bridge to ensure that payment gateways are only offered to customers when the transaction currency is supported by the provider's configuration.

## Description
One row in this table represents a single association between a payment provider and a supported currency. It is a raw landed copy of an Odoo join table, serving as the base for mapping payment capabilities in downstream staging or dimension models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| payment_provider_id | INTEGER | false | Foreign key to the payment provider entity | Links to the primary key of the payment provider table. |
| currency_id | INTEGER | false | Foreign key to the currency entity | Links to the primary key of the currency table. |

## Keys

- **Primary key (inferred):** The combination of `(payment_provider_id, currency_id)` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `payment_provider_id` → `odoo_payment_provider.id` (inferred from Odoo naming conventions).
    - `currency_id` → `odoo_res_currency.id` (inferred from Odoo naming conventions).
- **Natural keys (inferred):** The composite of `(payment_provider_id, currency_id)` acts as the natural business key for this relationship.

## Caveats for downstream consumers

- This table is a junction table; it contains no descriptive attributes, only identifiers.
- There is no audit timestamp (e.g., `create_date` or `write_date`) present in this specific extract, so incremental loading based on time is not possible without joining to the parent tables.
- Ensure that joins to parent tables handle potential missing records if the source system has undergone partial data exports.
# odoo_payment_method_res_currency_rel

## Source system
This table originates from Odoo ERP. The naming convention `_res_currency_rel` is a standard pattern used by the Odoo ORM to represent many-to-many relationship tables (link tables) between core business entities.

## Functional process 
This table supports the payment configuration process, specifically defining which currencies are permitted or enabled for specific payment methods. It acts as a bridge to ensure that payment gateways or methods are only presented to users when the transaction currency is supported.

## Description
One row in this table represents a single association between a payment method and a currency. It is a raw landing of an Odoo join table, serving as the link between payment configuration and currency master data.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| payment_method_id | INTEGER | false | Foreign key to the payment method definition. | Links to the primary key of the payment method table. |
| res_currency_id | INTEGER | false | Foreign key to the currency definition. | Links to the primary key of the currency table. |

## Keys

- **Primary key (inferred):** The composite of (`payment_method_id`, `res_currency_id`).
- **Foreign keys (inferred):** 
    - `payment_method_id` → `payment_method.id`: This column references the Odoo payment method entity.
    - `res_currency_id` → `res_currency.id`: This column references the Odoo currency master table.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a link table; queries should expect to join this with both the payment method and currency tables to retrieve human-readable names.
- There are no timestamps or audit columns present; incremental loading logic cannot rely on `updated_at` fields.
- The table represents an existence relationship; the absence of a pair implies the currency is not supported for that specific payment method.
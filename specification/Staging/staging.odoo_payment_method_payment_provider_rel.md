# odoo_payment_method_payment_provider_rel

## Source system
This table originates from Odoo, an open-source ERP system. The naming convention `_rel` is a standard pattern used by the Odoo ORM to represent many-to-many relationship tables (link tables) between two primary entities.

## Functional process 
This table supports the payment configuration process, specifically managing the association between available payment methods (e.g., credit card, wire transfer) and the payment providers (e.g., Stripe, PayPal, Authorize.net) that support them. It ensures that the system only offers valid payment methods for a selected provider during the checkout or invoicing flow.

## Description
One row in this table represents a single link between a specific payment method and a payment provider. This is a raw landing of a join table, serving as the source for mapping relationships in downstream dimensional models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| payment_method_id | INTEGER | false | Foreign key to the payment method definition. | Links to the primary key of the payment method table. |
| payment_provider_id | INTEGER | false | Foreign key to the payment provider definition. | Links to the primary key of the payment provider table. |

## Keys

- **Primary key (inferred):** The composite key `(payment_method_id, payment_provider_id)` is the inferred primary key, as this is a standard join table structure.
- **Foreign keys (inferred):** 
    - `payment_method_id` → `staging.odoo_payment_method.id` (Inferred from Odoo naming conventions).
    - `payment_provider_id` → `staging.odoo_payment_provider.id` (Inferred from Odoo naming conventions).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table contains no descriptive data, only identifiers; it must be joined with the corresponding `payment_method` and `payment_provider` tables to be meaningful.
- There are no timestamps or audit columns present; it is impossible to determine the history of these associations from this table alone.
- As a join table, it is expected that these columns are indexed in the source system; ensure downstream joins are performed on both columns to maintain performance.
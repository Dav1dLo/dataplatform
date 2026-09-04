# odoo_payment_provider_pos_payment_method_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` is characteristic of Odoo's ORM, which automatically generates junction tables to manage many-to-many relationships between business objects.

## Functional process 
This table supports the configuration of payment methods within the Point of Sale (POS) module. It maps specific payment providers (e.g., Stripe, Adyen, or internal cash/bank journals) to the payment methods available for selection at a POS terminal.

## Description
Each row represents a single association between a payment provider and a POS payment method. This is a raw landing of a many-to-many join table, used to resolve which providers are enabled for which payment methods in the Odoo environment.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| pos_payment_method_id | INTEGER | false | Foreign key to the POS payment method definition. | Links to the primary key of the `pos_payment_method` table. |
| payment_provider_id | INTEGER | false | Foreign key to the payment provider configuration. | Links to the primary key of the `payment_provider` table. |

## Keys

- **Primary key (inferred):** The composite of (`pos_payment_method_id`, `payment_provider_id`).
- **Foreign keys (inferred):** 
    - `pos_payment_method_id` → `pos_payment_method.id`: This column references the specific payment method configuration used in the POS.
    - `payment_provider_id` → `payment_provider.id`: This column references the backend provider configuration (e.g., API credentials, provider type).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure junction table; it contains no descriptive attributes, only identifiers.
- As a raw staging table, it may contain orphaned records if the parent tables (`pos_payment_method` or `payment_provider`) have had records deleted without cascading the delete to this relation table.
- There is no audit timestamp (e.g., `create_date` or `write_date`) present in this table, making it difficult to determine the recency of the relationship without joining to the parent tables.
# odoo_pos_config_pos_payment_method_rel

## Source system
This table originates from Odoo ERP, specifically the Point of Sale (POS) module. The naming convention `_rel` is characteristic of Odoo's ORM, which uses these join tables to manage many-to-many relationships between configuration entities and payment methods.

## Functional process 
This table supports the POS configuration process by defining which payment methods are enabled or available for a specific Point of Sale terminal. It acts as a bridge between the POS configuration settings and the available payment gateways or methods (e.g., cash, bank, credit card).

## Description
One row in this table represents a single association between a POS configuration and a payment method. It is a raw landing of a many-to-many join table, serving as the source for mapping payment capabilities to specific POS terminals in downstream models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| pos_config_id | INTEGER | false | Foreign key to the POS configuration | Links to the primary POS terminal definition. |
| pos_payment_method_id | INTEGER | false | Foreign key to the payment method | Links to the specific payment method definition. |

## Keys

- **Primary key (inferred):** The composite key `(pos_config_id, pos_payment_method_id)`.
- **Foreign keys (inferred):** 
    - `pos_config_id` → `pos_config.id`: This column references the POS configuration entity.
    - `pos_payment_method_id` → `pos_payment_method.id`: This column references the available payment methods.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There is no audit timestamp (e.g., `created_at` or `updated_at`) present in this table; incremental loading logic must rely on upstream source system logs or full table refreshes.
- As a many-to-many relationship table, expect multiple rows per `pos_config_id` if a terminal supports multiple payment methods.
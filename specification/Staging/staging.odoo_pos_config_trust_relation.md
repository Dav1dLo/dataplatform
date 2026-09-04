# odoo_pos_config_trust_relation

## Source system
This table originates from Odoo ERP, specifically within the Point of Sale (POS) module. The naming convention `odoo_pos_config_...` is characteristic of Odoo's internal relational mapping tables used to manage configuration dependencies or security trust relationships between POS terminal configurations.

## Functional process 
This table supports the POS configuration management process, specifically defining trust relationships between different POS terminal configurations. It likely governs which POS instances are permitted to share data, access shared hardware, or perform cross-terminal operations within the Odoo ecosystem.

## Description
One row in this table represents a single directional trust relationship between two POS configuration entities. It acts as a raw landing copy of a many-to-many join table, mapping a "trusting" configuration ID to a "trusted" configuration ID.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| is_trusting | INTEGER | false | The ID of the POS configuration that initiates the trust. | References `odoo_pos_config.id`. |
| is_trusted | INTEGER | false | The ID of the POS configuration that is being trusted. | References `odoo_pos_config.id`. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite key of `(is_trusting, is_trusted)`.
- **Foreign keys (inferred):** 
    - `is_trusting → odoo_pos_config.id`: Evidence is the column naming convention matching Odoo's standard relational link patterns.
    - `is_trusted → odoo_pos_config.id`: Evidence is the column naming convention matching Odoo's standard relational link patterns.
- **Natural keys (inferred):** The pair `(is_trusting, is_trusted)` acts as the business key for the relationship.

## Caveats for downstream consumers

- This table contains no surrogate primary key; ensure queries handle the composite nature of the relationship.
- There are no timestamps or audit columns; it is impossible to determine when these relationships were created or if they are currently active based on this table alone.
- This is a pure join table; it should be used to filter or join `odoo_pos_config` records rather than being queried in isolation.
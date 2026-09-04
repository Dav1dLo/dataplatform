# odoo_pos_detail_configs

## Source system
This table originates from Odoo ERP, specifically the Point of Sale (POS) module. The naming convention `pos_detail_configs` and the presence of `pos_config_id` are characteristic of Odoo's relational mapping for wizard-based reporting configurations.

## Functional process 
This table supports the Point of Sale reporting process, specifically mapping POS configuration settings to the wizards used to generate detailed sales reports. It acts as a join table or configuration link that determines which POS terminals are included in specific reporting batches.

## Description
One row in this table represents a single association between a POS detail wizard instance and a specific POS configuration. It serves as a raw landed copy of the Odoo database table, maintaining the link between reporting parameters and the underlying terminal settings.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| pos_details_wizard_id | INTEGER | false | Foreign key to the POS details wizard instance | Represents the parent reporting session. |
| pos_config_id | INTEGER | false | Foreign key to the POS configuration | Identifies the specific terminal or shop configuration included. |

## Keys

- **Primary key (inferred):** Not confidently inferable from the provided metadata; likely a composite key of `(pos_details_wizard_id, pos_config_id)`.
- **Foreign keys (inferred):** 
    - `pos_details_wizard_id → pos_details_wizard.id`: Links to the wizard configuration session.
    - `pos_config_id → pos_config.id`: Links to the specific POS terminal configuration.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a link table; expect many-to-many relationships between wizards and configurations.
- No audit timestamps (e.g., `created_at`) are present in this schema, making it difficult to determine the age of the records.
- As a staging table, this data should be joined with the corresponding Odoo master tables to resolve the integer IDs into human-readable names.
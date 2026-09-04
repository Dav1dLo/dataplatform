# odoo_account_fiscal_position_tax

## Source system
This table originates from Odoo ERP. The naming convention `account_fiscal_position_tax` and the presence of Odoo-specific audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of the Odoo `account.fiscal.position.tax` model, which manages tax mapping rules for fiscal positions.

## Functional process 
This table supports the tax configuration and accounting automation process. It defines how taxes are substituted when a specific fiscal position (e.g., "Intra-community B2B" or "Export") is applied to a transaction, mapping a source tax (`tax_src_id`) to a destination tax (`tax_dest_id`) based on the fiscal position (`position_id`).

## Description
One row in this table represents a single tax mapping rule within a fiscal position configuration. It acts as a raw landed copy of the Odoo database record, capturing the relationship between a source tax and its replacement tax for a specific business context.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `account_fiscal_position_tax_id_seq`. |
| position_id | INTEGER | false | Foreign key to fiscal position | Links to the parent fiscal position definition. |
| company_id | INTEGER | true | Company identifier | Multi-company context; null implies global or default company. |
| tax_src_id | INTEGER | false | Source tax ID | The original tax to be replaced. |
| tax_dest_id | INTEGER | true | Destination tax ID | The replacement tax to be applied. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by Odoo. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by Odoo. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `position_id` → `staging.odoo_account_fiscal_position.id` (Inferred from Odoo schema naming conventions).
    - `tax_src_id` → `staging.odoo_account_tax.id` (Inferred from Odoo schema naming conventions).
    - `tax_dest_id` → `staging.odoo_account_tax.id` (Inferred from Odoo schema naming conventions).
- **Natural keys (inferred):** Not confidently inferable. Odoo typically relies on the surrogate `id` for internal relationships, though `(position_id, tax_src_id)` likely acts as a unique business constraint.

## Caveats for downstream consumers

- **Timestamps:** All `_date` columns are stored in UTC.
- **Soft Deletes:** This table does not implement a soft-delete flag; records are typically hard-deleted in the source Odoo system.
- **Nullability:** `tax_dest_id` may be null if the fiscal position rule is intended to remove a tax entirely rather than replace it.
- **Data Integrity:** As a staging table, this contains raw data; ensure joins to `account_tax` handle potential missing references if the ETL process is not perfectly synchronized.
# odoo_account_reconcile_model_line_account_tax_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` is a standard pattern used by the Odoo ORM to represent many-to-many relationship tables (junction tables) between two entities, in this case, reconciliation model lines and tax definitions.

## Functional process 
This table supports the financial accounting reconciliation process. It maps specific tax configurations to reconciliation model lines, ensuring that when automated reconciliation rules are applied to bank statements or invoices, the correct tax accounts are triggered or adjusted based on the model line definition.

## Description
One row in this table represents a single association between a reconciliation model line and a tax record. It serves as a raw landing copy of the Odoo junction table, facilitating the reconstruction of many-to-many relationships between financial reconciliation rules and tax entities in downstream models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_reconcile_model_line_id | INTEGER | false | Foreign key to the reconciliation model line | Links to the parent reconciliation model line definition. |
| account_tax_id | INTEGER | false | Foreign key to the tax definition | Identifies the specific tax record associated with the model line. |

## Keys

- **Primary key (inferred):** The combination of `account_reconcile_model_line_id` and `account_tax_id`.
- **Foreign keys (inferred):** 
    - `account_reconcile_model_line_id` → `account_reconcile_model_line.id` (Inferred from Odoo naming convention for junction tables).
    - `account_tax_id` → `account_tax.id` (Inferred from Odoo naming convention for junction tables).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; queries should expect a many-to-many relationship structure.
- No audit timestamps (e.g., `created_at` or `updated_at`) are present in this table; tracking changes over time is not possible without joining to the parent tables.
- Ensure inner joins are used when filtering by specific tax or model line IDs to avoid orphaned records if the source system has integrity gaps.
# odoo_account_reconcile_model_res_partner_rel

## Source system
This table originates from Odoo ERP. The naming convention `account_reconcile_model_res_partner_rel` is a standard pattern used by the Odoo ORM to represent a many-to-many relationship table between the `account.reconcile.model` and `res.partner` models.

## Functional process 
This table supports the automated reconciliation process in the accounting module. It defines which specific business partners (customers or vendors) are associated with particular reconciliation models, allowing the system to apply specific matching rules or templates to transactions involving those partners.

## Description
One row in this table represents a single association between a reconciliation model and a partner. It acts as a join table to resolve a many-to-many relationship, ensuring that reconciliation logic can be scoped to specific entities. As a staging table, it provides a raw, landed copy of the link table directly from the Odoo PostgreSQL database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_reconcile_model_id | INTEGER | false | Foreign key to the reconciliation model definition. | Links to the primary key of the `account_reconcile_model` table. |
| res_partner_id | INTEGER | false | Foreign key to the partner entity. | Links to the primary key of the `res_partner` table. |

## Keys

- **Primary key (inferred):** The combination of `(account_reconcile_model_id, res_partner_id)` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `account_reconcile_model_id` → `account_reconcile_model.id`: References the parent reconciliation model configuration.
    - `res_partner_id` → `res_partner.id`: References the specific partner record.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a link table; queries should expect to join this against both the reconciliation model and partner master tables to retrieve meaningful business attributes.
- No audit timestamps (e.g., `create_date` or `write_date`) are present in this specific table; downstream consumers cannot determine when the relationship was established or modified based on this table alone.
- The table contains no PII directly, but it links financial reconciliation logic to specific partner identities.
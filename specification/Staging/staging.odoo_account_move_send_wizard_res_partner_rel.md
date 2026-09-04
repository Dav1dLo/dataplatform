# odoo_account_move_send_wizard_res_partner_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` combined with the specific module references (`account_move_send_wizard` and `res_partner`) indicates this is a standard Odoo many-to-many join table used to link wizard instances to specific business partners (contacts/customers/vendors).

## Functional process 
This table supports the document distribution process within Odoo, specifically the "Send by Email" or "Print" wizard for accounting moves. It tracks which partners are associated with a specific instance of an account move distribution wizard, likely to manage recipient lists or notification preferences for invoices and credit notes.

## Description
One row represents a single association between an `account_move_send_wizard` instance and a `res_partner` entity. It serves as a raw landing copy of the join table used by the Odoo framework to maintain many-to-many relationships during the document sending workflow.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_move_send_wizard_id | INTEGER | false | Foreign key to the wizard instance | Links to the primary record in the wizard table. |
| res_partner_id | INTEGER | false | Foreign key to the partner record | Links to the specific contact or partner involved in the wizard. |

## Keys

- **Primary key (inferred):** The combination of `(account_move_send_wizard_id, res_partner_id)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `account_move_send_wizard_id` → `account_move_send_wizard.id`: This column references the parent wizard record.
    - `res_partner_id` → `res_partner.id`: This column references the partner record in the Odoo partner registry.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a pure join table; it contains no business data other than the relationship identifiers.
- There are no timestamps or audit columns present in this table; temporal analysis is not possible without joining to the parent wizard table.
- As a staging table, this reflects the raw state of the Odoo database; ensure that downstream models handle potential orphaned records if the source system does not enforce strict referential integrity.
# odoo_account_resequence_wizard

## Source system
This table originates from Odoo ERP, as indicated by the naming convention `odoo_account_resequence_wizard` and the presence of standard Odoo audit columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`.

## Functional process 
This table supports the accounting resequencing process, which allows users to re-number journal entries within a specific date range. It acts as a transient wizard state, capturing the parameters (start sequence, ordering, and date range) required to trigger the resequencing logic in the Odoo accounting module.

## Description
One row in this table represents a single execution instance or configuration state of the account resequence wizard. It serves as a raw landing copy of the wizard's input parameters, capturing the user's requested sequence settings before the system applies the changes to the underlying accounting entries.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.account_resequence_wizard_id_seq`. |
| create_uid | INTEGER | true | ID of the user who created the record | References `res.users`. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References `res.users`. |
| first_name | VARCHAR | false | Initial sequence number or prefix | The starting value for the resequencing operation. |
| ordering | VARCHAR | false | Sorting criteria for resequencing | Defines the logic used to order entries before renumbering. |
| first_date | DATE | true | Start date of the range to resequence | Inclusive start date for the operation. |
| end_date | DATE | true | End date of the range to resequence | Inclusive end date for the operation. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the Odoo ORM. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the Odoo ORM. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern for record creation).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern for record modification).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are generally stored in UTC by Odoo; verify against the application server configuration if local time conversion is required.
- **Data Retention:** This table represents a wizard state; rows may be ephemeral or purged periodically by the Odoo cleanup processes.
- **Sensitivity:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined with `res_users` to identify specific personnel.
- **Precision:** `VARCHAR` lengths are not explicitly defined in the source DDL; assume standard Odoo string handling, but monitor for truncation if processing exceptionally long sequence prefixes.
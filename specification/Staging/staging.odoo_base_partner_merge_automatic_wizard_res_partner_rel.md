# odoo_base_partner_merge_automatic_wizard_res_partner_rel

## Source system
This table originates from Odoo ERP. The naming convention `base_partner_merge_automatic_wizard_res_partner_rel` is characteristic of Odoo's internal many-to-many relationship tables, which are automatically generated to link wizard process instances to specific partner records during data deduplication tasks.

## Functional process 
This table supports the customer data management and deduplication process. It tracks which `res.partner` records are currently associated with a specific execution of the "Automatic Partner Merge" wizard, allowing the system to group potential duplicates for review or automated merging.

## Description
One row represents a single association between a specific partner merge wizard instance and a partner record. It serves as a raw landing copy of the join table used by the Odoo framework to manage the state of deduplication operations.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| base_partner_merge_automatic_wizard_id | INTEGER | false | Foreign key to the merge wizard instance | Links to the parent wizard record. |
| res_partner_id | INTEGER | false | Foreign key to the partner record | Links to the specific partner being processed. |

## Keys

- **Primary key (inferred):** The combination of `base_partner_merge_automatic_wizard_id` and `res_partner_id` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `base_partner_merge_automatic_wizard_id` → `base_partner_merge_automatic_wizard.id` (Inferred from Odoo naming convention for join tables).
    - `res_partner_id` → `res_partner.id` (Inferred from Odoo naming convention for join tables).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a technical join table; it contains no business data other than the relationship between the wizard and the partners.
- There are no timestamps or audit columns; the lifecycle of these records is managed entirely by the Odoo wizard's execution state.
- Expect high churn in this table as records are typically purged or cleared by the Odoo framework once the merge wizard process completes.
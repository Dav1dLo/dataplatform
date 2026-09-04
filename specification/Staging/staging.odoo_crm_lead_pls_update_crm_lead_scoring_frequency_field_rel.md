# odoo_crm_lead_pls_update_crm_lead_scoring_frequency_field_rel

## Source system
This table originates from Odoo ERP, specifically the CRM module. The naming convention `_rel` combined with the two foreign key columns indicates this is a standard Odoo many-to-many join table used to link lead update records with scoring frequency configurations.

## Functional process 
This table supports the lead scoring and qualification process. It maintains the association between specific CRM lead update events and the scoring frequency fields that define how often those leads should be re-evaluated or updated based on business logic.

## Description
One row in this table represents a single association between a CRM lead update record and a scoring frequency field configuration. It serves as a raw, junction-table copy from the Odoo staging layer, facilitating the many-to-many relationship required for lead scoring automation.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| crm_lead_pls_update_id | INTEGER | false | Foreign key to the CRM lead update record | Represents the primary entity being updated. |
| crm_lead_scoring_frequency_field_id | INTEGER | false | Foreign key to the scoring frequency configuration | Defines the frequency rule applied to the lead. |

## Keys

- **Primary key (inferred):** The combination of `crm_lead_pls_update_id` and `crm_lead_scoring_frequency_field_id` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `crm_lead_pls_update_id` → `crm_lead_pls_update.id` (Inferred from Odoo naming conventions for junction tables).
    - `crm_lead_scoring_frequency_field_id` → `crm_lead_scoring_frequency_field.id` (Inferred from Odoo naming conventions for junction tables).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; queries should expect to join this against the two parent tables to retrieve meaningful business attributes.
- No audit or timestamp columns are present; the temporal state of these relationships must be inferred from the parent tables.
- As a raw staging table, it may contain orphaned records if the parent tables have undergone cleanup or if referential integrity is not strictly enforced at the database level in the source Odoo instance.
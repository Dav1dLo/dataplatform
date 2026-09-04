# odoo_crm_convert_lead_mass_lead_rel

## Source system
This table originates from Odoo CRM. The naming convention `crm_lead2opportunity_partner_mass_id` and `crm_lead_id` is characteristic of Odoo's internal ORM-generated relational tables, specifically those used to manage many-to-many relationships during mass-action processes.

## Functional process 
This table supports the "Lead-to-Opportunity" conversion process. It acts as a join table for a mass-conversion wizard, linking a specific mass-conversion job instance to the individual lead records being processed.

## Description
One row represents a single association between a mass lead conversion job and a specific lead record. It serves as a raw landing copy of the Odoo relational link table, used to maintain referential integrity during bulk lead-to-opportunity transformations.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| crm_lead2opportunity_partner_mass_id | INTEGER | false | Foreign key to the parent mass conversion job. | Links to the wizard instance record. |
| crm_lead_id | INTEGER | false | Foreign key to the lead record. | Links to the specific lead being converted. |

## Keys

- **Primary key (inferred):** Not confidently inferable. This is a join table; it likely relies on a composite primary key of `(crm_lead2opportunity_partner_mass_id, crm_lead_id)`.
- **Foreign keys (inferred):** 
    - `crm_lead2opportunity_partner_mass_id` → `crm_lead2opportunity_partner_mass.id` (Guess: links to the mass conversion wizard header).
    - `crm_lead_id` → `crm_lead.id` (Guess: links to the source lead record).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table contains no surrogate primary key; ensure queries handle potential duplicate rows if the source system allows re-processing of the same lead in the same mass job.
- There are no timestamps or audit columns; it is impossible to determine the sequence of events or the ingestion time from this table alone.
- This is a pure join table; it should be used only to bridge the relationship between the mass conversion wizard and the leads, and should not be used as a source for lead attributes.
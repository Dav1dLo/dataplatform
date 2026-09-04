# odoo_onboarding_progress_onboarding_progress_step_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` and the structure of linking two IDs strongly indicate a standard Odoo many-to-many join table used to manage associations between onboarding progress records and their constituent steps.

## Functional process 
This table supports the user onboarding and configuration tracking process within Odoo. It maps specific onboarding progress sessions to the individual steps that have been associated with them, facilitating the tracking of completion status for complex setup workflows.

## Description
One row in this table represents a single association between an onboarding progress record and a specific onboarding step. It serves as a raw, junction-table copy from the Odoo source system, maintaining the many-to-many relationship required to track which steps belong to which onboarding progress entity.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| "onboarding_progress_id" | INTEGER | false | Foreign key to the parent onboarding progress record | Links to the primary onboarding session. |
| "onboarding_progress_step_id" | INTEGER | false | Foreign key to the specific onboarding step | Links to the definition of the onboarding step. |

## Keys

- **Primary key (inferred):** The composite key ("onboarding_progress_id", "onboarding_progress_step_id").
- **Foreign keys (inferred):** 
    - "onboarding_progress_id" → "onboarding_progress"."id" (Inferred from Odoo naming conventions for many-to-many relationship tables).
    - "onboarding_progress_step_id" → "onboarding_progress_step"."id" (Inferred from Odoo naming conventions for many-to-many relationship tables).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present in this table; state changes (like step completion) must be inferred from the existence of the record or joined against the parent tables.
- Ensure that joins to parent tables handle the potential for missing records if the source system has performed cascading deletes or if data ingestion is partial.
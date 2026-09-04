# odoo_onboarding_onboarding_onboarding_onboarding_step_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` is characteristic of Odoo's automated many-to-many relationship tables, which are generated to link core business objects (in this case, onboarding processes and their constituent steps) within the Odoo PostgreSQL database schema.

## Functional process 
This table supports the onboarding configuration and tracking process. It manages the many-to-many relationship between onboarding containers (`onboarding_onboarding`) and individual onboarding steps (`onboarding_onboarding_step`), allowing the system to track which steps are associated with specific onboarding workflows.

## Description
One row in this table represents a single association between an onboarding process and a specific step within that process. It serves as a raw landing copy of the Odoo join table, maintaining the link between the parent onboarding entity and its child step entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| onboarding_onboarding_id | INTEGER | false | Foreign key to the onboarding process | Links to the parent onboarding record. |
| onboarding_onboarding_step_id | INTEGER | false | Foreign key to the onboarding step | Links to the specific step definition. |

## Keys

- **Primary key (inferred):** The composite of `(onboarding_onboarding_id, onboarding_onboarding_step_id)`.
- **Foreign keys (inferred):** 
    - `onboarding_onboarding_id` → `onboarding_onboarding.id`: This column references the primary key of the onboarding configuration table.
    - `onboarding_onboarding_step_id` → `onboarding_onboarding_step.id`: This column references the primary key of the onboarding step definition table.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or soft-delete flags present; this table reflects the current state of associations as captured during the last ingestion.
- Ensure that joins to the parent tables handle the potential for missing records if the upstream Odoo instance has referential integrity gaps.
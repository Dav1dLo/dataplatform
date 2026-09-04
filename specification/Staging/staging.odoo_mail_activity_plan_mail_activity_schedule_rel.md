# odoo_mail_activity_plan_mail_activity_schedule_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` combined with the specific module prefixes `mail_activity_plan` and `mail_activity_schedule` is characteristic of Odoo's automated many-to-many relationship tables, which link activity plans to their constituent scheduled activities.

## Functional process 
This table supports the "Activity Planning" business process within Odoo, which allows users to define templates (plans) for sequences of tasks or communications. It acts as a junction table to associate specific activity schedules with a parent activity plan, enabling the system to trigger multiple activities automatically when a plan is applied to a record.

## Description
One row in this table represents a single association between a mail activity plan and a scheduled mail activity. It is a raw landing copy of a join table used to maintain the many-to-many relationship between plan definitions and activity templates.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mail_activity_schedule_id | INTEGER | false | Foreign key to the scheduled activity definition. | Links to the `mail_activity_schedule` table. |
| mail_activity_plan_id | INTEGER | false | Foreign key to the parent activity plan. | Links to the `mail_activity_plan` table. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key on `(mail_activity_plan_id, mail_activity_schedule_id)`.
- **Foreign keys (inferred):** 
    - `mail_activity_schedule_id` → `mail_activity_schedule.id`: This column references the specific activity template being included in the plan.
    - `mail_activity_plan_id` → `mail_activity_plan.id`: This column references the parent plan definition.
- **Natural keys (inferred):** The combination of `(mail_activity_plan_id, mail_activity_schedule_id)` acts as the unique business identifier for this relationship.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only relational links.
- There are no timestamps or audit columns present in this table; it represents the current state of the relationship as defined in the source system.
- Ensure joins to parent tables handle potential orphaned records if the source system's referential integrity is not strictly enforced during extraction.
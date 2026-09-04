# odoo_crm_merge_opportunity

## Source system
This table originates from Odoo ERP, specifically the CRM module. The naming convention `crm_merge_opportunity` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal tracking for record merging operations.

## Functional process 
This table supports the Lead-to-Cash pipeline by tracking the history and metadata of merged CRM opportunities. It records the administrative details of when and by whom opportunities were consolidated, which is essential for maintaining data integrity and audit trails during sales pipeline cleanup.

## Description
One row represents a single merge event involving CRM opportunities within the Odoo system. It acts as a raw landed copy of the merge transaction log, capturing the user responsible for the action and the associated sales team at the time of the merge.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; unique identifier for the merge event. |
| user_id | INTEGER | true | Assigned user ID | The CRM user associated with the opportunity being merged. |
| team_id | INTEGER | true | Sales team ID | The sales team responsible for the opportunity. |
| create_uid | INTEGER | true | Creator user ID | The ID of the user who performed the merge operation. |
| write_uid | INTEGER | true | Last modifier user ID | The ID of the user who last updated this merge record. |
| create_date | TIMESTAMP | true | Creation timestamp | The date and time the merge record was created. |
| write_date | TIMESTAMP | true | Last update timestamp | The date and time the merge record was last modified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `res_users.id` (Guess: standard Odoo pattern for user associations).
    - `team_id` → `crm_team.id` (Guess: standard Odoo pattern for CRM team associations).
    - `create_uid` / `write_uid` → `res_users.id` (Guess: standard Odoo audit trail pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs which may link to PII in the `res_users` table; ensure appropriate access controls are applied.
- **Timezone:** Timestamps are typically stored in UTC in Odoo; verify against the source system configuration.
- **Soft Deletes:** This table represents an audit log of merge events; it is generally append-only and does not typically support soft deletes.
- **Data Grain:** This table tracks the *event* of a merge, not the mapping of which specific opportunities were merged into which (that data likely resides in a related join table not present here).
# odoo_web_tour_tour_step

## Source system
This table originates from Odoo ERP, specifically the "Web Tour" module. The naming convention `web_tour_tour_step` and the presence of Odoo-standard audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal ORM-managed tables.

## Functional process 
This table supports the configuration and execution of interactive user onboarding tours within the Odoo web interface. It defines the individual steps (actions, triggers, and content) that guide a user through specific workflows, allowing administrators to sequence instructional overlays or highlights.

## Description
One row represents a single step within a defined web tour, specifying the trigger event, the instructional content to display, and the execution logic. As a staging table, it serves as a raw, direct reflection of the Odoo database schema, intended for ingestion into downstream analytical models for tracking tour completion or configuration audits.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated identifier. |
| tour_id | INTEGER | false | Foreign key to the parent tour | Links this step to a specific tour definition. |
| sequence | INTEGER | true | Display order | Determines the order of steps in the tour. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| trigger | VARCHAR | false | UI selector/event | The CSS selector or event that triggers this step. |
| content | VARCHAR | true | Instructional text | The HTML or text content displayed to the user. |
| run | VARCHAR | true | Execution script | JavaScript snippet to execute during this step. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of the last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `tour_id` → `staging.odoo_web_tour_tour.id` (Inferred based on Odoo naming conventions where `_id` suffixes denote parent relationships).
    - `create_uid` → `staging.odoo_res_users.id` (Standard Odoo pattern for audit fields).
    - `write_uid` → `staging.odoo_res_users.id` (Standard Odoo pattern for audit fields).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are stored in the Odoo server's local time (typically UTC, but verify against Odoo system settings).
- **Sensitive Data:** `create_uid` and `write_uid` link to user records; ensure these are handled according to internal PII/access policies.
- **Data Integrity:** This is a raw staging table; it may contain orphaned records if the parent `tour_id` has been deleted in the source system.
- **Content:** The `content` column may contain raw HTML; downstream consumers should sanitize this if rendering in a web-based dashboard.
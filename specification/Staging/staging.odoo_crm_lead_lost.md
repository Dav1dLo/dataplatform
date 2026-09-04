# odoo_crm_lead_lost

## Source system
This table originates from Odoo ERP, specifically the CRM module. The naming convention `crm_lead_lost` and the presence of `lost_reason_id` and `lost_feedback` are characteristic of Odoo's internal tracking of lost sales opportunities.

## Functional process 
This table supports the sales pipeline management process by capturing the reasons and qualitative feedback associated with lost leads or opportunities. It acts as a supporting entity to the main CRM lead/opportunity table, providing historical context on why potential deals were not converted.

## Description
One row in this table represents a single instance of a lost lead event, linking a specific opportunity to a predefined lost reason and optional descriptive feedback. As a staging table, it serves as a raw, direct copy of the Odoo database record, intended for use in downstream analytical models to calculate win/loss ratios and churn drivers.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence from Odoo. |
| lost_reason_id | INTEGER | true | Foreign key to the lost reason definition | Links to the master list of reasons for loss. |
| create_uid | INTEGER | true | User ID who created the record | References the internal Odoo user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the internal Odoo user table. |
| lost_feedback | TEXT | true | Qualitative notes on why the lead was lost | Free-text field for sales representative input. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC as per standard Odoo configuration. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC as per standard Odoo configuration. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `lost_reason_id` → `crm_lost_reason.id` (Likely target based on Odoo schema naming conventions).
    - `create_uid` → `res_users.id` (Standard Odoo pattern for audit fields).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for audit fields).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `lost_feedback` column may contain PII or sensitive client communication; ensure appropriate masking if exposing to non-authorized users.
- **Timezones:** Timestamps are assumed to be in UTC, consistent with standard Odoo database deployments.
- **Data Integrity:** This table contains `write_uid` and `write_date`, indicating that records may be updated over time; ensure your queries handle the latest version of a record if performing point-in-time analysis.
- **Soft Deletes:** Odoo typically uses `active` flags (not present here) or physical deletes; verify if your ingestion process captures historical state or only current state.
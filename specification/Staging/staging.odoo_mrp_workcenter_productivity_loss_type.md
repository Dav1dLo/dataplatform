# odoo_mrp_workcenter_productivity_loss_type

## Source system
This table originates from Odoo ERP, specifically the Manufacturing (MRP) module. The naming convention `mrp_workcenter_productivity_loss_type` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal ORM structure.

## Functional process 
This table supports the manufacturing performance tracking process by categorizing the reasons for production downtime or efficiency loss at a work center. It provides the lookup values used to classify productivity losses, which are subsequently linked to work center productivity logs to enable OEE (Overall Equipment Effectiveness) reporting.

## Description
One row represents a single category or type of productivity loss defined within the Odoo manufacturing system. This is a reference/lookup table used to standardize the classification of downtime or performance degradation events. It serves as a raw landed copy of the Odoo configuration entity, intended for use in downstream dimension modeling.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.mrp_workcenter_productivity_loss_type_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References the `res_users` table in Odoo. |
| write_uid | INTEGER | true | User ID who last updated the record | References the `res_users` table in Odoo. |
| loss_type | VARCHAR | false | The classification of the productivity loss | Likely values include 'productive', 'performance', or 'availability'. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC per Odoo standard. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC per Odoo standard. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern for record creation).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern for record modification).
- **Natural keys (inferred):** 
    - `loss_type` (Assuming the business logic enforces unique loss category names).

## Caveats for downstream consumers

- **Timestamps:** Odoo stores all timestamps in UTC; ensure conversion to local time if required for reporting.
- **Audit Columns:** `create_uid` and `write_uid` are internal Odoo IDs; they will not resolve to meaningful user names without joining to the `res_users` table.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume standard CRUD behavior where records are physically present or absent.
- **Data Integrity:** As a staging table, this may contain historical records or configuration states that have been deprecated in the source system.
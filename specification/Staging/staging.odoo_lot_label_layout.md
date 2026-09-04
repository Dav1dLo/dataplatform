# odoo_lot_label_layout

## Source system
This table originates from Odoo ERP. The naming convention `odoo_lot_label_layout` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal ORM-managed tables, specifically those related to inventory or manufacturing label printing configurations.

## Functional process 
This table supports the inventory management and warehouse operations process, specifically the configuration of label printing layouts for product lots or serial numbers. It tracks user-defined preferences for how labels are generated, including the quantity of labels to print and the specific format template to be used during the picking or manufacturing process.

## Description
One row in this table represents a single configuration record for a lot label layout, defining how labels should be formatted and in what volume. As a staging table, it serves as a raw, direct copy of the Odoo database record, intended to provide the base data for downstream inventory reporting and label printing analytics.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.lot_label_layout_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References the Odoo `res.users` table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the Odoo `res.users` table. |
| label_quantity | VARCHAR | false | Number of labels to print | Likely stores a numeric value or a field reference. |
| print_format | VARCHAR | false | Selected label template format | Identifies the layout design used for printing. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC per Odoo standard. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC per Odoo standard. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo pattern for record ownership).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for record modification).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** All `TIMESTAMP` columns are assumed to be in UTC, consistent with Odoo's internal storage format.
- **Data Types:** `label_quantity` and `print_format` are defined as `VARCHAR` in the source; ensure explicit casting to `INTEGER` or appropriate types if performing arithmetic or strict filtering.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records present are active unless Odoo's internal logic dictates otherwise.
- **Audit Columns:** `create_uid` and `write_uid` may be null if the record was created via system processes or legacy migrations.
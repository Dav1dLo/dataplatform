# odoo_ir_model_spreadsheet_dashboard_rel

## Source system
This table originates from Odoo ERP. The naming convention `ir_model_..._rel` is characteristic of Odoo's internal "Ir" (Internal Resource) module, which manages metadata, models, and dashboard configurations within the Odoo framework.

## Functional process 
This table supports the Odoo dashboarding and reporting framework. It acts as a join table that maps specific Odoo data models (`ir_model`) to spreadsheet-based dashboards, allowing the system to track which data models are utilized or referenced by specific dashboard configurations.

## Description
One row in this table represents a many-to-many relationship between a spreadsheet dashboard and an Odoo data model. It is a raw landed copy of the association table used by the Odoo ORM to link reporting entities to their underlying data structures.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| spreadsheet_dashboard_id | INTEGER | false | Foreign key to the spreadsheet dashboard definition. | Maps to the primary key of the dashboard metadata table. |
| ir_model_id | INTEGER | false | Foreign key to the Odoo data model definition. | Identifies the specific data model (e.g., sale.order, account.move) used in the dashboard. |

## Keys

- **Primary key (inferred):** The combination of `spreadsheet_dashboard_id` and `ir_model_id` forms a composite primary key.
- **Foreign keys (inferred):** 
    - `spreadsheet_dashboard_id` → `spreadsheet_dashboard.id` (Inferred from Odoo naming conventions for relational tables).
    - `ir_model_id` → `ir_model.id` (Inferred from Odoo naming conventions for relational tables).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; queries should expect to join this against the parent `spreadsheet_dashboard` and `ir_model` tables to retrieve human-readable names.
- There are no timestamps or audit columns present; this table represents the current state of dashboard-to-model associations.
- As a raw staging table, it contains no soft-delete flags; records are typically managed by the Odoo ORM and may be purged entirely when associations are removed in the source system.
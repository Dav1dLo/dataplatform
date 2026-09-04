# odoo_mrp_production_split_line

## Source system
This table originates from Odoo ERP, specifically the Manufacturing (MRP) module. The naming convention `mrp_production_split_line` and the presence of audit columns like `create_uid` and `write_uid` are characteristic of Odoo's internal ORM structure for tracking manufacturing order splits.

## Functional process 
This table supports the manufacturing production splitting process, where a single manufacturing order is divided into smaller batches or sub-orders. It tracks the specific quantities allocated to these splits and the audit trail of who performed the split and when.

## Description
One row in this table represents a single line item within a manufacturing production split event, detailing the quantity assigned to that specific split. It serves as a raw landed copy of the Odoo `mrp.production.split.line` model, capturing the state of production batching at the time of ingestion.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated identifier. |
| mrp_production_split_id | INTEGER | false | Foreign key to the parent split record | Links to the main production split header. |
| user_id | INTEGER | true | ID of the user associated with the split | Often represents the operator or responsible party. |
| create_uid | INTEGER | true | ID of the user who created the record | Odoo internal audit field. |
| write_uid | INTEGER | true | ID of the user who last updated the record | Odoo internal audit field. |
| quantity | NUMERIC | false | Quantity allocated to this split line | Unit of measure depends on the parent product. |
| date | TIMESTAMP | true | Scheduled date for this split line | Inferred as local server time. |
| create_date | TIMESTAMP | true | Record creation timestamp | Odoo internal audit field. |
| write_date | TIMESTAMP | true | Last update timestamp | Odoo internal audit field. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `mrp_production_split_id` → `staging.odoo_mrp_production_split.id` (Inferred from naming convention).
    - `user_id`, `create_uid`, `write_uid` → `staging.odoo_res_users.id` (Standard Odoo pattern for user references).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Audit Timestamps:** `create_date` and `write_date` are standard Odoo audit fields; assume these are in the server's local timezone unless otherwise specified in the Odoo configuration.
- **Data Integrity:** As a staging table, this may contain multiple versions of the same record if the ingestion process performs full dumps; check for the latest `write_date` if deduplication is required.
- **PII:** `user_id` references internal system users; ensure join logic to `res_users` is handled according to internal data privacy policies regarding employee information.
- **Soft Deletes:** Odoo typically uses hard deletes in the database; if a record is missing from a subsequent dump, it has likely been removed from the source system.
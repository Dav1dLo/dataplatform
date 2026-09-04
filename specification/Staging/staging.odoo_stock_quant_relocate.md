# odoo_stock_quant_relocate

## Source system
This table originates from Odoo ERP, specifically the Inventory management module. The naming convention `stock_quant_relocate` and the presence of `create_uid`/`write_uid` audit columns are characteristic of Odoo's ORM-generated tables, which track internal stock movement or relocation operations.

## Functional process 
This table supports the inventory management and warehouse logistics process, specifically tracking the relocation of stock quantities between locations or packages. It acts as a log or transaction record for moving items within the warehouse hierarchy, capturing the destination details and associated user activity.

## Description
One row in this table represents a single stock relocation event or request within the Odoo inventory system. It serves as a raw landed copy of the Odoo `stock.quant.relocate` model, capturing the destination location, package, and audit metadata for each relocation operation.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated identifier. |
| dest_location_id | INTEGER | true | Destination location ID | Foreign key to the stock location table. |
| dest_package_id | INTEGER | true | Destination package ID | Foreign key to the stock package table. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who initiated the relocation. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| message | TEXT | true | Relocation message | Optional descriptive text regarding the move. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of the last record modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `dest_location_id` → `stock_location.id` (Inferred from Odoo naming conventions for location references).
    - `dest_package_id` → `stock_quant_package.id` (Inferred from Odoo naming conventions for package references).
    - `create_uid` → `res_users.id` (Standard Odoo pattern for user audit fields).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for user audit fields).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains `create_uid` and `write_uid` which link to user identities; ensure these are handled according to internal privacy policies.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with Odoo's standard database storage format.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records are current unless otherwise specified by Odoo's internal logic.
- **Data Integrity:** As a staging table, this may contain incomplete records if the Odoo transaction was interrupted; verify against `write_date` for the most recent state.
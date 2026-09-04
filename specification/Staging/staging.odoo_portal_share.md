# odoo_portal_share

## Source system
This table originates from Odoo ERP, specifically the `portal` module. The naming convention (`res_id`, `res_model`, `create_uid`) is characteristic of Odoo's ORM layer, which uses a generic resource-linking pattern to manage shared access to various business objects.

## Functional process 
This table supports the "Portal Sharing" process, which allows internal users to generate secure, time-limited or persistent links for external portal users to access specific records (e.g., invoices, sales orders, or project tasks). It tracks the metadata of these shared instances, linking them to the underlying business object via a polymorphic relationship.

## Description
One row represents a single portal share instance, which acts as a bridge between an external user and a specific record in the system. As a staging table, it serves as a raw, direct copy of the Odoo `portal_share` table, capturing the state of shared resources and their associated notes or audit timestamps.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; internal Odoo ID. |
| res_id | INTEGER | false | Target record ID | The ID of the object being shared. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the internal user who created the share. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the internal user who last updated the share. |
| res_model | VARCHAR | false | Target model name | The technical name of the Odoo model (e.g., 'sale.order'). |
| note | TEXT | true | Share description | Optional note attached to the shared record. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the Odoo server. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the Odoo server. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for audit fields).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for audit fields).
- **Natural keys (inferred):** 
    - The combination of `res_model` and `res_id` acts as the business key identifying the shared resource.

## Caveats for downstream consumers

- **Polymorphism:** The `res_model` column indicates which table `res_id` refers to; queries joining this table must handle the dynamic nature of the target entity.
- **Timestamps:** All `_date` columns are stored in UTC.
- **Sensitive Data:** The `note` column may contain free-text information; ensure it is reviewed for PII before exposing to non-privileged users.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume rows are physically deleted if they disappear from the source.
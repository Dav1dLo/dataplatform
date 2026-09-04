# odoo_stock_package_destination

## Source system
This table originates from Odoo ERP, an open-source business management suite. The naming convention (`stock_package_destination`, `picking_id`, `location_dest_id`) and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's inventory management module (Stock).

## Functional process 
This table supports the inventory logistics and warehouse management process, specifically tracking the destination locations for packages or shipments. It links a specific picking operation to its intended destination, facilitating the movement of goods within the warehouse hierarchy.

## Description
One row in this table represents a specific destination assignment for a package or picking operation within the Odoo inventory system. It serves as a raw landing record in the staging layer, capturing the association between a picking event and its target warehouse location.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence from Odoo. |
| picking_id | INTEGER | false | Foreign key to the picking operation | Links to the main stock picking record. |
| location_dest_id | INTEGER | false | Foreign key to the destination location | The target warehouse location for the package. |
| create_uid | INTEGER | true | User ID who created the record | References the Odoo res.users table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the Odoo res.users table. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC based on Odoo standard behavior. |
| write_date | TIMESTAMP | true | Record last modification timestamp | Inferred UTC based on Odoo standard behavior. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `picking_id` → `staging.stock_picking.id`: This column represents the specific movement or picking operation being processed.
    - `location_dest_id` → `staging.stock_location.id`: This column defines the physical or logical destination within the warehouse.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are assumed to be in UTC, consistent with Odoo's internal storage format.
- **Data Integrity:** As a staging table, this may contain multiple versions of a record if the source system performs updates; check `write_date` to identify the most recent state.
- **PII:** No direct PII is present, though user IDs (`create_uid`, `write_uid`) link to internal system users.
- **Soft Deletes:** This table does not explicitly show a soft-delete flag; assume records are current unless otherwise specified by the Odoo source logic.
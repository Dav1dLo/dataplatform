# odoo_pos_printer

## Source system
This table originates from Odoo ERP, specifically the Point of Sale (POS) module. The naming convention (e.g., `company_id`, `create_uid`, `write_uid`, `write_date`) is characteristic of Odoo's standard ORM-based database schema, which tracks audit trails and multi-company context for every record.

## Functional process 
This table supports the POS hardware configuration process, specifically the management of network-connected receipt and order printers. It enables the mapping of physical printing devices to specific POS instances or companies, facilitating the routing of print jobs from the POS interface to local or network-based hardware.

## Description
One row in this table represents a single POS printer configuration record, defining its network address and type. As a staging table, it serves as a raw, direct copy of the Odoo `pos_printer` table, intended to provide the base data for downstream hardware inventory or POS configuration reporting.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.pos_printer_id_seq`. |
| company_id | INTEGER | false | Foreign key to the owning company | Links to the `res_company` table. |
| create_uid | INTEGER | true | User ID who created the record | Links to `res_users`. |
| write_uid | INTEGER | true | User ID who last modified the record | Links to `res_users`. |
| name | VARCHAR | false | Display name of the printer | Human-readable identifier. |
| printer_type | VARCHAR | true | Category of the printer | e.g., 'epson_epos', 'network'. |
| proxy_ip | VARCHAR | true | IP address of the IoT Box/Proxy | Used for network communication. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed per Odoo standards. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed per Odoo standards. |
| epson_printer_ip | VARCHAR | true | Specific IP for Epson hardware | Used if `printer_type` is Epson-specific. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Standard Odoo multi-company architecture).
    - `create_uid` → `res_users.id` (Standard Odoo audit trail).
    - `write_uid` → `res_users.id` (Standard Odoo audit trail).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata; Odoo typically relies on the surrogate `id` for internal references.

## Caveats for downstream consumers

- **Timestamps:** Odoo stores all timestamps in UTC; ensure local timezone conversion is applied if required for reporting.
- **Audit Columns:** `create_uid` and `write_uid` may be null in older records or if the user account has been deleted.
- **Data Integrity:** This is a raw staging table; it may contain configuration records that are logically "deleted" or inactive if the source system uses a soft-delete pattern (though Odoo typically uses hard deletes for this entity).
- **Sensitivity:** No direct PII is present, but IP addresses (`proxy_ip`, `epson_printer_ip`) should be treated as internal network infrastructure data.
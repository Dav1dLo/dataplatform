# odoo_stock_warehouse

## Source system
This table originates from Odoo ERP, specifically the Inventory (Stock) module. The naming convention (e.g., `wh_input_stock_loc_id`, `mto_pull_id`, `reception_steps`) is characteristic of the Odoo `stock.warehouse` model, which manages physical and logical warehouse structures within the Odoo database schema.

## Functional process 
This table supports the Inventory and Supply Chain management process. It defines the warehouse hierarchy, including internal locations for input, quality control, output, and packing, as well as the routing logic for "Make-to-Order" (MTO) and resupply workflows. It acts as the central configuration hub for how goods move through specific physical sites within the company.

## Description
One row in this table represents a single warehouse entity defined within the Odoo system. This is a raw landed copy of the Odoo `stock_warehouse` table, capturing the configuration, routing rules, and location links for each warehouse. It serves as the primary dimension for warehouse-level filtering in downstream inventory reporting.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| company_id | INTEGER | false | Foreign key to company | Links warehouse to a specific legal entity. |
| partner_id | INTEGER | true | Foreign key to res.partner | Address/contact associated with the warehouse. |
| view_location_id | INTEGER | false | Parent location ID | The root location for the warehouse hierarchy. |
| lot_stock_id | INTEGER | false | Default stock location | The primary storage location for this warehouse. |
| wh_input_stock_loc_id | INTEGER | true | Input location ID | Location for incoming goods. |
| wh_qc_stock_loc_id | INTEGER | true | Quality control location ID | Location for QC processes. |
| wh_output_stock_loc_id | INTEGER | true | Output location ID | Location for outgoing goods. |
| wh_pack_stock_loc_id | INTEGER | true | Packing location ID | Location for packing operations. |
| mto_pull_id | INTEGER | true | MTO pull rule ID | Link to the Make-to-Order pull rule. |
| pick_type_id | INTEGER | true | Picking operation type | ID for picking operations. |
| pack_type_id | INTEGER | true | Packing operation type | ID for packing operations. |
| out_type_id | INTEGER | true | Outgoing operation type | ID for delivery/outgoing operations. |
| in_type_id | INTEGER | true | Incoming operation type | ID for receipt/incoming operations. |
| int_type_id | INTEGER | true | Internal operation type | ID for internal transfers. |
| qc_type_id | INTEGER | true | QC operation type | ID for quality control operations. |
| store_type_id | INTEGER | true | Store operation type | ID for storage operations. |
| xdock_type_id | INTEGER | true | Cross-dock operation type | ID for cross-docking operations. |
| crossdock_route_id | INTEGER | true | Cross-dock route ID | Routing rule for cross-docking. |
| reception_route_id | INTEGER | true | Reception route ID | Routing rule for incoming goods. |
| delivery_route_id | INTEGER | true | Delivery route ID | Routing rule for outgoing goods. |
| sequence | INTEGER | true | Display sequence | Used for ordering in UI. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| name | VARCHAR | false | Warehouse name | Descriptive name of the warehouse. |
| code | VARCHAR(5) | false | Warehouse short code | Short identifier (e.g., WH1). |
| reception_steps | VARCHAR | false | Reception workflow | Defines steps (e.g., 'one_step', 'two_steps'). |
| delivery_steps | VARCHAR | false | Delivery workflow | Defines steps (e.g., 'ship_only'). |
| active | BOOLEAN | true | Active flag | Soft-delete indicator. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |
| manufacture_pull_id | INTEGER | true | Manufacturing pull rule ID | Link to manufacturing pull rule. |
| manufacture_mto_pull_id | INTEGER | true | MTO manufacturing pull ID | Link to MTO manufacturing rule. |
| pbm_mto_pull_id | INTEGER | true | PBM MTO pull ID | Link to Pick-Build-Move MTO rule. |
| sam_rule_id | INTEGER | true | SAM rule ID | Link to Sub-Assembly rule. |
| manu_type_id | INTEGER | true | Manufacturing op type | ID for manufacturing operations. |
| pbm_type_id | INTEGER | true | PBM operation type | ID for Pick-Build-Move operations. |
| sam_type_id | INTEGER | true | SAM operation type | ID for Sub-Assembly operations. |
| pbm_route_id | INTEGER | true | PBM route ID | Routing rule for PBM. |
| pbm_loc_id | INTEGER | true | PBM location ID | Location for PBM. |
| sam_loc_id | INTEGER | true | SAM location ID | Location for SAM. |
| manufacture_steps | VARCHAR | false | Manufacturing workflow | Defines manufacturing steps. |
| manufacture_to_resupply | BOOLEAN | true | Resupply from manufacture | Boolean flag. |
| pos_type_id | INTEGER | true | POS operation type | ID for Point of Sale operations. |
| buy_pull_id | INTEGER | true | Buy pull rule ID | Link to procurement/buy rule. |
| buy_to_resupply | BOOLEAN | true | Resupply from buy | Boolean flag. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Standard Odoo multi-company architecture).
    - `partner_id` → `res_partner.id` (Standard Odoo partner linking).
- **Natural keys (inferred):** 
    - `code` (The short code is typically unique per company in Odoo).

## Caveats for downstream consumers

- **Sensitive Data:** Contains internal operational IDs and potentially partner/company links; no direct PII, but sensitive for business logic.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo server configurations.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; ensure queries filter by `active = TRUE` unless historical analysis is required.
- **Data Integrity:** Many columns are foreign keys to other Odoo tables (e.g., `stock_location`, `stock_picking_type`); ensure joins are handled for missing values as many are nullable.
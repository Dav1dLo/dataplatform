# odoo_bill_to_po_wizard

## Source system
This table originates from Odoo ERP. The naming convention `odoo_bill_to_po_wizard` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's transient models (wizards) used to manage temporary state during the conversion of vendor bills to purchase orders.

## Functional process 
This table supports the procurement and accounts payable workflow, specifically the "Bill-to-Purchase Order" conversion process. It tracks the temporary state of a wizard interface that allows users to link or generate purchase orders from existing vendor bills, capturing the association between the partner (vendor) and the target purchase order.

## Description
One row represents a single execution instance of the bill-to-purchase-order wizard session. It acts as a raw landed copy of the transient state data from the Odoo application, capturing the user interaction and the specific records involved in the conversion process at a specific point in time.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.bill_to_po_wizard_id_seq`. |
| purchase_order_id | INTEGER | true | Foreign key to the target purchase order | Links to the purchase order being created or updated. |
| partner_id | INTEGER | true | Foreign key to the vendor/partner | The vendor associated with the bill/PO conversion. |
| create_uid | INTEGER | true | ID of the user who created the record | References the Odoo `res.users` table. |
| write_uid | INTEGER | true | ID of the user who last modified the record | References the Odoo `res.users` table. |
| create_date | TIMESTAMP | true | Timestamp of record creation | In UTC; Odoo standard audit field. |
| write_date | TIMESTAMP | true | Timestamp of last modification | In UTC; Odoo standard audit field. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `purchase_order_id` → `purchase_order.id` (Guess: links to the main purchase order entity).
    - `partner_id` → `res_partner.id` (Guess: links to the vendor entity).
    - `create_uid` → `res_users.id` (Guess: standard Odoo user reference).
    - `write_uid` → `res_users.id` (Guess: standard Odoo user reference).
- **Natural keys (inferred):** Not confidently inferable. As a transient wizard table, it may not have a stable business key.

## Caveats for downstream consumers

- **Transient Data:** This table represents a wizard state; records may be ephemeral or cleared by the application after the process completes.
- **Timestamps:** All `_date` columns are assumed to be in UTC, consistent with Odoo's internal storage.
- **Audit Columns:** `create_uid` and `write_uid` refer to internal Odoo user IDs; ensure you have a mapping table to resolve these to human-readable usernames.
- **Nullability:** Many fields are nullable because the wizard state may be partially populated during the user's interaction.
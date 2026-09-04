# odoo_sale_order

## Source system
This table originates from Odoo ERP, an open-source business management suite. The naming conventions (e.g., `partner_id`, `sale_order_template_id`, `procurement_group_id`) and the specific structure of the sales order model are characteristic of the Odoo `sale.order` object.

## Functional process 
This table supports the "Order-to-Cash" business process. It captures the lifecycle of a sales order from initial quotation through to confirmation, delivery, and invoicing. It integrates with CRM (via `opportunity_id`), inventory (via `warehouse_id`), and accounting (via `journal_id` and `currency_id`) modules.

## Description
One row in this table represents a single sales order or quotation within the Odoo system. It captures the financial totals, status, customer references, and logistical details associated with a sale. This table serves as a raw landed copy of the Odoo `sale.order` model, providing the base grain for sales reporting and order tracking.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Internal surrogate key | Primary key; sequence generated. |
| campaign_id | INTEGER | true | Marketing campaign ID | Link to marketing module. |
| source_id | INTEGER | true | Marketing source ID | Link to marketing module. |
| medium_id | INTEGER | true | Marketing medium ID | Link to marketing module. |
| company_id | INTEGER | false | Company ID | Multi-company context. |
| partner_id | INTEGER | false | Customer ID | Link to `res.partner`. |
| journal_id | INTEGER | true | Accounting journal ID | Link to accounting module. |
| partner_invoice_id | INTEGER | false | Invoice address ID | Link to `res.partner`. |
| partner_shipping_id | INTEGER | false | Shipping address ID | Link to `res.partner`. |
| fiscal_position_id | INTEGER | true | Fiscal position ID | Tax mapping rules. |
| payment_term_id | INTEGER | true | Payment term ID | Credit/payment conditions. |
| pricelist_id | INTEGER | true | Pricelist ID | Pricing strategy applied. |
| currency_id | INTEGER | true | Currency ID | Transaction currency. |
| user_id | INTEGER | true | Salesperson ID | Owner of the order. |
| team_id | INTEGER | true | Sales team ID | Sales department/group. |
| create_uid | INTEGER | true | Creator user ID | Audit trail. |
| write_uid | INTEGER | true | Last modifier user ID | Audit trail. |
| access_token | VARCHAR | true | Public access token | Used for portal sharing. |
| name | VARCHAR | false | Order reference number | Human-readable document ID. |
| state | VARCHAR | true | Order status | e.g., draft, sent, sale, done, cancel. |
| client_order_ref | VARCHAR | true | Customer PO number | External reference. |
| origin | VARCHAR | true | Source document | e.g., linked quotation or lead. |
| reference | VARCHAR | true | Internal reference | Additional order notes. |
| signed_by | VARCHAR | true | Signatory name | Digital signature info. |
| invoice_status | VARCHAR | true | Invoicing status | e.g., to invoice, invoicing, invoiced. |
| validity_date | DATE | true | Expiration date | For quotations. |
| note | TEXT | true | Customer notes | Free-text field. |
| currency_rate | NUMERIC | true | Currency exchange rate | Rate at time of order. |
| amount_untaxed | NUMERIC | true | Subtotal | Amount before tax. |
| amount_tax | NUMERIC | true | Tax amount | Total tax value. |
| amount_total | NUMERIC | true | Grand total | Total order value. |
| locked | BOOLEAN | true | Lock status | Prevents further edits. |
| require_signature | BOOLEAN | true | Signature requirement | Flag for online signing. |
| require_payment | BOOLEAN | true | Payment requirement | Flag for online payment. |
| create_date | TIMESTAMP | true | Creation timestamp | Record creation time. |
| commitment_date | TIMESTAMP | true | Promised delivery date | Expected delivery. |
| date_order | TIMESTAMP | false | Order date | Transaction date. |
| signed_on | TIMESTAMP | true | Signature timestamp | When signed. |
| write_date | TIMESTAMP | true | Last update timestamp | Audit trail. |
| prepayment_percent | DOUBLE PRECISION | true | Prepayment percentage | Required deposit %. |
| pending_email_template_id | INTEGER | true | Email template ID | Pending communication. |
| opportunity_id | INTEGER | true | CRM Opportunity ID | Link to `crm.lead`. |
| sale_order_template_id | INTEGER | true | Order template ID | Predefined order structure. |
| incoterm | INTEGER | true | Incoterm ID | International trade terms. |
| warehouse_id | INTEGER | true | Warehouse ID | Fulfillment location. |
| procurement_group_id | INTEGER | true | Procurement group ID | Inventory planning link. |
| incoterm_location | VARCHAR | true | Incoterm location | Specific location for terms. |
| picking_policy | VARCHAR | false | Picking policy | e.g., direct, one-shot. |
| delivery_status | VARCHAR | true | Delivery status | e.g., pending, delivered. |
| effective_date | TIMESTAMP | true | Effective date | Actual fulfillment date. |
| amount_unpaid | NUMERIC | true | Unpaid balance | Remaining amount due. |
| customizable_pdf_form_fields | JSONB | true | Custom PDF fields | Dynamic form data. |
| project_id | INTEGER | true | Project ID | Link to project management. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `partner_id` → `res_partner.id` (Customer reference)
    - `user_id` → `res_users.id` (Salesperson reference)
    - `opportunity_id` → `crm_lead.id` (CRM link)
    - `warehouse_id` → `stock_warehouse.id` (Inventory link)
- **Natural keys (inferred):** 
    - `name` (The unique order number assigned by Odoo)

## Caveats for downstream consumers

- **Sensitive Data:** `customer_email` is not present, but `signed_by` and `client_order_ref` may contain PII.
- **Timezones:** Timestamps are typically stored in UTC in Odoo; verify against system configuration.
- **Soft Deletes:** Odoo generally does not use soft deletes; records are usually updated or cancelled (`state` = 'cancel').
- **Precision:** `NUMERIC` fields are typically stored with 2 decimal places, but check for currency-specific rounding rules.
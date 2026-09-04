# odoo_payment_link_wizard

## Source system
This table originates from Odoo ERP. The naming convention `payment_link_wizard` and the presence of `res_model` and `res_id` fields are characteristic of Odoo's dynamic object-linking architecture, which uses wizards to generate transient payment URLs for various business documents (e.g., invoices or sales orders).

## Functional process 
This table supports the payment collection process by tracking the configuration of generated payment links. It captures the financial parameters (amounts, currency) and the target business object (model and ID) for which a payment link is being created, facilitating the integration between the ERP and external payment gateways.

## Description
One row in this table represents a single instance of a payment link generation request initiated via the Odoo wizard. It serves as a raw staging record, capturing the state of the payment link configuration at the time of creation or update. This table is used to track the link's financial scope and its association with specific business entities within the Odoo ecosystem.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; managed by Odoo. |
| res_id | INTEGER | false | ID of the related business object | References the record ID in the model defined by `res_model`. |
| currency_id | INTEGER | true | Foreign key to currency | References the currency used for the payment link. |
| partner_id | INTEGER | true | Foreign key to partner | References the customer or contact associated with the link. |
| create_uid | INTEGER | true | Creator user ID | References the system user who initiated the wizard. |
| write_uid | INTEGER | true | Last modifier user ID | References the system user who last updated the record. |
| res_model | VARCHAR | false | Source model name | The technical name of the Odoo model (e.g., 'account.move'). |
| amount | NUMERIC | false | Target amount | The specific amount requested for payment. |
| amount_max | NUMERIC | true | Maximum allowed amount | The upper limit for the payment link, if applicable. |
| create_date | TIMESTAMP | true | Record creation timestamp | Recorded in UTC by the Odoo server. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the Odoo server. |
| discount_date | DATE | true | Early payment discount date | The deadline for applying an early payment discount. |
| open_installments | JSONB | true | Installment details | Stores structured data regarding payment installments. |
| has_eligible_epd | BOOLEAN | true | Early payment discount flag | Indicates if the transaction is eligible for an early payment discount. |
| amount_paid | NUMERIC | true | Amount already paid | Tracks partial payments made against the link. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `currency_id` → `res_currency.id` (Standard Odoo naming convention for currency references).
    - `partner_id` → `res_partner.id` (Standard Odoo naming convention for customer/contact references).
    - `create_uid` → `res_users.id` (Standard Odoo naming convention for user references).
    - `write_uid` → `res_users.id` (Standard Odoo naming convention for user references).
- **Natural keys (inferred):** Not confidently inferable. While `res_model` and `res_id` identify the target, they do not uniquely identify the wizard instance itself.

## Caveats for downstream consumers

- **Timestamps:** All `TIMESTAMP` fields are stored in UTC as per standard Odoo behavior.
- **Sensitive Data:** `partner_id` links to customer information; ensure appropriate access controls are applied when joining with PII-heavy tables.
- **Data Integrity:** `res_model` and `res_id` form a polymorphic association; ensure queries handle the dynamic nature of these fields when joining to source tables.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume records are hard-deleted if removed from the source.
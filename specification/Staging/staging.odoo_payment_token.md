# odoo_payment_token

## Source system
This table originates from Odoo ERP, as evidenced by the naming convention (e.g., `partner_id`, `create_uid`, `write_uid`, `write_date`) and the specific structure of the `id` column using a sequence generator typical of Odoo's PostgreSQL backend.

## Functional process 
This table supports the payment processing and subscription billing module. It stores vaulted payment tokens provided by external payment gateways (like Stripe or Authorize.net), linking them to specific customers (`partner_id`) and payment methods to facilitate recurring billing or one-click checkout flows.

## Description
One row in this table represents a single payment token or "vaulted" payment instrument associated with a customer. It acts as a raw landing copy of the Odoo `payment.token` model, capturing the reference provided by the payment provider and the internal metadata required to manage the token's lifecycle within the ERP.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `staging.payment_token_id_seq`. |
| provider_id | INTEGER | false | Foreign key to payment provider | Links to the payment acquirer configuration. |
| company_id | INTEGER | true | Foreign key to company | Multi-company context identifier. |
| payment_method_id | INTEGER | false | Foreign key to payment method | Defines the type of payment instrument. |
| partner_id | INTEGER | false | Foreign key to customer | The owner of the payment token. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| payment_details | VARCHAR | true | Masked payment details | Often contains masked card numbers or display labels. |
| provider_ref | VARCHAR | false | External provider reference | The unique token ID issued by the payment gateway. |
| active | BOOLEAN | true | Soft-delete flag | Indicates if the token is currently enabled for use. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the Odoo ORM. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the Odoo ORM. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `provider_id` → `staging.odoo_payment_provider.id` (Inferred from Odoo architecture).
    - `partner_id` → `staging.odoo_res_partner.id` (Inferred from Odoo architecture).
- **Natural keys (inferred):** 
    - `provider_ref` (The external gateway token is unique per provider).

## Caveats for downstream consumers

- **Sensitive Data:** The `payment_details` column may contain PII or PCI-sensitive fragments; ensure appropriate masking policies are applied.
- **Timestamps:** Timestamps are stored in the Odoo application server time (typically UTC), but verify against the source system configuration.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should generally filter by `WHERE active = TRUE` unless performing audit or historical analysis.
- **Data Integrity:** As a staging table, this is a raw dump; expect potential duplicates or inconsistencies if the Odoo source has undergone manual database-level interventions.
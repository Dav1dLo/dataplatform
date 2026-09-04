# odoo_payment_provider_onboarding_wizard

## Source system
This table originates from Odoo ERP. The naming convention `odoo_payment_provider_onboarding_wizard` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal ORM-managed tables.

## Functional process 
This table supports the "Payment Provider Onboarding" business process, specifically tracking the state of the configuration wizard used to set up payment gateways (like PayPal or manual bank transfers) within the Odoo accounting or e-commerce modules. It captures the user-provided configuration details required to link external payment services to the internal journal system.

## Description
One row in this table represents a single instance of a payment provider configuration session initiated by a user. It acts as a raw landing copy of the wizard's state, capturing the parameters entered during the setup process before they are persisted to the final payment provider configuration entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.payment_provider_onboarding_wizard_id_seq`. |
| create_uid | INTEGER | true | ID of the user who created the record | References the Odoo `res.users` table. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References the Odoo `res.users` table. |
| payment_method | VARCHAR | true | Selected payment method identifier | Likely a code or slug representing the provider type. |
| paypal_email_account | VARCHAR | true | PayPal account email address | Sensitive PII; used for PayPal-specific integration. |
| manual_name | VARCHAR | true | Display name for manual payment method | Used when the provider is set to manual/wire transfer. |
| journal_name | VARCHAR | true | Associated accounting journal name | Links the payment provider to an Odoo accounting journal. |
| acc_number | VARCHAR | true | Bank account number | Sensitive financial data; used for manual payment setup. |
| manual_post_msg | TEXT | true | Custom message for manual payments | Instructions displayed to the customer upon checkout. |
| create_date | TIMESTAMP | true | Creation timestamp | Odoo system timestamp; assume UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Odoo system timestamp; assume UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** This table contains PII (`paypal_email_account`) and financial data (`acc_number`). Ensure appropriate masking or access controls are applied.
- **Timestamps:** Timestamps are recorded in the Odoo system time, which is typically configured to UTC.
- **Data Lifecycle:** This is a staging table; it represents the raw state of a wizard. Records may be transient or overwritten depending on the Odoo module's implementation of the wizard's lifecycle.
- **Type Precision:** `VARCHAR` lengths are not explicitly defined in the source metadata; downstream consumers should account for variable-length strings and potential truncation if mapping to fixed-width columns.
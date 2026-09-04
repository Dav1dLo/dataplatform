# odoo_sale_payment_provider_onboarding_wizard

## Source system
This table originates from Odoo, an open-source ERP system. The naming convention `sale_payment_provider_onboarding_wizard` and the presence of `create_uid`, `write_uid`, and `_date` audit columns are characteristic of Odoo's internal ORM-managed tables.

## Functional process 
This table supports the "Payment Provider Onboarding" business process, specifically the wizard-driven configuration flow for setting up payment gateways (such as PayPal or manual wire transfers) within the Odoo sales/accounting module. It captures the temporary state and configuration details provided by a user during the setup of a payment provider.

## Description
One row in this table represents a single instance of a payment provider onboarding wizard session. It acts as a raw landed copy of the wizard's state, tracking the configuration parameters entered by a user before they are committed to the permanent payment provider settings.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated ID. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the system user who initiated the wizard. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the system user who last updated the wizard. |
| payment_method | VARCHAR | true | Selected payment method | The type of payment provider being configured. |
| paypal_email_account | VARCHAR | true | PayPal account email | Specific configuration field for PayPal integration. |
| manual_name | VARCHAR | true | Manual payment name | Label for manual payment methods. |
| journal_name | VARCHAR | true | Accounting journal name | The associated accounting journal for the payment. |
| acc_number | VARCHAR | true | Bank account number | Account identifier for manual payments. |
| manual_post_msg | TEXT | true | Post-payment message | Custom message displayed to the customer after payment. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Inferred UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for user tracking).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for user tracking).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** The `paypal_email_account` and `acc_number` columns contain PII and financial identifiers; ensure these are masked in non-production environments.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with Odoo's default database configuration.
- **Data Lifecycle:** This table represents a "wizard" state; rows may be transient or intended for deletion after the onboarding process is finalized.
- **Precision:** `VARCHAR` lengths are not explicitly defined in the source metadata; downstream systems should allow for standard Odoo string lengths (typically 255 characters).
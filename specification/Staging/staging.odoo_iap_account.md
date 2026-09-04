# odoo_iap_account

## Source system
This table originates from Odoo, an open-source ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the specific reference to "IAP" (In-App Purchase) are characteristic of Odoo's internal module architecture for managing external service credits and API tokens.

## Functional process 
This table supports the In-App Purchase (IAP) service management process within Odoo. It tracks the authentication tokens, credit balances, and configuration thresholds for various third-party services (such as SMS gateways, OCR services, or document signing) that the Odoo instance consumes.

## Description
One row in this table represents a single configured In-App Purchase account linked to a specific service. It acts as a raw landing copy of the Odoo `iap.account` model, storing the credentials and operational status required to interface with external service providers.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `staging.iap_account_id_seq`. |
| service_id | INTEGER | false | Identifier for the IAP service | Links to the specific service definition. |
| create_uid | INTEGER | true | User ID who created the record | References the internal Odoo user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the internal Odoo user table. |
| name | VARCHAR | true | Account display name | Human-readable label for the account. |
| account_token | VARCHAR(43) | true | Authentication token | Sensitive credential used for API calls. |
| balance | VARCHAR | true | Current credit balance | Stored as VARCHAR; likely requires casting to numeric. |
| state | VARCHAR | true | Operational state of the account | Indicates if the account is active or suspended. |
| service_locked | BOOLEAN | true | Lock status flag | Prevents modifications if true. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC based on Odoo standard. |
| write_date | TIMESTAMP | true | Last update timestamp | Inferred UTC based on Odoo standard. |
| warning_threshold | DOUBLE PRECISION | true | Credit alert threshold | Triggers notifications when balance is low. |
| sender_name | VARCHAR | true | Configured sender identity | Used for services like SMS marketing. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: Standard Odoo audit column pattern).
    - `write_uid` → `res_users.id` (Guess: Standard Odoo audit column pattern).
- **Natural keys (inferred):** 
    - `account_token` (Likely unique per service provider).

## Caveats for downstream consumers

- **Sensitive Data:** The `account_token` column contains authentication credentials and should be masked or restricted in downstream reporting environments.
- **Data Types:** The `balance` column is stored as a `VARCHAR` despite representing a numeric value; ensure explicit casting to `NUMERIC` or `DECIMAL` before performing arithmetic.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with Odoo's internal storage format.
- **Soft Deletes:** This table does not explicitly show a `deleted` or `active` flag, but Odoo often uses an `active` boolean column (not present here) to handle soft deletes; verify if missing records indicate deletion.
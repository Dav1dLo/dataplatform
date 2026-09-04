# odoo_auth_totp_device

## Source system
This table originates from Odoo ERP, as evidenced by the naming convention `odoo_auth_totp_device` and the use of Odoo-specific patterns such as `create_date` with UTC defaults and the `res.users` linkage implied by `user_id`.

## Functional process 
This table supports the identity and access management (IAM) process, specifically tracking multi-factor authentication (MFA) devices registered by users. It manages the lifecycle of TOTP (Time-based One-Time Password) tokens used for secure login verification.

## Description
One row in this table represents a single registered TOTP device or authentication token associated with a specific user account. It serves as a raw landed copy of the Odoo authentication configuration, providing the necessary cryptographic keys and metadata required to validate MFA challenges during the login process.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; internal Odoo ID. |
| name | VARCHAR | false | Device display name | Human-readable label for the registered device. |
| user_id | INTEGER | false | User identifier | Foreign key to the Odoo users table. |
| scope | VARCHAR | true | Authentication scope | Defines the context or limitations of the token. |
| expiration_date | TIMESTAMP | true | Token expiry | Timestamp when the device registration expires. |
| index | VARCHAR(8) | true | Device index | Short identifier or alias for the TOTP device. |
| key | VARCHAR | true | Secret key | The base32 encoded secret used for TOTP generation. |
| create_date | TIMESTAMP | true | Record creation timestamp | Ingested in UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `res_users.id` (Standard Odoo pattern for linking authentication records to user entities).
- **Natural keys (inferred):** 
    - Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `key` column contains the secret cryptographic material for MFA; this must be masked or restricted to authorized security roles only.
- **Timezone:** `create_date` is stored in UTC. `expiration_date` should be assumed to be UTC unless otherwise specified by Odoo system settings.
- **Data Integrity:** As a staging table, this represents a raw snapshot; there is no explicit soft-delete flag, so assume records are removed from the source if they disappear from this table.
- **Precision:** `VARCHAR` columns without defined lengths (e.g., `name`, `key`) should be treated as potentially large; verify source DDL if planning to map these to fixed-width fields in downstream systems.
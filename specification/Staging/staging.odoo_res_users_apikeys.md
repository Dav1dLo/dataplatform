# odoo_res_users_apikeys

## Source system
This table originates from Odoo ERP, specifically the `res_users_apikeys` model. The naming convention `res_users` is a standard Odoo pattern for core user management, and the presence of `apikeys` indicates this is the system-level storage for API authentication credentials used for external integrations.

## Functional process 
This table supports the authentication and security management process for external API access. It tracks individual API keys assigned to users, defining the scope of access, expiration constraints, and the unique identifiers required to validate incoming requests against the Odoo platform.

## Description
One row in this table represents a single API key assigned to a specific user account. It serves as a raw landed copy of the Odoo security configuration, providing the necessary metadata to validate and authorize API-based interactions with the ERP system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated identifier. |
| name | VARCHAR | false | Display name of the API key | Usually a descriptive label for the integration. |
| user_id | INTEGER | false | Foreign key to user | Links the key to the owner in `res_users`. |
| scope | VARCHAR | true | Access permissions | Defines the functional scope of the key. |
| expiration_date | TIMESTAMP | true | Expiry timestamp | The date/time after which the key is invalid. |
| index | VARCHAR(8) | true | Key index/prefix | Often used for quick lookups or key identification. |
| key | VARCHAR | true | API key secret | The actual credential; sensitive data. |
| create_date | TIMESTAMP | true | Record creation timestamp | Defaults to UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `staging.res_users.id` (Standard Odoo relationship linking API keys to the owning user record).
- **Natural keys (inferred):** 
    - `key` (The secret value itself acts as the unique identifier for authentication).

## Caveats for downstream consumers

- **Security:** The `key` column contains sensitive authentication secrets; ensure this column is masked or restricted in downstream reporting environments.
- **Timezone:** `create_date` is explicitly set to UTC; assume `expiration_date` follows the same convention unless Odoo application settings dictate otherwise.
- **Data Integrity:** As a staging table, this contains raw values; verify if `key` is hashed or stored in plain text before performing any analysis.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume rows are physically removed from the source if they disappear from the staging feed.
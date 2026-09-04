# odoo_res_users_identitycheck

## Source system
This table originates from Odoo ERP, as indicated by the `res_users` naming convention which is standard for Odoo's user management module. The table structure reflects a raw landing of the `res.users.identitycheck` model, which handles secondary authentication or identity verification logs within the Odoo framework.

## Functional process 
This table supports the user security and authentication process. It tracks identity verification events, likely used for multi-factor authentication (MFA) or password confirmation prompts during sensitive user actions within the Odoo environment.

## Description
One row in this table represents a single identity verification attempt or authentication check performed by a user. It serves as a raw, append-only record of security-related identity challenges, capturing the method used and the associated request context.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.res_users_identitycheck_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users.id`. |
| write_uid | INTEGER | true | User ID who last updated the record | References `res_users.id`. |
| request | VARCHAR | true | The specific request or action context | Likely contains JSON or descriptive text of the triggered check. |
| auth_method | VARCHAR | true | Authentication method used | e.g., 'password', 'totp', 'email_code'. |
| password | VARCHAR | true | Encrypted or hashed password/token | Highly sensitive; likely contains a hash or masked value. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC based on Odoo standard. |
| write_date | TIMESTAMP | true | Last update timestamp | Inferred UTC based on Odoo standard. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit field for record creation).
    - `write_uid` → `res_users.id` (Standard Odoo audit field for record modification).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `password` column is highly sensitive and should be masked or excluded from non-security-related reporting.
- **Timezone:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Retention:** This table appears to be a raw log; verify if the source system performs periodic cleanup or archiving of these identity checks.
- **Nullability:** Many fields are nullable, suggesting that not all identity checks require a full set of audit metadata or that some fields are optional depending on the `auth_method`.
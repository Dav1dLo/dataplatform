# odoo_auth_totp_wizard

## Source system
This table originates from Odoo, an open-source ERP and business management software. The naming convention `auth_totp_wizard` and the presence of columns like `user_id`, `create_uid`, and `write_uid` are characteristic of Odoo's internal ORM-managed tables used for handling multi-factor authentication setup flows.

## Functional process 
This table supports the "User Security and Authentication" business process. It acts as a temporary state store for the Time-based One-Time Password (TOTP) configuration wizard, allowing users to generate and verify their MFA secrets and QR codes before finalizing their security settings.

## Description
One row in this table represents a single active or historical TOTP setup session for a specific user. It serves as a raw landing copy of the Odoo wizard state, capturing the cryptographic secret, the generated QR code image, and the verification code used during the MFA enrollment process.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence. |
| user_id | INTEGER | false | Foreign key to the user | Links to the system user configuring MFA. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who initiated the wizard. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| secret | VARCHAR | false | TOTP shared secret | The base32 encoded secret key. |
| url | VARCHAR | true | Provisioning URI | The otpauth:// URL for authenticator apps. |
| code | VARCHAR(7) | true | Verification code | Temporary code used for validation. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in server local time. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in server local time. |
| qrcode | BYTEA | true | QR code image | Binary data representing the QR image. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `res_users.id` (Standard Odoo pattern for linking wizard records to the owning user).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** The `secret` column contains raw MFA shared secrets and must be masked or restricted to authorized security roles only.
- **Timezone:** Timestamps (`create_date`, `write_date`) are stored in the Odoo server's local time; verify the server configuration to determine the offset from UTC.
- **Data Retention:** This table represents a "wizard" state; rows may be transient and deleted after the MFA setup is completed or abandoned.
- **Binary Data:** The `qrcode` column contains binary data (`BYTEA`); ensure downstream tools are capable of handling large binary objects if selecting this column.
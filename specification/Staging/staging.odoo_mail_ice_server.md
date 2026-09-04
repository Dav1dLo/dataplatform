# odoo_mail_ice_server

## Source system
This table originates from Odoo, an open-source ERP and CRM platform. The naming convention `mail_ice_server` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal ORM-managed tables used for configuring Interactive Connectivity Establishment (ICE) servers for WebRTC/VoIP communication features.

## Functional process 
This table supports the configuration and management of STUN/TURN servers used by the Odoo communication stack. It stores the necessary credentials and connection strings required for the system to facilitate real-time peer-to-peer media streaming for features like integrated VoIP or video conferencing.

## Description
One row in this table represents a single ICE server configuration record used for network traversal in communication sessions. It serves as a raw landing copy of the Odoo configuration entity, capturing the server type, URI, and authentication credentials required for the application to connect to external media relay services.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `staging.mail_ice_server_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References the Odoo user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the Odoo user table. |
| server_type | VARCHAR | false | Type of ICE server (e.g., STUN, TURN) | Defines the protocol/functionality of the server. |
| uri | VARCHAR | false | Connection URI for the ICE server | The network address/endpoint. |
| username | VARCHAR | true | Authentication username | Used for TURN server authentication. |
| credential | VARCHAR | true | Authentication password/secret | Sensitive data; likely stored as plain text or encrypted string. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last record update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo pattern for creator tracking).
    - `write_uid` → `res_users.id` (guess: standard Odoo pattern for modifier tracking).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** The `credential` column contains authentication secrets and should be masked or restricted in downstream reporting environments.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Integrity:** As this is a staging table, it reflects the raw state of the Odoo database; verify if the `credential` field requires decryption before use, as Odoo sometimes stores these as encrypted strings depending on the version.
- **Soft Deletes:** Odoo typically does not use soft-delete flags in these configuration tables; rows are usually physically deleted from the source.
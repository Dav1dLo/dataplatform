# odoo_iap_service

## Source system
This table originates from Odoo ERP, specifically the In-App Purchase (IAP) module. The naming convention (`create_uid`, `write_uid`, `create_date`, `write_date`) is characteristic of Odoo's ORM framework, which tracks record creation and modification metadata across its internal models.

## Functional process 
This table supports the management and configuration of In-App Purchase services within the Odoo ecosystem. It acts as a registry for available IAP services, defining their technical identifiers, display names, and whether they support integer-based balance tracking, which is essential for billing and credit-consumption workflows.

## Description
One row in this table represents a single IAP service definition available for integration within the Odoo platform. This table serves as a raw landed copy of the Odoo `iap.service` model, capturing the configuration state of services at the time of ingestion.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.iap_service_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References the Odoo `res.users` table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the Odoo `res.users` table. |
| name | VARCHAR | false | Display name of the IAP service | Human-readable label. |
| technical_name | VARCHAR | false | Internal system identifier | Used for programmatic service calls. |
| description | JSONB | false | Service description details | Likely contains multi-language or structured metadata. |
| unit_name | JSONB | false | Unit of measure for the service | Likely contains multi-language or structured metadata. |
| integer_balance | BOOLEAN | false | Balance type flag | If true, service uses integer credits; otherwise, float. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo pattern for tracking record creators).
    - `write_uid` → `res_users.id` (guess: standard Odoo pattern for tracking record modifiers).
- **Natural keys (inferred):** 
    - `technical_name`: This is the unique business identifier for the service within the Odoo IAP framework.

## Caveats for downstream consumers

- **Sensitive Data:** No direct PII, but `create_uid` and `write_uid` link to internal user accounts.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Handling:** This is a raw staging table; it does not implement soft deletes (it reflects the current state of the source table).
- **JSONB:** The `description` and `unit_name` columns contain JSONB data; ensure your downstream transformation logic handles potential schema evolution within these fields.
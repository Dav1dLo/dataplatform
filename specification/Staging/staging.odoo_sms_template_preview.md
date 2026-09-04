# odoo_sms_template_preview

## Source system
This table originates from Odoo ERP. The naming convention (`sms_template_preview`), the presence of Odoo-standard audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`), and the sequence-based primary key are characteristic of Odoo's internal ORM-managed tables.

## Functional process 
This table supports the communication and marketing module within Odoo, specifically the previewing of SMS templates before they are sent to recipients. It tracks the configuration and language settings used to generate a preview of an SMS message linked to a specific resource (e.g., a customer or sales order).

## Description
One row in this table represents a single generated preview instance of an SMS template. It serves as a raw landing copy of the Odoo `sms.template.preview` model, capturing the state of a preview request at a specific point in time.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `staging.sms_template_preview_id_seq`. |
| sms_template_id | INTEGER | false | Foreign key to the SMS template | Links to the parent template definition. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who initiated the preview. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the preview record. |
| lang | VARCHAR | true | Language code | ISO language code (e.g., 'en_US') used for the preview. |
| resource_ref | VARCHAR | true | Resource reference | A string reference (e.g., 'res.partner,123') identifying the target record. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp when the preview was created. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp when the preview was last modified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `sms_template_id` → `sms_template.id` (Inferred from Odoo naming conventions where `_id` suffixes denote relations).
    - `create_uid` → `res_users.id` (Standard Odoo pattern for user tracking).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for user tracking).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `resource_ref` may contain references to sensitive business entities; ensure appropriate access controls are applied.
- **Timezone:** Timestamps (`create_date`, `write_date`) are typically stored in UTC by Odoo; verify against the source application configuration.
- **Data Retention:** This table represents a staging landing zone; it may contain transient data or multiple versions of the same preview request if the source system does not perform hard deletes.
- **Encoding:** `VARCHAR` fields do not have defined lengths in the metadata; assume standard Odoo string handling which may vary by database collation.
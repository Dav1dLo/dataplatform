# odoo_sale_order_cancel

## Source system
This table originates from Odoo ERP, an open-source business management suite. The naming convention `odoo_sale_order_cancel` and the presence of Odoo-specific audit columns like `create_uid`, `write_uid`, and `create_date` are characteristic of Odoo's internal ORM-managed tables.

## Functional process 
This table supports the sales order cancellation and communication process. It stores the metadata and content of cancellation notifications or messages sent to customers when a sales order is cancelled, linking the cancellation event to a specific order and potentially a communication template.

## Description
One row in this table represents a single cancellation communication record associated with a sales order. It acts as a raw landing copy of the Odoo `sale.order.cancel` wizard or model data, capturing the context, language, and body of the message sent during the cancellation workflow.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated ID. |
| template_id | INTEGER | true | Foreign key to email template | References the communication template used. |
| author_id | INTEGER | true | Foreign key to partner/user | The user or partner who initiated the cancellation. |
| order_id | INTEGER | false | Foreign key to sale order | The specific sales order being cancelled. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| lang | VARCHAR | true | Language code | ISO language code (e.g., 'en_US'). |
| subject | VARCHAR | true | Email subject line | The subject of the cancellation notification. |
| body | TEXT | true | Email body content | The HTML or plain text content of the message. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp when the record was created. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp when the record was last modified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `order_id` → `staging.odoo_sale_order.id`: Links the cancellation record to the parent sales order.
    - `template_id` → `staging.odoo_mail_template.id`: Likely references an email template definition (guess).
    - `author_id` → `staging.odoo_res_partner.id`: Likely references the user or partner who authored the message (guess).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** The `body` column may contain PII or sensitive communication details; ensure appropriate masking if exposing to non-authorized users.
- **Timezone:** Timestamps (`create_date`, `write_date`) are typically stored in UTC by Odoo; verify against the source system configuration.
- **Data Integrity:** As a staging table, this represents a raw snapshot; it may contain multiple entries per `order_id` if the cancellation process was triggered or edited multiple times.
- **Soft Deletes:** Odoo typically uses `active` flags for soft deletes, but no such column is present here; assume this table contains the full history of cancellation records as they appear in the source.
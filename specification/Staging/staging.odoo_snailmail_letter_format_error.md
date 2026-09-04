# odoo_snailmail_letter_format_error

## Source system
This table originates from Odoo ERP, specifically the Snailmail module which handles physical mail dispatch. The naming convention (`odoo_snailmail_...`) and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal ORM-managed tables.

## Functional process 
This table supports the physical mail automation process by logging format-related errors encountered during the preparation of snailmail letters. It tracks which specific messages failed validation or formatting requirements, allowing administrators to identify and rectify document issues before dispatch.

## Description
One row represents a single format error event associated with a specific snailmail letter attempt. It acts as a raw landing record of validation failures, capturing the link to the original message and the administrative audit trail for the error entry.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; managed by Odoo ORM. |
| message_id | INTEGER | true | Foreign key to the mail.message table | Links the error to the specific communication record. |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who triggered the error log. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the user who last updated this error record. |
| snailmail_cover | BOOLEAN | true | Cover page flag | Indicates if a cover page was included in the failed letter. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC; audit timestamp for when the error was logged. |
| write_date | TIMESTAMP | true | Last update timestamp | Inferred UTC; audit timestamp for when the record was last modified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `message_id` → `mail.message.id`: This column typically references the core Odoo messaging system table.
    - `create_uid` → `res.users.id`: Standard Odoo pattern for tracking record ownership.
    - `write_uid` → `res.users.id`: Standard Odoo pattern for tracking record modification.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Odoo typically stores timestamps in UTC; verify against the application server configuration if precision is critical.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume standard Odoo behavior where records are either hard-deleted or remain indefinitely.
- **Data Integrity:** `message_id` is nullable, which may imply that some error logs are orphaned or represent system-level failures not tied to a specific message record.
- **PII:** While this table contains IDs and flags, ensure that any joined `mail.message` records are masked if they contain sensitive message content or recipient details.
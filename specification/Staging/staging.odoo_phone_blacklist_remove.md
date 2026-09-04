# odoo_phone_blacklist_remove

## Source system
This table originates from Odoo ERP, as indicated by the naming convention of the columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the specific table name pattern common to Odoo's phone blacklist management modules.

## Functional process 
This table supports the communication compliance and opt-out management process. It tracks requests to remove specific phone numbers from a blacklist, likely used to manage SMS or telephony marketing consent and ensure compliance with communication regulations.

## Description
One row in this table represents a single request or event to remove a phone number from the system's blacklist. This is a raw landing table in the staging layer, capturing the audit trail and reason for the removal request as recorded by the Odoo application.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.phone_blacklist_remove_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References the Odoo user table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the Odoo user table. |
| phone | VARCHAR | false | The phone number to be removed | Expected in E.164 or local format. |
| reason | VARCHAR | true | Justification for removal | Free-text field describing why the number was unblocked. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (guess: standard Odoo audit column).
    - `write_uid` → `res_users.id` (guess: standard Odoo audit column).
- **Natural keys (inferred):** 
    - `phone` (in the context of a blacklist removal, the phone number acts as the business identifier).

## Caveats for downstream consumers

- **PII:** The `phone` column contains personally identifiable information and should be masked or restricted according to data privacy policies.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Integrity:** As a staging table, this may contain duplicates or incomplete records if the source system allows multiple removal requests for the same number over time.
- **Soft Deletes:** This table does not appear to use a `deleted` flag; it represents an append-only log of removal requests.
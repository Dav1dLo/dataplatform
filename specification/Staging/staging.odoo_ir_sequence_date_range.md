# odoo_ir_sequence_date_range

## Source system
This table originates from Odoo ERP. The naming convention `ir_sequence_date_range` is specific to Odoo's internal registry (IR) module, which manages document numbering sequences (e.g., invoice or purchase order prefixes) that reset or change based on specific date ranges.

## Functional process 
This table supports the document numbering and sequence management process. It defines the specific numeric ranges and starting values (`number_next`) that apply to business documents within defined time intervals (`date_from` to `date_to`), ensuring that document identifiers remain unique and sequential over time.

## Description
One row represents a specific date-bound configuration for a document sequence, defining the next available number to be assigned for that period. This is a raw landed copy of the Odoo configuration table, serving as the staging layer for downstream audit and sequence tracking models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.ir_sequence_date_range_id_seq`. |
| sequence_id | INTEGER | false | Foreign key to the parent sequence | Links to the main sequence definition. |
| number_next | INTEGER | false | The next number to be used | The value assigned to the next document created. |
| create_uid | INTEGER | true | User ID who created the record | References `res.users`. |
| write_uid | INTEGER | true | User ID who last modified the record | References `res.users`. |
| date_from | DATE | false | Start date of the range | Inclusive start date for this sequence configuration. |
| date_to | DATE | false | End date of the range | Inclusive end date for this sequence configuration. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC timestamp of last update. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `sequence_id` → `staging.odoo_ir_sequence.id`: This column links the date range configuration to the primary sequence definition.
    - `create_uid` → `staging.odoo_res_users.id`: Tracks the user responsible for the record creation.
    - `write_uid` → `staging.odoo_res_users.id`: Tracks the user responsible for the last update.
- **Natural keys (inferred):** 
    - `(sequence_id, date_from, date_to)`: In Odoo, a sequence configuration is typically unique per sequence and date interval.

## Caveats for downstream consumers

- **Sensitive Data:** Contains `create_uid` and `write_uid`, which link to user identity tables; ensure these are handled according to internal access policies.
- **Timestamps:** Timestamps (`create_date`, `write_date`) are stored in UTC as per standard Odoo behavior.
- **Soft Deletes:** This table does not appear to implement soft deletes; records are typically hard-deleted or updated in place by the Odoo ORM.
- **Data Integrity:** `number_next` is a critical operational value; ensure joins to this table account for the fact that only one row should be active for a given date for a specific `sequence_id`.
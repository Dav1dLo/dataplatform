# odoo_ir_sequence

## Source system
This table originates from Odoo ERP, as evidenced by the `ir_sequence` naming convention, which is the standard internal table name for sequence generators in the Odoo framework.

## Functional process 
This table supports the document numbering and reference generation process across the ERP. It manages the configuration for auto-incrementing codes used for invoices, purchase orders, and other business entities, ensuring that unique, formatted identifiers are generated consistently.

## Description
One row in this table represents a single sequence configuration record, defining the rules for generating unique document numbers. It acts as a raw landed copy of Odoo's internal sequence metadata, used to track the current state and formatting logic for various business document counters.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `staging.ir_sequence_id_seq` for generation. |
| number_next | INTEGER | false | Next value to be used | The current counter value for the sequence. |
| number_increment | INTEGER | false | Increment step | The value added to the counter for each new document. |
| padding | INTEGER | false | Zero-padding width | Number of digits to pad the sequence number with. |
| company_id | INTEGER | true | Owning company ID | Links the sequence to a specific company in a multi-company setup. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this sequence record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this sequence record. |
| name | VARCHAR | false | Sequence name | Descriptive label for the sequence. |
| code | VARCHAR | true | Internal code | Unique identifier used by Odoo logic to call this sequence. |
| implementation | VARCHAR | false | Implementation method | Defines if the sequence is standard or 'no_gap'. |
| prefix | VARCHAR | true | Sequence prefix | String prepended to the generated number. |
| suffix | VARCHAR | true | Sequence suffix | String appended to the generated number. |
| active | BOOLEAN | true | Active status | Soft-delete flag; if false, the sequence is disabled. |
| use_date_range | BOOLEAN | true | Date range usage | Flag indicating if the sequence resets or changes based on dates. |
| create_date | TIMESTAMP | true | Creation timestamp | Record creation time in UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Record last modification time in UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Guess: standard Odoo multi-company link).
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit field).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit field).
- **Natural keys (inferred):** 
    - `code` (The internal code is typically unique within an Odoo instance for sequence identification).

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be mapped to human-readable names via a user dimension table.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database storage.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should generally filter by `WHERE active = TRUE` unless auditing historical configurations.
- **Precision:** `VARCHAR` lengths are not explicitly defined in the source metadata; assume standard Odoo field lengths (typically 255 or 64) but verify if truncations occur during ingestion.
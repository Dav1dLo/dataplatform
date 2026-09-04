# odoo_base_partner_merge_automatic_wizard

## Source system
This table originates from Odoo ERP. The naming convention `base_partner_merge_automatic_wizard` is characteristic of Odoo's internal "wizard" models, which are transient or stateful objects used to manage complex background processes—in this case, the automated deduplication of partner records.

## Functional process 
This table supports the Customer Data Management (CDM) process, specifically the automated deduplication of partner (customer/vendor) records. It tracks the configuration and execution state of batch jobs designed to identify and merge duplicate partner entries based on shared attributes like email, VAT, or company name.

## Description
One row in this table represents a single execution instance or configuration state of an automated partner merge job. It captures the criteria used to group potential duplicates (e.g., matching by email or VAT) and the current progress of the merge wizard. This is a raw landed copy of the Odoo wizard state, intended for auditing deduplication activities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `base_partner_merge_automatic_wizard_id_seq`. |
| number_group | INTEGER | true | Current group index | Tracks the current batch number being processed. |
| current_line_id | INTEGER | true | Current line reference | Foreign key to the specific line item being processed in the wizard. |
| dst_partner_id | INTEGER | true | Destination partner ID | The target partner record that duplicates are merged into. |
| maximum_group | INTEGER | true | Total groups | The total number of duplicate groups identified for processing. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who initiated the merge wizard. |
| write_uid | INTEGER | true | Last updater user ID | ID of the user who last modified the wizard state. |
| state | VARCHAR | false | Workflow state | Current status of the wizard (e.g., 'option', 'run', 'finished'). |
| group_by_email | BOOLEAN | true | Match by email | Flag indicating if duplicates are grouped by email address. |
| group_by_name | BOOLEAN | true | Match by name | Flag indicating if duplicates are grouped by partner name. |
| group_by_is_company | BOOLEAN | true | Match by company status | Flag indicating if duplicates are grouped by the 'is_company' attribute. |
| group_by_vat | BOOLEAN | true | Match by VAT | Flag indicating if duplicates are grouped by VAT number. |
| group_by_parent_id | BOOLEAN | true | Match by parent ID | Flag indicating if duplicates are grouped by parent partner ID. |
| exclude_contact | BOOLEAN | true | Exclude contacts | Flag to exclude individual contacts from the merge process. |
| exclude_journal_item | BOOLEAN | true | Exclude journal items | Flag to exclude partners with existing journal items from the merge. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp when the wizard record was created. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp when the wizard record was last modified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `dst_partner_id` → `res_partner.id` (Guess: links to the master partner record).
    - `create_uid` → `res_users.id` (Guess: links to the user who created the record).
    - `write_uid` → `res_users.id` (Guess: links to the user who last updated the record).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are stored in the Odoo application server time, typically UTC, but verify against the Odoo `ir.config_parameter` settings if precision is critical.
- **State Logic:** The `state` column is a string-based workflow indicator; downstream logic should treat this as a categorical variable.
- **Data Volatility:** As a "wizard" table, this data may be transient or frequently updated during the lifecycle of a single merge operation.
- **Sensitive Data:** While this table contains configuration flags, it references `dst_partner_id`, which may be linked to PII in the `res_partner` table. Ensure appropriate access controls are applied.
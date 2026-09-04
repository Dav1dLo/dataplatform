# odoo_account_bank_statement_ir_attachment_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` combined with the specific module prefixes `account_bank_statement` and `ir_attachment` is characteristic of Odoo's internal many-to-many relationship tables, which link financial records to the document management system (Attachments).

## Functional process 
This table supports the document management process within the accounting module. It facilitates the attachment of digital files (such as scanned receipts, bank statements, or invoices) to specific bank statement records, ensuring that supporting documentation is linked to financial transactions.

## Description
This table represents a many-to-many join relationship between bank statements and file attachments. Each row maps a single bank statement record to a single file attachment record. It serves as a raw landing copy of the Odoo relational link table, used to reconstruct document associations in downstream analytical models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_bank_statement_id | INTEGER | false | Foreign key to the bank statement | Links to the primary key of the `account_bank_statement` table. |
| ir_attachment_id | INTEGER | false | Foreign key to the attachment record | Links to the primary key of the `ir_attachment` table. |

## Keys

- **Primary key (inferred):** The combination of (`account_bank_statement_id`, `ir_attachment_id`) forms the composite primary key.
- **Foreign keys (inferred):** 
    - `account_bank_statement_id` → `account_bank_statement.id`: This column references the parent bank statement record.
    - `ir_attachment_id` → `ir_attachment.id`: This column references the metadata record for the attached file.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table contains no business data other than the relationship mapping; it is strictly a join table.
- There are no timestamps or audit columns present in this table; temporal analysis must be performed by joining to the parent `account_bank_statement` or `ir_attachment` tables.
- Ensure that joins to this table are handled as a bridge to avoid fan-out issues if a single bank statement has multiple attachments.
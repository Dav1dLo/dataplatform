# odoo_account_bank_statement_line

## Source system
This table originates from Odoo ERP, specifically the accounting module. The naming convention `account_bank_statement_line` and the presence of fields like `move_id`, `journal_id`, and `statement_id` are characteristic of Odoo's internal database schema for tracking bank transaction records.

## Functional process 
This table supports the bank reconciliation and financial accounting process. It captures individual transaction lines imported from bank statements or generated via payment processes, which are subsequently reconciled against accounting entries (`move_id`) to ensure the general ledger accurately reflects cash movements.

## Description
One row represents a single transaction line within a bank statement or a payment reconciliation entry. It serves as a raw landed copy of the Odoo `account.bank.statement.line` model, providing the granular detail required for financial auditing and cash flow reporting.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated ID. |
| move_id | INTEGER | false | Related accounting move | Foreign key to the accounting entry. |
| journal_id | INTEGER | false | Bank journal ID | Links to the specific bank account journal. |
| company_id | INTEGER | false | Company identifier | Multi-company context. |
| statement_id | INTEGER | true | Parent statement ID | Links to the header bank statement. |
| sequence | INTEGER | true | Display sequence | Used for ordering lines. |
| partner_id | INTEGER | true | Related partner ID | Customer or vendor associated with the transaction. |
| currency_id | INTEGER | true | Transaction currency | Currency of the amount field. |
| foreign_currency_id | INTEGER | true | Foreign currency | Used if the transaction is in a non-base currency. |
| create_uid | INTEGER | true | Creator user ID | User who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | User who last updated the record. |
| account_number | VARCHAR | true | Counterparty account | Bank account number of the counterparty. |
| partner_name | VARCHAR | true | Counterparty name | Name of the partner as provided by the bank. |
| transaction_type | VARCHAR | true | Transaction type | Category of the bank transaction. |
| payment_ref | VARCHAR | true | Payment reference | Memo or reference string from the bank. |
| internal_index | VARCHAR | true | Internal index | System-specific indexing string. |
| transaction_details | JSONB | true | Raw transaction metadata | Contains unstructured data from the bank feed. |
| amount | NUMERIC | true | Transaction amount | In company currency. |
| amount_currency | NUMERIC | true | Amount in foreign currency | Value in the transaction's original currency. |
| is_reconciled | BOOLEAN | true | Reconciliation status | Flag indicating if the line is matched to an entry. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of last modification. |
| amount_residual | DOUBLE PRECISION | true | Remaining amount | Unreconciled portion of the transaction. |
| pos_session_id | INTEGER | true | POS session ID | Links to Point of Sale transactions if applicable. |
| employee_id | INTEGER | true | Employee ID | Links to employee-related expenses or payments. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `move_id` → `account_move.id` (Links to the core accounting entry)
    - `journal_id` → `account_journal.id` (Links to the bank journal definition)
    - `partner_id` → `res_partner.id` (Links to the business partner entity)
- **Natural keys (inferred):** Not confidently inferable; Odoo typically relies on the surrogate `id` for internal linking.

## Caveats for downstream consumers

- **Sensitive Data:** `partner_name` and `account_number` may contain PII or sensitive banking information; handle according to data privacy policies.
- **Timestamps:** `create_date` and `write_date` are stored in UTC as per standard Odoo behavior.
- **Soft Deletes:** This table represents a raw landing; it does not explicitly implement soft-delete flags, but Odoo records are rarely physically deleted (often archived).
- **Data Types:** `transaction_details` is `JSONB`, which requires specific PostgreSQL operators (e.g., `->>`) for extraction in downstream queries.
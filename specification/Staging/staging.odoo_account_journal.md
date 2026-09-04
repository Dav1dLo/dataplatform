# odoo_account_journal

## Source system
This table originates from Odoo ERP, specifically the accounting module. The naming convention (e.g., `account_journal`, `create_uid`, `write_uid`, `JSONB` for translatable fields) is characteristic of the Odoo ORM structure.

## Functional process 
This table supports the financial accounting and ledger management process. It defines the journals (e.g., Sales, Purchase, Bank, Cash) used to record financial transactions, mapping them to specific general ledger accounts (`default_account_id`, `profit_account_id`, `loss_account_id`) and controlling transaction sequencing and currency behavior.

## Description
One row in this table represents a single accounting journal configuration within the Odoo system. It serves as a raw landed copy of the `account.journal` model, capturing the operational settings, account mappings, and behavioral flags required for financial posting and reporting.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| alias_id | INTEGER | true | Foreign key to mail alias | Links to email routing for the journal. |
| default_account_id | INTEGER | true | Default GL account | Used for journal entries. |
| suspense_account_id | INTEGER | true | Suspense GL account | Used for bank reconciliation. |
| sequence | INTEGER | true | Display order | UI sorting index. |
| currency_id | INTEGER | true | Currency reference | Foreign key to `res.currency`. |
| company_id | INTEGER | false | Company reference | Foreign key to `res.company`. |
| profit_account_id | INTEGER | true | Profit GL account | Used for exchange rate gains. |
| loss_account_id | INTEGER | true | Loss GL account | Used for exchange rate losses. |
| bank_account_id | INTEGER | true | Bank account reference | Foreign key to `res.partner.bank`. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to `res.users`. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to `res.users`. |
| color | INTEGER | true | UI color index | Used for dashboard styling. |
| access_token | VARCHAR | true | Security token | Used for external access/links. |
| code | VARCHAR(5) | false | Journal short code | Business-defined identifier (e.g., 'INV'). |
| type | VARCHAR | false | Journal type | e.g., 'sale', 'purchase', 'cash', 'bank'. |
| invoice_reference_type | VARCHAR | false | Reference format | Logic for invoice numbering. |
| invoice_reference_model | VARCHAR | false | Reference model | Logic for invoice numbering. |
| bank_statements_source | VARCHAR | true | Bank feed source | e.g., 'import', 'online_sync'. |
| name | JSONB | false | Journal name | Multilingual field; check Odoo JSONB structure. |
| sequence_override_regex | TEXT | true | Regex for sequence | Custom logic for sequence parsing. |
| active | BOOLEAN | true | Soft-delete flag | False indicates the journal is archived. |
| autocheck_on_post | BOOLEAN | true | Auto-check flag | Validation setting for posting. |
| restrict_mode_hash_table | BOOLEAN | true | Hash restriction | Used for legal audit compliance. |
| refund_sequence | BOOLEAN | true | Refund sequence flag | Whether to use a separate sequence for refunds. |
| payment_sequence | BOOLEAN | true | Payment sequence flag | Whether to use a separate sequence for payments. |
| show_on_dashboard | BOOLEAN | true | Dashboard visibility | Whether to display on the accounting dashboard. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Required for multi-company Odoo setups)
    - `currency_id` → `res_currency.id` (Defines the journal's functional currency)
    - `default_account_id` → `account_account.id` (Links to the chart of accounts)
- **Natural keys (inferred):** 
    - `code` (Unique short code used within a company context)

## Caveats for downstream consumers

- **Sensitive Data:** Contains internal IDs and potentially sensitive financial configuration; ensure access control is applied.
- **Timestamps:** Assumed to be in UTC, consistent with Odoo's internal storage.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should filter by `active = true` unless historical audit is required.
- **JSONB:** The `name` column is a `JSONB` object; use `name->>'en_US'` or similar syntax to extract specific language values.
- **Precision:** `VARCHAR` lengths for `access_token`, `type`, etc., are not explicitly constrained in the source; treat as variable length.
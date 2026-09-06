# odoo_account_account_account_journal_rel

## Source system
Odoo ERP (specifically the Odoo Accounting / Invoicing module). The table name follows Odoo's standard ORM convention for auto-generated many-to-many relationship tables (`<model1>_<model2>_rel`), linking the `account.account` model (General Ledger accounts) to the `account.journal` model (accounting journals).

## Functional process
General Ledger setup and financial transaction routing (Record-to-Report). This table manages the many-to-many association between chart-of-accounts entries and journals, establishing which accounts are permitted, restricted, or defaulted for posting within specific journals (e.g., bank, cash, sales, or purchase journals).

## Description
One row in this table represents a single valid association between one general ledger account and one accounting journal. It operates at the grain of one `account_account_id` per `account_journal_id`. Within the Staging layer, this serves as a raw relational junction table used downstream to reconstruct accounting dimensions and validate journal-account mappings.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| `account_account_id` | `INTEGER` | false | Foreign key / identifier for the General Ledger account (`account.account`). | Source system 32-bit integer surrogate ID; part of composite primary key. |
| `account_journal_id` | `INTEGER` | false | Foreign key / identifier for the accounting journal (`account.journal`). | Source system 32-bit integer surrogate ID; part of composite primary key. |

## Keys

- **Primary key (inferred):** Composite key `(account_account_id, account_journal_id)`.
- **Foreign keys (inferred):**
  - `account_account_id → staging.odoo_account_account.id` (guess based on standard Odoo ORM naming conventions for `account.account`).
  - `account_journal_id → staging.odoo_account_journal.id` (guess based on standard Odoo ORM naming conventions for `account.journal`).
- **Natural keys (inferred):** `(account_account_id, account_journal_id)` functions as both the technical and natural key for this relation entity.

## Caveats for downstream consumers

- No PII or payment-card data is present in this cross-reference table.
- This table contains no timestamps or audit columns (`create_date`, `write_date`), so incremental change capture based on high-water mark timestamps is not possible without full snapshots or tracking parent table updates.
- Deleted associations are hard-deleted in the source Odoo ORM; soft deletes (`active` flag) are typically maintained on the referenced parent entities (`account.account` or `account.journal`), not on this junction table.
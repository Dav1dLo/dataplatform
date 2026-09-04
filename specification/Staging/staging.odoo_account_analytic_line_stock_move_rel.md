# odoo_account_analytic_line_stock_move_rel

## Source system
This table originates from Odoo ERP. The naming convention `account_analytic_line_stock_move_rel` is characteristic of Odoo's internal many-to-many relationship tables, which are automatically generated to link analytic accounting entries to inventory movement records.

## Functional process 
This table supports the integration between inventory management and analytic accounting. It facilitates the mapping of specific stock movements (goods issued or received) to analytic lines, allowing for the tracking of costs or revenues associated with specific inventory transactions in the general ledger or project accounting modules.

## Description
One row in this table represents a single association between a stock move record and an analytic accounting line. It serves as a raw junction table in the staging layer, preserving the link between operational inventory events and their corresponding financial analytic distributions.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| stock_move_id | INTEGER | false | Foreign key to the stock move record | Links to the primary inventory movement table. |
| account_analytic_line_id | INTEGER | false | Foreign key to the analytic line record | Links to the analytic accounting distribution table. |

## Keys

- **Primary key (inferred):** The combination of `stock_move_id` and `account_analytic_line_id` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `stock_move_id` → `stock_move.id`: This column references the unique identifier of the inventory movement.
    - `account_analytic_line_id` → `account_analytic_line.id`: This column references the unique identifier of the analytic accounting entry.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; expect many-to-many relationships between stock moves and analytic lines.
- There are no timestamps or audit columns present; rely on the parent tables for ingestion metadata.
- This table contains no PII or sensitive financial values directly, but it is critical for joining operational and financial datasets.
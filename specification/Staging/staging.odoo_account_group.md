# odoo_account_group

## Source system
This table originates from Odoo ERP, as evidenced by the characteristic naming conventions such as `create_uid`, `write_uid`, `company_id`, and the use of `JSONB` for multi-language field storage (a standard pattern in Odoo's PostgreSQL backend).

## Functional process 
This table supports the financial accounting module, specifically the configuration of the Chart of Accounts. It defines the hierarchical grouping of accounts used for financial reporting and balance sheet structuring, utilizing `code_prefix_start` and `code_prefix_end` to map ranges of account codes to specific groups.

## Description
One row represents a single account group within the Odoo financial hierarchy. It serves as a raw landed copy of the Odoo `account.group` model, providing the structural metadata required to aggregate financial data for reporting purposes.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| parent_id | INTEGER | true | Self-referencing foreign key to parent group | Defines the tree structure of account groups. |
| company_id | INTEGER | false | Foreign key to the owning company | Links the group to a specific legal entity. |
| create_uid | INTEGER | true | User ID who created the record | References the users table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the users table. |
| code_prefix_start | VARCHAR | true | Starting account code for this group | Used to filter accounts by range. |
| code_prefix_end | VARCHAR | true | Ending account code for this group | Used to filter accounts by range. |
| name | JSONB | false | Display name of the group | Likely contains localized strings; requires extraction. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `parent_id` → `staging.odoo_account_group.id`: Establishes the parent-child relationship for the account group hierarchy.
    - `company_id` → `staging.odoo_res_company.id` (guessed): Standard Odoo pattern for multi-company isolation.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **JSONB Handling:** The `name` column is stored as `JSONB`. Downstream queries will need to use the `->>` operator (e.g., `name->>'en_US'`) to extract readable text.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo PostgreSQL deployments.
- **Soft Deletes:** Odoo typically uses hard deletes for configuration tables; however, verify if `write_date` is used for incremental loading logic.
- **Hierarchy:** This table is self-referential; recursive CTEs are required to traverse the full account group tree.
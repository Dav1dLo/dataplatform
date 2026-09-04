# odoo_account_account_tag_product_template_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` and the presence of two foreign key columns indicate this is a standard Odoo join table used to manage a many-to-many relationship between product templates and account tags.

## Functional process 
This table supports the financial and inventory categorization process, specifically linking product templates to specific account tags. This allows for automated accounting rules where products are associated with specific tags that influence how revenue or expenses are mapped to the general ledger.

## Description
One row in this table represents a single association between a product template and an account tag. It serves as a raw landing copy of the Odoo join table, maintaining the many-to-many relationship required for product-to-tag mapping.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| product_template_id | INTEGER | false | Foreign key to the product template | Maps to the primary key of the product_template table. |
| account_account_tag_id | INTEGER | false | Foreign key to the account tag | Maps to the primary key of the account_account_tag table. |

## Keys

- **Primary key (inferred):** The combination of `product_template_id` and `account_account_tag_id` acts as the composite primary key.
- **Foreign keys (inferred):** 
    - `product_template_id` → `product_template.id`: Links to the product definition.
    - `account_account_tag_id` → `account_account_tag.id`: Links to the accounting tag definition.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present in this table, so incremental loading based on modification time is not possible.
- Ensure that joins to the target tables handle potential orphans if referential integrity is not strictly enforced in the source Odoo instance.
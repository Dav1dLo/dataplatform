# odoo_iap_account_res_company_rel

## Source system
This table originates from Odoo, an open-source ERP system. The naming convention `res_company_id` is a standard pattern for Odoo's "Resource" (res) module, which manages core organizational entities, while `iap_account_id` refers to Odoo's In-App Purchase (IAP) service accounts.

## Functional process 
This table supports the management of In-App Purchase (IAP) service entitlements across a multi-company Odoo environment. It acts as a bridge to associate specific IAP accounts with the legal entities (companies) that are authorized to consume or manage those service credits.

## Description
One row in this table represents a many-to-many relationship mapping between an Odoo IAP account and a company record. It serves as a raw landing copy of the join table used by the Odoo framework to enforce multi-company access control for IAP services.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| iap_account_id | INTEGER | false | Foreign key to the IAP account | References the primary key of the IAP account table. |
| res_company_id | INTEGER | false | Foreign key to the company | References the primary key of the `res_company` table. |

## Keys

- **Primary key (inferred):** The combination of `(iap_account_id, res_company_id)` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `iap_account_id → iap_account.id`: Links to the specific IAP service account configuration.
    - `res_company_id → res_company.id`: Links to the specific company entity defined in the Odoo system.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a join table; it contains no descriptive attributes, only relational identifiers.
- There are no timestamps or audit columns present in this staging extract.
- Ensure that joins to `res_company` and `iap_account` are handled as inner joins if you only require active associations.
- As a raw staging table, it reflects the state of the source database at the time of extraction; it does not track historical changes to these relationships.
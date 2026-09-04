# odoo_merge_opportunity_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` and the presence of `merge_id` and `opportunity_id` are characteristic of Odoo's internal many-to-many relationship tables used to track record merging operations within the CRM module.

## Functional process 
This table supports the CRM lead-to-opportunity pipeline, specifically the "Merge Opportunities" business process. It maintains the link between a master merge record and the individual opportunity records that were consolidated into it, ensuring auditability of which opportunities were combined.

## Description
One row in this table represents a single association between a merge operation and an opportunity record. It acts as a join table at the grain of one row per opportunity per merge event. As a staging table, it provides a raw, un-transformed copy of the Odoo database relationship link.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| merge_id | INTEGER | false | Foreign key to the parent merge operation record. | Links to the primary key of the merge event. |
| opportunity_id | INTEGER | false | Foreign key to the specific opportunity record involved. | Links to the primary key of the CRM opportunity. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite key of (`merge_id`, `opportunity_id`).
- **Foreign keys (inferred):** 
    - `merge_id` → `crm_merge_opportunity.id` (guess based on Odoo naming patterns).
    - `opportunity_id` → `crm_lead.id` (guess based on Odoo CRM schema where opportunities are stored in the `crm_lead` table).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table is a link table; it contains no descriptive attributes, only identifiers.
- Expect high cardinality on both columns if many opportunities are merged frequently.
- No timestamps are present; the order of merges cannot be determined from this table alone without joining to the parent merge record.
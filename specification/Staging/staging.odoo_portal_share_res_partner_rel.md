# odoo_portal_share_res_partner_rel

## Source system
This table originates from Odoo ERP. The naming convention `odoo_portal_share_res_partner_rel` is characteristic of Odoo's internal many-to-many relationship tables, which are automatically generated to link portal sharing configurations with partner records.

## Functional process 
This table supports the portal access management process. It maps specific portal sharing instances to the business partners (customers, vendors, or contacts) who have been granted access or are associated with those shares, facilitating the security and visibility model within the Odoo portal.

## Description
One row in this table represents a single association between a portal share record and a partner record. It acts as a join table at the staging layer, providing a raw, un-transformed link between the portal sharing configuration and the partner entity.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| portal_share_id | INTEGER | false | Foreign key to the portal share record | Links to the configuration of the shared portal access. |
| res_partner_id | INTEGER | false | Foreign key to the partner record | Links to the specific contact or entity granted access. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key on `(portal_share_id, res_partner_id)`.
- **Foreign keys (inferred):** 
    - `portal_share_id` → `portal_share.id` (Inferred from Odoo naming convention).
    - `res_partner_id` → `res_partner.id` (Inferred from Odoo naming convention).
- **Natural keys (inferred):** The combination of `(portal_share_id, res_partner_id)` acts as the business key for this relationship.

## Caveats for downstream consumers

- This table is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or soft-delete flags present; this table represents the current state of associations as captured during the last ingestion.
- Ensure that joins to `res_partner` and `portal_share` handle potential orphans if the upstream source has referential integrity gaps.
# odoo_res_partner_res_partner_category_rel

## Source system
This table originates from Odoo ERP. The naming convention `res_partner_res_partner_category_rel` is a standard pattern used by Odoo's ORM to manage many-to-many relationship tables between the `res.partner` (customer/contact) model and the `res.partner.category` (tag/label) model.

## Functional process 
This table supports the customer categorization and segmentation process. It maps individual business partners to specific categories or tags, allowing for filtered reporting, targeted marketing campaigns, and organizational grouping within the CRM module.

## Description
One row represents a single association between a specific partner and a specific category. This is a junction table used to resolve a many-to-many relationship, serving as a raw landed copy of the Odoo database link table.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| category_id | INTEGER | false | Foreign key to the partner category definition | References `res_partner_category.id`. |
| partner_id | INTEGER | false | Foreign key to the partner record | References `res_partner.id`. |

## Keys

- **Primary key (inferred):** The combination of `(category_id, partner_id)` is the composite primary key.
- **Foreign keys (inferred):** 
    - `category_id → res_partner_category.id`: Links to the definition of the category.
    - `partner_id → res_partner.id`: Links to the specific partner entity.
- **Natural keys (inferred):** Not confidently inferable; this is a technical join table.

## Caveats for downstream consumers

- This table contains no descriptive attributes, only identifiers; it must be joined with `res_partner` and `res_partner_category` to be meaningful.
- As a junction table, it does not contain soft-delete flags; records are typically removed physically when the association is deleted in the source system.
- Ensure joins handle the many-to-many cardinality correctly to avoid row duplication when aggregating partner data.
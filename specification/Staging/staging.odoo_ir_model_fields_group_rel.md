# odoo_ir_model_fields_group_rel

## Source system
This table originates from Odoo ERP. The naming convention `ir_model_fields_group_rel` is characteristic of Odoo's internal metadata schema, where `ir` stands for "Internal Resources," and the `_rel` suffix denotes a many-to-many join table managed by the Odoo ORM.

## Functional process 
This table supports the Odoo security and access control system. It maps specific model fields to user groups, defining which groups have access to or visibility of particular fields within the application's data model.

## Description
One row in this table represents a single association between a field definition and a security group. It acts as a link table (junction table) to facilitate many-to-many relationships between the `ir_model_fields` and `res_groups` entities. As a staging table, it provides a raw, unjoined view of these security mappings as they exist in the source database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| field_id | INTEGER | false | Foreign key to the field definition | References the primary key of the `ir_model_fields` table. |
| group_id | INTEGER | false | Foreign key to the security group | References the primary key of the `res_groups` table. |

## Keys

- **Primary key (inferred):** The composite key `(field_id, group_id)` is the inferred primary key, as this is a standard join table structure in Odoo.
- **Foreign keys (inferred):** 
    - `field_id` → `ir_model_fields.id`: Links to the specific field being restricted.
    - `group_id` → `res_groups.id`: Links to the specific user group receiving the restriction.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There is no audit timestamp (e.g., `create_date` or `write_date`) present in this staging extract; changes to these relationships cannot be tracked via incremental loads based on time.
- Ensure that joins to `ir_model_fields` and `res_groups` are handled as inner joins if you only require active, valid security mappings.
- This table does not contain soft-delete flags; it reflects the current state of the Odoo ORM relationship table.
# odoo_ir_model_inherit

## Source system
This table originates from Odoo ERP. The naming convention `ir_model_inherit` is specific to the Odoo internal registry (`ir`), which manages the inheritance structure of models (objects) within the framework's ORM layer.

## Functional process 
This table supports the Odoo framework's metadata management, specifically the "Model Inheritance" process. It tracks how different models extend or inherit from base models, allowing the system to resolve field dependencies and class hierarchies during application runtime.

## Description
One row in this table represents a single inheritance relationship between two Odoo models, where a child model inherits functionality from a parent model. It serves as a raw landed copy of the Odoo `ir.model.inherit` system table, capturing the structural links required to reconstruct the object-relational model at the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by sequence `staging.ir_model_inherit_id_seq`. |
| model_id | INTEGER | false | Foreign key to the child model | References the model that is inheriting. |
| parent_id | INTEGER | false | Foreign key to the parent model | References the model being inherited from. |
| parent_field_id | INTEGER | true | Foreign key to the specific field | Optional reference to the field that triggers the inheritance. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `model_id` → `staging.odoo_ir_model.id`: Represents the child model in the inheritance chain.
    - `parent_id` → `staging.odoo_ir_model.id`: Represents the parent model being extended.
    - `parent_field_id` → `staging.odoo_ir_model_fields.id`: Represents the specific field definition linking the inheritance.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table contains structural metadata; it does not contain transactional business data.
- The `parent_field_id` is frequently null in cases of standard class-level inheritance where no specific field override is defined.
- As this is a raw staging table, it reflects the state of the Odoo system at the time of extraction; there is no explicit soft-delete flag, so assume rows are removed if they disappear from the source.
- Ensure joins to `odoo_ir_model` are handled carefully, as this table represents the "glue" between model definitions.
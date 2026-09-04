# odoo_ir_model_fields

## Source system
This table originates from Odoo ERP, specifically the `ir.model.fields` system table. It is a core metadata table used by the Odoo framework to manage the schema definition of all models and fields within the application.

## Functional process 
This table supports the Odoo dynamic ORM (Object-Relational Mapping) system. It tracks the configuration of every field across all models in the system, including data types, constraints (required, readonly), and relational properties. It is essential for generating dynamic views, API schemas, and database migrations within the Odoo ecosystem.

## Description
One row in this table represents a single field definition for a specific Odoo model. It acts as a raw landed copy of the Odoo system metadata, providing the structural definition of the application's data layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| relation_field_id | INTEGER | true | Foreign key to the related field | Used for relational field mapping. |
| model_id | INTEGER | false | Foreign key to the model | Links to the parent model definition. |
| related_field_id | INTEGER | true | Foreign key to the related field | Used for related field definitions. |
| size | INTEGER | true | Field size constraint | Used for character/text fields. |
| create_uid | INTEGER | true | Creator user ID | References the user who created the field. |
| write_uid | INTEGER | true | Last updater user ID | References the user who last modified the field. |
| name | VARCHAR | false | Technical field name | The internal name used in code. |
| complete_name | VARCHAR | true | Fully qualified field name | Often model.field format. |
| model | VARCHAR | false | Model technical name | The model this field belongs to. |
| relation | VARCHAR | true | Target model for relations | Used for Many2one/One2many fields. |
| relation_field | VARCHAR | true | Inverse field name | Used for relational mapping. |
| ttype | VARCHAR | false | Field data type | e.g., char, integer, boolean, many2one. |
| related | VARCHAR | true | Related field path | Dot-notation path for related fields. |
| state | VARCHAR | false | Field state | e.g., 'base' (system) or 'manual' (custom). |
| on_delete | VARCHAR | true | Deletion behavior | e.g., 'cascade', 'set null'. |
| domain | VARCHAR | true | Field domain filter | Filter criteria for relational fields. |
| relation_table | VARCHAR | true | Join table name | Used for Many2many relationships. |
| column1 | VARCHAR | true | Join column 1 | Used for Many2many relationships. |
| column2 | VARCHAR | true | Join column 2 | Used for Many2many relationships. |
| depends | VARCHAR | true | Computed field dependencies | List of fields triggering recompute. |
| currency_field | VARCHAR | true | Currency field name | Used for monetary fields. |
| field_description | JSONB | false | Human-readable label | Localized label stored as JSON. |
| help | JSONB | true | Tooltip/Help text | Localized help text. |
| compute | TEXT | true | Compute method logic | Python code snippet for computed fields. |
| copied | BOOLEAN | true | Copy flag | Whether the field is copied during record duplication. |
| required | BOOLEAN | true | Required constraint | Whether the field is mandatory. |
| readonly | BOOLEAN | true | Readonly constraint | Whether the field is editable. |
| index | BOOLEAN | true | Index flag | Whether the field is indexed in the DB. |
| translate | BOOLEAN | true | Translation flag | Whether the field supports translations. |
| company_dependent | BOOLEAN | true | Multi-company flag | Whether the value varies by company. |
| group_expand | BOOLEAN | true | Group expand flag | Used in Kanban/Pivot views. |
| selectable | BOOLEAN | true | Selectable flag | Whether the field is available for search/views. |
| store | BOOLEAN | true | Stored flag | Whether the field is persisted in the DB. |
| sanitize | BOOLEAN | true | Sanitize flag | HTML sanitization for text fields. |
| sanitize_overridable | BOOLEAN | true | Sanitize override flag | Allows overriding sanitization. |
| sanitize_tags | BOOLEAN | true | Sanitize tags flag | HTML tag sanitization. |
| sanitize_attributes | BOOLEAN | true | Sanitize attributes flag | HTML attribute sanitization. |
| sanitize_style | BOOLEAN | true | Sanitize style flag | HTML style sanitization. |
| sanitize_form | BOOLEAN | true | Sanitize form flag | HTML form sanitization. |
| strip_style | BOOLEAN | true | Strip style flag | Strip style tags. |
| strip_classes | BOOLEAN | true | Strip classes flag | Strip CSS classes. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp. |
| tracking | INTEGER | true | Tracking level | Audit trail configuration. |
| website_form_blacklisted | BOOLEAN | true | Website blacklist flag | Whether field is excluded from web forms. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `model_id` → `ir_model.id` (Links to the model definition table).
- **Natural keys (inferred):** 
    - `model`, `name` (The combination of model name and field name is unique within the Odoo system).

## Caveats for downstream consumers

- **Sensitive Data:** `field_description` and `help` contain localized strings; while generally not PII, they may contain internal business terminology.
- **Timestamps:** `create_date` and `write_date` are stored in UTC.
- **Soft Deletes:** This table generally reflects the current state of the Odoo schema; it does not typically implement soft deletes for field definitions.
- **JSONB Usage:** `field_description` and `help` are `JSONB` types; ensure your query dialect supports JSONB extraction (e.g., `->>`) if you need to access specific language keys.
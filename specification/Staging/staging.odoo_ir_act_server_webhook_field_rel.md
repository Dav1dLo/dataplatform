# odoo_ir_act_server_webhook_field_rel

## Source system
This table originates from Odoo ERP. The naming convention `ir_act_server_webhook_field_rel` follows the standard Odoo pattern for a many-to-many relationship table (often suffixed with `_rel`) linking server actions to specific fields, likely used in the context of webhook configurations or automated server actions.

## Functional process 
This table supports the configuration of automated server actions and webhook payloads within Odoo. It manages the association between specific server action definitions and the data fields that should be included or processed when those actions are triggered.

## Description
One row in this table represents a single association between a server action and a data field. It acts as a join table to resolve a many-to-many relationship between server actions and fields. As a staging table, it provides a raw, normalized view of these associations as they exist in the Odoo database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| server_id | INTEGER | false | Foreign key to the server action definition. | Links to `ir_act_server`. |
| field_id | INTEGER | false | Foreign key to the field definition. | Links to `ir_model_fields`. |

## Keys

- **Primary key (inferred):** The combination of `(server_id, field_id)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `server_id` → `ir_act_server.id`: This column references the parent server action record.
    - `field_id` → `ir_model_fields.id`: This column references the specific field being linked to the action.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a link table; queries should expect to join this against `ir_act_server` and `ir_model_fields` to retrieve meaningful business context.
- There are no timestamps or audit columns present; incremental loading logic cannot rely on standard Odoo `write_date` or `create_date` fields within this specific table.
- This table contains no PII or sensitive data, as it only stores internal system identifiers.
# odoo_rel_server_actions

## Source system
This table originates from Odoo ERP. The naming convention `rel_` combined with the column names `server_id` and `action_id` is characteristic of Odoo's internal many-to-many relationship tables used to link server-side actions to specific configurations or modules.

## Functional process 
This table supports the Odoo automation and server action framework. It manages the association between server-side action definitions and their assigned execution contexts or parent entities, ensuring that triggers or scheduled tasks correctly map to the intended server-side logic.

## Description
One row in this table represents a single link between a server action and its associated entity. It serves as a raw landing copy of a join table from the Odoo PostgreSQL database, maintaining the structural integrity of the many-to-many relationship between these two entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| server_id | INTEGER | false | Foreign key to the server entity | Represents the parent or related server configuration ID. |
| action_id | INTEGER | false | Foreign key to the action entity | Represents the specific server action being linked. |

## Keys

- **Primary key (inferred):** The combination of `(server_id, action_id)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `server_id` → `server.id` (Guess: standard Odoo naming convention for linking to a server/config table).
    - `action_id` → `ir_actions.id` (Guess: standard Odoo naming convention for linking to the `ir_actions` table).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a join table; expect no descriptive attributes, only relationship identifiers.
- Ensure that joins to parent tables handle the potential for missing records if the source system has performed cascading deletes that were not captured in this staging snapshot.
- No sensitive PII is contained in this table.
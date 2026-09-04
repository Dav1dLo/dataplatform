# odoo_team_favorite_user_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` is a standard pattern used by the Odoo ORM to represent many-to-many relationship tables (link tables) between two entities.

## Functional process 
This table supports the user management and team collaboration module within Odoo. It tracks the association between teams and their "favorite" or "pinned" users, allowing the system to surface specific users within the context of a team's workspace.

## Description
One row in this table represents a single association between a team and a user, indicating that the user has been marked as a favorite for that specific team. This is a raw landing of a many-to-many join table, serving as the base for downstream relationship modeling.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| team_id | INTEGER | false | Foreign key to the team entity | Maps to the primary key of the teams table. |
| user_id | INTEGER | false | Foreign key to the user entity | Maps to the primary key of the users table. |

## Keys

- **Primary key (inferred):** The composite key `(team_id, user_id)` is the inferred primary key, as this is a standard join table structure in Odoo.
- **Foreign keys (inferred):** 
    - `team_id` → `res_partner` or `crm_team`.id (Guess: Based on Odoo naming conventions for team-related entities).
    - `user_id` → `res_users`.id (Guess: Standard Odoo reference for system users).
- **Natural keys (inferred):** The combination of `team_id` and `user_id` acts as the natural business key for this relationship.

## Caveats for downstream consumers

- This table contains no surrogate primary key; ensure your join logic accounts for the composite nature of the relationship.
- There are no audit timestamps (e.g., `create_date` or `write_date`) present in this table, so incremental loading based on time is not possible without joining to a parent entity.
- This is a link table; expect high cardinality if many users are associated with many teams.
# odoo_discuss_gif_favorite

## Source system
Odoo ERP. The table naming convention (`discuss_gif_favorite`) and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) strongly indicate this is a direct extraction from an Odoo PostgreSQL database module related to the Discuss/Messaging application.

## Functional process 
This table supports the user-specific "favorites" functionality within the Odoo Discuss module. It tracks which GIFs (identified by their Tenor platform ID) have been bookmarked or favorited by specific users within the system, facilitating quick access to frequently used media in chat interfaces.

## Description
One row represents a single GIF favorite association linked to a specific user. This is a raw landed copy of the Odoo `discuss.gif.favorite` model, capturing the relationship between a user and a Tenor GIF ID. It serves as the staging entity for downstream analysis of user engagement and media usage patterns within the messaging platform.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; default uses `staging.discuss_gif_favorite_id_seq`. |
| create_uid | INTEGER | true | User ID who created the favorite | References the Odoo `res.users` table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the Odoo `res.users` table. |
| tenor_gif_id | VARCHAR | false | Unique identifier from Tenor | The external ID used to fetch the GIF from the Tenor API. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC; standard Odoo audit field. |
| write_date | TIMESTAMP | true | Record last update timestamp | Inferred UTC; standard Odoo audit field. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit pattern for creator).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit pattern for updater).
- **Natural keys (inferred):** 
    - The combination of `create_uid` and `tenor_gif_id` likely forms the business-level uniqueness constraint.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user activity metadata; ensure `create_uid` is handled according to internal PII/privacy policies if linked to user identities.
- **Timestamps:** Odoo typically stores timestamps in UTC; verify against the source system configuration if sub-second precision is required.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume records are hard-deleted if removed from the source.
- **Data Integrity:** `tenor_gif_id` is a string from an external API; ensure downstream joins account for potential variations in string formatting or API-side changes.
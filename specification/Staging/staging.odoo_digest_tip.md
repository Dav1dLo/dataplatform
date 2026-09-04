# odoo_digest_tip

## Source system
This table originates from Odoo, an open-source ERP and CRM platform. The naming convention (`digest_tip`) and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal module structure for managing automated email digest content.

## Functional process 
This table supports the "Digest Email" functionality, which provides users with periodic summaries of business activity. It stores the content and configuration for specific "tips" or helpful hints that are injected into these automated digest emails to encourage feature adoption or provide operational insights.

## Description
One row in this table represents a single digest tip configuration, including its display sequence and localized content. It serves as a raw landing copy of the Odoo `digest.tip` model, capturing the metadata required to render helpful hints within the digest email service.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `staging.digest_tip_id_seq`. |
| sequence | INTEGER | true | Display order index | Used to sort tips in the digest email. |
| group_id | INTEGER | true | Foreign key to digest group | Links the tip to a specific digest category. |
| create_uid | INTEGER | true | Creator user ID | References the user who created the tip. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the tip. |
| name | JSONB | true | Tip title | Likely contains multi-language strings. |
| tip_description | JSONB | true | Tip content body | Likely contains multi-language HTML or text. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC based on Odoo standard. |
| write_date | TIMESTAMP | true | Last update timestamp | Inferred UTC based on Odoo standard. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `group_id` → `staging.digest_tip_group.id` (Guess: links to the parent digest group definition).
    - `create_uid` → `staging.res_users.id` (Guess: standard Odoo audit link).
    - `write_uid` → `staging.res_users.id` (Guess: standard Odoo audit link).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **JSONB content:** The `name` and `tip_description` columns contain JSONB data. Downstream consumers must handle potential multi-language structures (e.g., `{"en_US": "...", "fr_FR": "..."}`) when querying these fields.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft deletes:** Odoo typically does not use soft-delete flags in this model; however, verify if rows are physically removed during source-side maintenance.
- **Audit columns:** `create_uid` and `write_uid` refer to internal Odoo user IDs, which may not map directly to external identity systems without joining against the `res_users` table.
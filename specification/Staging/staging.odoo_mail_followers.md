# odoo_mail_followers

## Source system
This table originates from Odoo ERP. The naming convention `mail_followers` and the structure of `res_id`, `res_model`, and `partner_id` are characteristic of the Odoo framework's generic notification and subscription system, which tracks which partners (users or contacts) are following specific records across various business modules.

## Functional process 
This table supports the Odoo "Followers" mechanism, which manages communication and notification subscriptions. It tracks which partners are subscribed to updates on specific business documents (e.g., sales orders, tasks, or projects), ensuring that relevant stakeholders receive email notifications or chatter updates when those records change.

## Description
One row represents a single subscription link between a specific partner and a specific business document record. It acts as a raw landing copy of the Odoo `mail.followers` model, capturing the relationship between a follower and a target entity at the grain of one row per follower per record.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; unique identifier for the follower record. |
| res_id | INTEGER | true | Target record ID | The ID of the business document being followed; null if the follower is linked to the model globally. |
| partner_id | INTEGER | false | Partner ID | Foreign key to the partner (contact/user) who is following the record. |
| res_model | VARCHAR | false | Model name | The technical name of the Odoo model (e.g., 'sale.order', 'project.task') that the partner is following. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `partner_id` → `staging.res_partner.id`: This column links to the partner directory, representing the entity receiving notifications.
- **Natural keys (inferred):** 
    - The combination of `res_model`, `res_id`, and `partner_id` uniquely identifies a follower relationship in the source system.

## Caveats for downstream consumers

- **PII/Sensitivity:** The `partner_id` links to contact information; ensure access controls are applied when joining with partner tables.
- **Timestamps:** No audit timestamps (e.g., `create_date`) are present in this staging table; tracking when a subscription was created is not possible from this source.
- **Soft Deletes:** This table represents a raw landing; it is assumed that deleted records in Odoo are removed from this table during the ingestion process.
- **Data Integrity:** `res_id` is nullable, which may indicate "global" followers for a model; ensure queries handle nulls when joining against specific business documents.
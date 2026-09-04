# odoo_mail_followers_mail_message_subtype_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` and the presence of two foreign key columns indicate this is a standard Odoo many-to-many join table used to link followers to specific message subtypes for notification preferences.

## Functional process 
This table supports the Odoo communication and notification framework. It defines the specific message subtypes (e.g., "Discussions", "Notes", "Activities") that a particular follower is subscribed to, ensuring that users or partners only receive relevant email notifications based on their configured preferences.

## Description
One row in this table represents a single association between a follower record and a message subtype. It acts as a link table in the Staging layer, providing a raw, un-transformed mapping of notification subscriptions as they exist in the source Odoo database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mail_followers_id | INTEGER | false | Foreign key to the mail_followers table | Represents the specific follower entity. |
| mail_message_subtype_id | INTEGER | false | Foreign key to the mail_message_subtype table | Represents the type of message/notification. |

## Keys

- **Primary key (inferred):** The combination of (`mail_followers_id`, `mail_message_subtype_id`) forms the composite primary key.
- **Foreign keys (inferred):** 
    - `mail_followers_id` → `mail_followers.id`: Links to the follower record.
    - `mail_message_subtype_id` → `mail_message_subtype.id`: Links to the notification subtype definition.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a pure join table; it contains no descriptive attributes or timestamps.
- There are no sensitive PII columns in this table, as it only contains integer identifiers.
- As a staging table, it reflects the state of the source system at the time of extraction; it does not track historical changes or soft deletes.
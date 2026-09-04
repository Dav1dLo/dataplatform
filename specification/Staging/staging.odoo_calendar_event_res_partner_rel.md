# odoo_calendar_event_res_partner_rel

## Source system
This table originates from Odoo ERP. The naming convention `res_partner_id` and `calendar_event_id` is characteristic of Odoo's relational mapping tables, which link business entities (Partners) to activities (Calendar Events) via a many-to-many relationship.

## Functional process 
This table supports the scheduling and communication management process. It tracks the association between calendar events (meetings, calls, or appointments) and the specific business partners (customers, vendors, or contacts) invited to or participating in those events.

## Description
One row in this table represents a single link between a specific calendar event and a specific partner. It acts as a join table in the staging layer, providing a raw, un-transformed mapping of event attendees or participants.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| res_partner_id | INTEGER | false | Foreign key to the partner record | Represents the participant or contact involved in the event. |
| calendar_event_id | INTEGER | false | Foreign key to the calendar event record | Represents the specific meeting or appointment. |

## Keys

- **Primary key (inferred):** The composite key `(res_partner_id, calendar_event_id)` is the inferred primary key, as this is a standard join table structure.
- **Foreign keys (inferred):** 
    - `res_partner_id` → `res_partner.id`: Links to the master contact/partner record.
    - `calendar_event_id` → `calendar_event.id`: Links to the master calendar event record.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table contains no timestamps or audit columns; it is a pure relational mapping.
- There is no soft-delete flag; assume that if a row is absent, the relationship has been removed in the source system.
- Ensure joins to `res_partner` and `calendar_event` are handled as inner joins if you only require active associations.
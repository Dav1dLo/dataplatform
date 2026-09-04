# odoo_meeting_category_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` combined with the column names `event_id` and `type_id` is characteristic of Odoo's internal many-to-many relationship tables, which link calendar events to their respective category tags.

## Functional process 
This table supports the calendar and scheduling management process. It facilitates the categorization of meetings or events, allowing a single event to be associated with multiple categories or tags for filtering and reporting purposes.

## Description
One row in this table represents a single association between a calendar event and a category tag. It serves as a raw junction table in the staging layer, capturing the many-to-many relationship between events and categories as landed directly from the Odoo database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| event_id | INTEGER | false | Foreign key to the calendar event | Links to the primary key of the event table. |
| type_id | INTEGER | false | Foreign key to the category definition | Links to the primary key of the meeting category table. |

## Keys

- **Primary key (inferred):** The composite key `(event_id, type_id)` is the inferred primary key, as this is a standard junction table structure.
- **Foreign keys (inferred):** 
    - `event_id → calendar_event.id`: This column references the unique identifier of the meeting or event.
    - `type_id → calendar_event_type.id`: This column references the unique identifier of the category or type definition.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; incremental loading logic must rely on the upstream source system's change tracking or full-table replacement.
- Ensure joins to parent tables handle potential orphaned records if referential integrity is not strictly enforced in the source Odoo instance.
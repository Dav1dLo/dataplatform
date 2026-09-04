# odoo_discuss_channel_rtc_session

## Source system
This table originates from Odoo, an open-source ERP and business management software suite. The naming convention `discuss_channel_rtc_session` corresponds to the Odoo "Discuss" module, which manages real-time communication (RTC) sessions for voice and video calls within channels.

## Functional process 
This table supports the real-time communication and collaboration features of the Odoo Discuss module. It tracks the state of individual participants within a communication session, specifically monitoring their hardware status (camera, microphone, screen sharing) and presence within a channel.

## Description
One row in this table represents a single active or historical participant session within an Odoo RTC channel. It captures the technical state of a user's connection, such as whether they are muted or sharing their screen, at a specific point in time. As a staging table, it serves as a raw, landed copy of the Odoo database state, intended for downstream transformation into user activity or session duration metrics.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence. |
| channel_member_id | INTEGER | false | Foreign key to channel member | Identifies the specific user/member in the channel. |
| channel_id | INTEGER | true | Foreign key to discuss channel | The communication channel where the session occurs. |
| create_uid | INTEGER | true | Creator user ID | The ID of the user who created this session record. |
| write_uid | INTEGER | true | Last modifier user ID | The ID of the user who last updated this record. |
| is_screen_sharing_on | BOOLEAN | true | Screen sharing status | True if the participant is currently sharing their screen. |
| is_camera_on | BOOLEAN | true | Camera status | True if the participant's camera is active. |
| is_muted | BOOLEAN | true | Mute status | True if the participant is currently muted. |
| is_deaf | BOOLEAN | true | Deaf status | True if the participant has disabled incoming audio. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of the last modification to this record. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp when the session record was created. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `channel_member_id` → `staging.odoo_discuss_channel_member.id` (Guess: links session to the specific member record).
    - `channel_id` → `staging.odoo_discuss_channel.id` (Guess: links session to the parent communication channel).
    - `create_uid` / `write_uid` → `staging.res_users.id` (Guess: standard Odoo pattern for user references).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** Odoo typically uses hard deletes for session-based tables; however, verify if records are purged periodically by the application.
- **Data Volatility:** This table tracks real-time state; expect high update frequency for `is_muted`, `is_camera_on`, and `write_date` columns during active calls.
- **Nullability:** Many columns are nullable, reflecting that session states may not be fully initialized or captured at the moment of record creation.
# odoo_mail_link_preview

## Source system
This table originates from Odoo, an open-source ERP and CRM platform. The naming convention (e.g., `mail_link_preview`, `create_uid`, `write_date`) and the presence of Open Graph (OG) metadata fields are characteristic of Odoo's internal messaging and communication framework, which caches link previews for URLs shared within the system.

## Functional process 
This table supports the internal communication and collaboration features of Odoo, specifically the "Discuss" or "Mail" modules. It stores metadata extracted from URLs shared in messages, allowing the UI to render rich link previews (thumbnails, titles, and descriptions) without re-fetching the external content every time a message is viewed.

## Description
One row in this table represents a single cached link preview associated with a specific message or communication event. It acts as a raw landing copy of the Odoo `mail.link.preview` model, capturing the Open Graph metadata and system-level audit timestamps for each link processed by the application.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; unique identifier for the preview record. |
| message_id | INTEGER | true | Foreign key to the parent message | Links the preview to the specific message where the URL was shared. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who triggered the link preview creation. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the preview record. |
| source_url | VARCHAR | false | The original URL | The full URL string that was parsed for metadata. |
| og_type | VARCHAR | true | Open Graph type | The OG object type (e.g., 'website', 'article'). |
| og_title | VARCHAR | true | Open Graph title | The title of the linked page as defined in OG tags. |
| og_site_name | VARCHAR | true | Open Graph site name | The name of the website hosting the linked content. |
| og_image | VARCHAR | true | Open Graph image URL | URL path to the thumbnail image associated with the link. |
| og_mimetype | VARCHAR | true | OG content MIME type | The MIME type of the Open Graph content. |
| image_mimetype | VARCHAR | true | Image MIME type | The MIME type of the associated thumbnail image. |
| og_description | TEXT | true | Open Graph description | The summary text extracted from the linked page. |
| is_hidden | BOOLEAN | true | Hidden flag | Indicates if the preview should be suppressed in the UI. |
| create_date | TIMESTAMP | true | Record creation timestamp | Timestamp when the preview was first generated. |
| write_date | TIMESTAMP | true | Record modification timestamp | Timestamp of the last update to this preview record. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `message_id` → `mail_message.id` (Guess: Odoo standard naming for message associations).
    - `create_uid` → `res_users.id` (Guess: Standard Odoo audit field for user creation).
    - `write_uid` → `res_users.id` (Guess: Standard Odoo audit field for user modification).
- **Natural keys (inferred):** 
    - `source_url` (Combined with `message_id`, this effectively identifies the unique link instance per message).

## Caveats for downstream consumers

- **Timestamps:** Timestamps are stored in the Odoo application server time (typically UTC), but verify against the source system configuration.
- **Data Quality:** The `og_*` fields are scraped from external websites and may contain malformed data, excessive whitespace, or be empty if the target site does not support Open Graph tags.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are likely managed by the Odoo ORM lifecycle.
- **Sensitive Data:** While this table contains metadata about URLs, be aware that `source_url` may occasionally contain sensitive query parameters or private tokens depending on the nature of the shared links.
# odoo_onboarding_onboarding_step

## Source system
This table originates from Odoo ERP, as evidenced by the naming convention (`odoo_onboarding_onboarding_step`), the use of `JSONB` for multi-language fields, and standard Odoo audit columns like `create_uid`, `write_uid`, `create_date`, and `write_date`.

## Functional process 
This table supports the user onboarding and configuration guidance process within the Odoo platform. It defines the individual steps presented to users during initial setup, managing the sequence, display text, and action triggers for each onboarding module.

## Description
One row represents a single configuration or instructional step within an Odoo onboarding panel. This is a raw landed copy of the Odoo `onboarding.onboarding.step` model, capturing the metadata required to render the step, including localized titles, descriptions, and associated images.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated ID. |
| sequence | INTEGER | true | Display order index | Determines the order in which steps appear. |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who created the step. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the user who last updated the step. |
| done_icon | VARCHAR | true | Icon identifier | Name or path of the icon shown when the step is completed. |
| step_image_filename | VARCHAR | true | Image filename | Filename of the image associated with the step. |
| panel_step_open_action_name | VARCHAR | true | Action name | The technical name of the action triggered by the step. |
| title | JSONB | true | Localized title | Multi-language title of the onboarding step. |
| description | JSONB | true | Localized description | Multi-language description text. |
| button_text | JSONB | false | Localized button text | Text displayed on the action button. |
| done_text | JSONB | true | Localized completion text | Text displayed when the step is marked as done. |
| step_image_alt | JSONB | true | Localized alt text | Accessibility text for the step image. |
| is_per_company | BOOLEAN | true | Company-specific flag | Indicates if the step configuration is unique per company. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of the last record modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit link to user table).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit link to user table).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **JSONB fields:** Columns `title`, `description`, `button_text`, `done_text`, and `step_image_alt` contain JSONB data, typically structured as `{"en_US": "Text", "fr_FR": "Texte"}`. Use `->>` operator to extract specific language values.
- **Timestamps:** Timestamps are stored in the Odoo application server time (typically UTC).
- **Soft deletes:** This table does not appear to implement a soft-delete flag; assume standard Odoo CRUD behavior where records are physically deleted unless otherwise specified by the application layer.
- **Data Sensitivity:** No direct PII is present, though `create_uid` and `write_uid` link to internal system users.
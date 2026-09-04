# odoo_hr_departure_wizard

## Source system
This table originates from Odoo ERP, specifically the Human Resources module. The naming convention `hr_departure_wizard` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal wizard models used to manage employee offboarding workflows.

## Functional process 
This table supports the employee offboarding and termination process. It captures the data entered into the departure wizard interface, which triggers the formal exit procedure for an employee, including the reason for departure, the effective date, and descriptive notes.

## Description
One row represents a single instance of an employee departure record initiated through the Odoo HR wizard. It serves as a raw landing copy of the wizard's state, tracking the lifecycle of an exit request from creation to final update.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; unique identifier for the wizard record. |
| departure_reason_id | INTEGER | false | Foreign key to departure reason | Links to the lookup table defining why the employee is leaving. |
| employee_id | INTEGER | false | Foreign key to employee | The employee undergoing the departure process. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who initiated the departure wizard. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| departure_date | DATE | false | Effective departure date | The calendar date the employee officially leaves the company. |
| departure_description | TEXT | true | Departure notes | Free-text field for additional context regarding the exit. |
| create_date | TIMESTAMP | true | Creation timestamp | Audit timestamp; when the wizard record was first created. |
| write_date | TIMESTAMP | true | Last update timestamp | Audit timestamp; when the record was last modified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `employee_id` → `hr_employee.id` (Standard Odoo pattern for linking to employee records).
    - `departure_reason_id` → `hr_departure_reason.id` (Standard Odoo pattern for linking to departure reason configurations).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** Odoo timestamps are typically stored in UTC. Ensure conversion to local time if required for reporting.
- **Sensitive Data:** The `departure_description` may contain sensitive HR information or personal details; ensure appropriate masking for non-HR users.
- **Soft Deletes:** Odoo models often use `active` flags for soft deletes, but this specific wizard table may not include one. Assume all rows are active unless an `active` column is present in the source.
- **Wizard Nature:** As this is a "wizard" table, it may contain transient data or incomplete records if the user closed the wizard without finalizing the departure.
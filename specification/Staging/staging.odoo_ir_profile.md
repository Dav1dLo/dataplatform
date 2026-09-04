# odoo_ir_profile

## Source system
This table originates from Odoo ERP, specifically the `ir_profile` model within the Odoo framework's internal registry. The naming convention `ir_` (Internal Resource) is a standard prefix for Odoo's technical and metadata-tracking tables.

## Functional process 
This table supports the Odoo performance profiling and debugging process. It captures execution traces, SQL query counts, and stack traces for specific sessions or requests, allowing developers to monitor system performance and identify bottlenecks in the application layer.

## Description
One row in this table represents a single performance profiling event or request trace captured by the Odoo system. It serves as a raw landing copy of the internal profiling data, providing granular metrics such as execution duration, SQL query counts, and associated stack traces for analysis.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; managed by Odoo. |
| sql_count | INTEGER | true | Total number of SQL queries executed | Used to identify N+1 query issues. |
| entry_count | INTEGER | true | Number of entries in the profile | Represents the volume of operations tracked. |
| session | VARCHAR | true | Identifier for the user session | Links the profile to a specific user interaction. |
| name | VARCHAR | true | Name or description of the profile | Often contains the URL or method being profiled. |
| init_stack_trace | TEXT | true | Initial stack trace | Debugging info for the start of the process. |
| sql | TEXT | true | Captured SQL query text | Contains the raw SQL statements executed. |
| traces_async | TEXT | true | Asynchronous execution traces | Performance data for async operations. |
| traces_sync | TEXT | true | Synchronous execution traces | Performance data for sync operations. |
| qweb | TEXT | true | QWeb rendering profile data | Metrics related to Odoo's template engine. |
| create_date | TIMESTAMP | true | Timestamp of profile creation | Assumed to be in UTC. |
| duration | DOUBLE PRECISION | true | Total execution duration | Unit is typically seconds. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** Not confidently inferable from the provided metadata.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `sql` and `init_stack_trace` columns may contain sensitive information, including table names, column names, or potentially PII if passed as query parameters.
- **Timezone:** Timestamps are assumed to be in UTC, consistent with standard Odoo database practices.
- **Data Volume:** As a profiling table, this may grow rapidly depending on the frequency of profiling enabled in the source system; consider partitioning or archiving strategies.
- **Format:** The `TEXT` fields (`sql`, `traces_async`, etc.) likely contain serialized JSON or structured log strings; parsing will be required for analysis.
dbt_tutorial on Databricks
================================

This repository contains a dbt Core project configured to run on Databricks. It demonstrates a layered model architecture (bronze → silver) with custom tests and macros.

Project highlights
------------------
- Bronze models sourced from CSV-backed external tables: `bronze_date`, `bronze_product`, `bronze_store`, `bronze_returns`, `bronze_sales`.
- Silver models for analytics-ready outputs:
  - `silver_sales_by_category_gender`: sales totals by product category and customer gender
  - `silver_returns_by_store_month_reason`: refund totals by store, month, and reason
- Custom generic test: `generic_non_negative` to ensure numeric columns are non-negative
- Custom macro: `multiply` for numeric calculations

Tech stack
----------
- dbt Core 1.10.x
- dbt-databricks adapter 1.10.x
- Databricks SQL Warehouse (or All-purpose cluster)

Project structure
-----------------
- `models/bronze/` — staging models referencing sources
- `models/silver/` — curated, aggregated models
- `models/*/schema.yml` — documentation and tests
- `macros/` — reusable macros (e.g., `multiply`)
- `tests/generic/` — custom generic tests (e.g., `generic_non_negative`)

Setup
-----
1) Python environment
   - Create and activate a virtual environment
   - Install requirements: `pip install -r requirements.txt`

2) Profiles and connection
   - Ensure `profiles.yml` contains a `dbt_tutorial` Databricks profile with:
     - `host`, `http_path`, and `catalog` (if Unity Catalog)
     - `schema` (e.g., `bronze`, `silver`, `gold` configured in `dbt_project.yml`)
     - Auth via `token` (Databricks PAT)

3) Verify connection
   - `dbt debug`
   - `dbt parse`

Common commands
---------------
- Build bronze and silver: `dbt build --select tag:bronze+ tag:silver`
- Run only silver layer: `dbt run --select path:models/silver`
- Run tests: `dbt test`
- Generate docs: `dbt docs generate && dbt docs serve`

Development tips
----------------
- Use `ref()` for model dependencies and `source()` for source tables
- Use tags and path selectors to target layers (`tag:bronze`, `path:models/silver`)
- In VS Code, the dbt Power User extension can preview compiled SQL and DAG

Data lineage
------------
- Silver models depend on bronze via `ref()`, and bronze depend on sources via `source()`
- In the graph, expand parents to depth 2 to view `source → bronze → silver`

Testing
-------
- Column tests are defined in `schema.yml`
- Custom generic test `generic_non_negative` lives in `tests/generic/` and is applied as:
  ```yaml
  - name: gross_amount
    tests:
      - generic_non_negative
  ```

Incoming features (roadmap)
---------------------------
- Snapshots
  - Introduce `snapshots/` to capture slowly changing dimensions (SCD2) for selected entities
  - Add snapshot policies, schedule runs, and document snapshot lineage
- CI/CD deployment
  - GitHub Actions workflow to run `dbt deps`, `dbt build`, and publish docs on PRs/merges
  - Environment-specific targets (dev, prod) via profiles and job parameters
  - Optional state comparison to run only changed resources

License
-------
Apache-2.0 (or your preferred license)

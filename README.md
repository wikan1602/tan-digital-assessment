# Data Engineer Technical Assessment - TAN Digital

## Overview
This repository contains my submission for the Data Engineer Technical Assessment. The solution covers end-to-end data engineering tasks including Database Schema Design, SQL Analysis, ETL Pipeline development using Python, and Business Intelligence Dashboard creation.

> ** Important Note on Data Timeline:**
> To ensure data relevance and integrity during the assessment, I standardized the mock data timeline to **Year 2025** across all modules. Consequently, all SQL queries filter for the year 2025 instead of the original requirement (2023) to match the generated dataset.

## Repository Structure
```text
data-engineer-assessment/
├── 1-sql-assessment/
│   ├── queries/             # SQL Scripts (Schema, Mock Data, Analytical Queries)
│   └── results/             # CSV Exports of query results
├── 2-etl-assessment/
│   ├── src/                 # Jupyter Notebook (.ipynb) containing ETL logic
│   └── data/                # Raw input CSVs and Processed Output
├── 3-visualization/
│   ├── source_files/        # Power BI (.pbix) and data source
│   └── screenshots/         # Dashboard preview images
└── README.md                # Main Project Documentation
```
## 🛠️ Tools & Technologies Used
* **Database:** PostgreSQL v16, pgAdmin 4
* **ETL / Scripting:** Python 3.x (Libraries: `pandas`, `numpy`, `openpyxl`)
* **Environment:** Jupyter Notebook
* **Visualization:** Microsoft Power BI Desktop
* **Version Control:** Git & GitHub

---

## 🚀 Setup Instructions

### 1. SQL Assessment
1.  Open `pgAdmin` and create a new database (e.g., `tan_digital_test`).
2.  Open the **Query Tool**.
3.  Execute the schema and mock data generation script found in:
    `1-sql-assessment/queries/0_schema_and_mock_data.sql`
    *(Note: This script generates data for the Sep-Dec 2025 period).*
4.  Run the analytical queries (`1_inventory_turnover.sql`, etc.) located in the same folder to see the results.

### 2. ETL Assessment
1.  Navigate to the `2-etl-assessment/src/` directory.
2.  Ensure required Python libraries are installed:
    ```bash
    pip install pandas openpyxl
    ```
3.  Run the Jupyter Notebook `etl_process.ipynb`.
4.  The script will automatically:
    * Generate raw dummy CSV files (`Assessment Data Asset Dummy.csv` & `City Indonesia.csv`).
    * Perform data validation (checking for formats and referential integrity).
    * Perform data cleaning (standardizing City names and Phone numbers).
    * **Transformation:** Generate the `Internal Site ID` with format `AAA-BB-CCC`.
    * Output the final processed file `Final_Asset_Data.csv` and `Error_Logs.csv`.

### 3. Visualization
1.  Navigate to `3-visualization/source_files/`.
2.  Open `cooperative_dashboard.pbix` using **Microsoft Power BI Desktop**.
3.  Alternatively, view the high-resolution dashboard screenshot in the `3-visualization/screenshots/` directory.

---

## ⏱️ Time Spent (Approximation)
* **SQL Assessment:** 2 Hours (Schema design, adjusting mock data to 2025, query optimization).
* **ETL Assessment:** 3 Hours (Designing logic for `AAA-BB-CCC` ID generation and handling dirty data edge cases).
* **Visualization:** 1.5 Hours (Mock data generation and dashboard layouting in Power BI).
* **Documentation & Recording:** 1 Hour.

---

## 🤖 AI Utilization Log ("The AI Co-Pilot")
In accordance with the assessment guidelines, I utilized AI tools (Large Language Models) to enhance productivity, debug errors, and optimize logic. Below is the documentation of usage:

### 1. Mock Data Generation
* **Context:** Converting PDF schema images into executable SQL scripts.
* **Usage:** Used AI to generate the initial `CREATE TABLE` and `INSERT INTO` statements to meet the "minimum 10 records" requirement efficiently.
* **Enhancement:** I manually instructed the AI to shift all transaction dates to **2025** so that "Last 3 Months" queries would return valid, non-empty results relative to the current simulated date.

### 2. ETL Logic Optimization
* **Context:** Generating the sequential ID part (`CCC`) for the `Internal Site ID` (Format: `AAA-BB-CCC`).
* **Prompt:** *"How to create a sequence number grouped by city in Pandas without using slow for-loops?"*
* **Result:** AI suggested using the vectorized approach `df.groupby('CityCode').cumcount() + 1`. This is significantly faster and cleaner than manual iteration.

### 3. Troubleshooting
* **Context:** PostgreSQL Local Connection issues.
* **Usage:** Used AI to troubleshoot `pgAdmin` connection errors ("User postgres password authentication failed") and guided the reset process via `pg_hba.conf` modification.

---

## 📺 Video Presentation
Here is the video explanation demonstrating the code execution and results:

**[PASTE YOUR GOOGLE DRIVE / YOUTUBE LINK HERE]**
*(Please ensure the link is accessible/public)*

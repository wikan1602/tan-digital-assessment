# Data Engineer Assessment - ETL Pipeline

This project contains a Python notebook for processing asset data (ETL), ranging from validation and data cleaning to data transformation, to generate an **Internal Site ID** that complies with the Indonesian regional master data standards.

## 📋 Project Description

The primary objective of this script is to merge raw asset data (`Assessment Data Asset Dummy`) with regional master data (`City Indonesia`). The main challenge addressed is the inconsistency in city/district naming conventions between the two datasets.

The process is divided into 4 main stages as per instructions:
1.  **Data Validation**: Initial data quality audit.
2.  **Data Cleaning**: City name normalization to enable joining with master data.
3.  **Data Transformation**: Generation of unique IDs (`Internal Site ID`).
4.  **Error Handling**: Logging of records that failed processing.

## 🛠️ Prerequisites

* Python 3.14
* Libraries: `pandas`, `numpy`, `re`

## 📂 File Structure

* `Assessment Data Asset Dummy.csv`: Raw asset data (Input).
* `City Indonesia.csv`: Master data for city and region codes (Input).
* `ETL_Assessment.ipynb`: Jupyter Notebook containing the processing code.

## 🚀 Workflow

### 1. Data Validation
The initial step to audit data quality before processing:
* Checking for missing mandatory columns (`Funcloc`).
* Verifying numeric formats for asset IDs.
* Checking initial referential integrity (matching `Alamat4` with Master Data before cleaning).
    * *Initial Result*: High mismatch rate found due to format differences (e.g., "BANDUNG, KOTA" vs "Kota Bandung").

### 2. Data Cleaning (Normalization Logic)
This is the most critical stage. A `normalize_city_name` function is applied to both datasets to create a uniform **Join Key**.

**Cleaning Logic:**
1.  **Uppercase**: Convert all text to uppercase.
2.  **Specific Typos & Inconsistency Fixes**:
    * `KERTANEGARA` $\rightarrow$ `KARTANEGARA`
    * `PAHUWATO` $\rightarrow$ `POHUWATO`
    * `OKU` $\rightarrow$ `OGAN KOMERING ULU` (Expand abbreviations)
    * `PANGKAJENE` $\rightarrow$ `PANGKAJENE KEPULAUAN`
    * `KEPULAUAN SIAU TAGULANDAN` $\rightarrow$ `KEPULAUAN SIAU TAGULANDANG BIARO`
3.  **Administrative Text Removal**: Removing words like "KABUPATEN", "KOTA ADM", "KOTA", "ADM".
4.  **Master Data Cleaning**: Removing alias names inside parentheses in the master data (e.g., `(Oku Selatan)` is removed).
5.  **Remove Non-Alphabetic Characters (Regex)**: Using regex `[^A-Z]` to remove spaces, dots, commas, and hyphens.
    * *Example*: "TOJO UNA-UNA" and "TOJO UNA UNA" both become `TOJOUNAUNA`.

### 3. Data Transformation
Once the data is clean, a *merge* is performed, and new IDs are generated using the format:
$$Internal Site ID = AAA-BB-CCC$$

* **AAA**: City Code (from Master Data).
* **BB**: Regional Code (2 digits, zero-padded).
* **CCC**: Sequence Number (3 digits, zero-padded).
    * Sequence Logic: `start from 001`, ordered by `Funcloc`, grouped by `CityCode`.

### 4. Error Handling
Logging data that still failed to process after the *cleaning* stage.
* **Final Result**: Only **8 records** remain as failures (Error).
* **Root Cause**: The `Alamat4` data contains "JAKARTA" (generic), whereas the Master Data requires specific administrative districts (Central/West/East/South/North). This is categorized as *bad source data*.

## 💻 How to Run

1.  Ensure `Assessment Data Asset Dummy.csv` and `City Indonesia.csv` are in the same folder.
2.  Open the notebook file (`.ipynb`).
3.  Run each cell sequentially from Task 1 to Task 4.

## 📊 Transformation Result Example

| Internal Site ID | Alamat4 | Funcloc |
| :--- | :--- | :--- |
| ADL-10-001 | KONAWE SELATAN | 100000001078 |
| ADL-10-002 | KONAWE SELATAN | 100000001079 |
| ADL-10-003 | KONAWE SELATAN | 100000001080 |

---
*Created as part of the Data Engineer Assessment.*

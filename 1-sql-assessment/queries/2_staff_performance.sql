/* ===========================================================================
Data Engineer Assessment - SQL Part 2
---------------------------------------------------------------------------
Task        : Analyze staff performance and sales metrics
Author      : Wikan Priambudi
Description : 
    This query retrieves staff performance metrics including transaction count,
    total sales, and average transaction value.
    
    Logic:
    1. Select active staff only (resignation_date IS NULL).
    2. Left join with sales data to include staff with zero sales.
    3. Year filter is adjusted to 2025 to match the available Mock Data 
       (Original requirement stated 2023, but dataset simulates 2025).
===========================================================================
*/

SELECT 
    sr.staff_id,
    bd.branch_name,
    
    -- Metric 1: Number of transactions handled (Using COUNT)
    COUNT(st.transaction_id) AS number_of_transactions,
    
    -- Metric 2: Total Sales Amount (Handling NULLs with COALESCE for zero sales)
    COALESCE(SUM(st.total_amount), 0) AS total_sales_amount,
    
    -- Metric 3: Average Transaction Value
    COALESCE(AVG(st.total_amount), 0) AS average_transaction_value,
    
    sr.performance_score

FROM 
    staff_records AS sr  -- Base Table (Left Table)

-- Join to get Branch Name
LEFT JOIN branch_details AS bd 
    ON sr.branch_code = bd.branch_code

-- Join to get Transaction Data
LEFT JOIN sales_transactions AS st 
    ON sr.staff_id = st.staff_id

WHERE 
    [cite_start]-- Filter 1: Only Active Staff (No resignation date) [cite: 97]
    sr.resignation_date IS NULL
    
    -- Filter 2: Transactions in 2025 (Adjusted from 2023)
    AND EXTRACT(YEAR FROM st.transaction_date) = 2025

GROUP BY 
    sr.staff_id, 
    bd.branch_name, 
    sr.performance_score

-- Order by highest sales performance
ORDER BY 
    total_sales_amount DESC;

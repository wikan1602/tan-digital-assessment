-- Data Engineer Assessment - SQL Part 1
-- Task: Calculate inventory turnover metrics per branch
-- Requirement: Show Branch, IN, OUT, Current Stock, Expired.
-- Filter: Last 3 months (Simulated as late 2025).
-- Ordering: Highest stock turnover rate.

WITH stock_calculations AS (
    SELECT 
        branch_code,
        SUM(CASE WHEN transaction_type = 'IN' THEN quantity ELSE 0 END) AS total_in,
        SUM(CASE WHEN transaction_type = 'OUT' THEN quantity ELSE 0 END) AS total_out,
        SUM(CASE WHEN transaction_type = 'EXP' THEN quantity ELSE 0 END) AS total_expired,
        SUM(CASE WHEN transaction_type = 'ADJ' THEN quantity ELSE 0 END) AS total_adj
    FROM inventory_movements
    -- Filter simulasi "3 bulan terakhir" di tahun 2025
    WHERE transaction_date BETWEEN '2025-08-31' AND '2025-11-30'
    GROUP BY branch_code
)

SELECT 
    b.branch_name,
    COALESCE(s.total_in, 0) AS total_incoming_stock,
    COALESCE(s.total_out, 0) AS total_outgoing_stock,
    
    -- Current Stock
    (COALESCE(s.total_in, 0) - (COALESCE(s.total_out, 0) + COALESCE(s.total_expired, 0) + COALESCE(s.total_adj, 0))) AS current_stock_level,
    
    COALESCE(s.total_expired, 0) AS expired_items

FROM branch_details b
LEFT JOIN stock_calculations s ON b.branch_code = s.branch_code

-- Order by Turnover Rate (Keluar dibagi Masuk)
ORDER BY 
    CASE 
        WHEN COALESCE(s.total_in, 0) = 0 THEN 0 
        ELSE (COALESCE(s.total_out, 0)::DECIMAL / s.total_in) 
    END DESC;

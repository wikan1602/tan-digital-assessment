-- Data Engineer Assessment - SQL Part 1
-- Task: Calculate inventory turnover metrics per branch
-- Author: Wikan Priambudi
-- Date: 21 November 2025
-- Description: 
-- Query ini menghitung total barang masuk, keluar, sisa stok, dan barang expired 
-- untuk setiap cabang. Menggunakan logika Conditional Aggregation.
-- Filter waktu disesuaikan ke Tahun 2023 sesuai ketersediaan Mock Data.

WITH stock_calculations AS (
    SELECT 
        branch_code,
        -- Agregasi berdasarkan tipe transaksi
        SUM(CASE WHEN transaction_type = 'IN' THEN quantity ELSE 0 END) AS total_in,
        SUM(CASE WHEN transaction_type = 'OUT' THEN quantity ELSE 0 END) AS total_out,
        SUM(CASE WHEN transaction_type = 'EXP' THEN quantity ELSE 0 END) AS total_expired,
        SUM(CASE WHEN transaction_type = 'ADJ' THEN quantity ELSE 0 END) AS total_adj
    FROM inventory_movements
    -- Filter data untuk range (Last 3 months simulation based on mock data)
    WHERE transaction_date BETWEEN '2023-01-01' AND '2023-12-31'
    GROUP BY branch_code
)

SELECT 
    b.branch_name,
    COALESCE(s.total_in, 0) AS total_incoming_stock,
    COALESCE(s.total_out, 0) AS total_outgoing_stock,
    -- Rumus Stock Level: Masuk - (Keluar + Expired + Adjustment)
    (COALESCE(s.total_in, 0) - (COALESCE(s.total_out, 0) + COALESCE(s.total_expired, 0) + COALESCE(s.total_adj, 0))) AS current_stock_level,
    COALESCE(s.total_expired, 0) AS expired_items
FROM branch_details b
LEFT JOIN stock_calculations s ON b.branch_code = s.branch_code
ORDER BY total_outgoing_stock DESC;

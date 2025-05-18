USE `adashi_staging`;

-- How often customers transact per month 
-- Get monthly transcation OF USERS

CREATE OR REPLACE VIEW `monthly_txn` AS
SELECT owner_id,
    YEAR(transaction_date) AS txn_year,
    MONTH(transaction_date) AS txn_month,
    COUNT(confirmed_amount) AS count_txn
FROM savings_savingsaccount
WHERE confirmed_amount > 0
GROUP BY owner_id, txn_year, txn_month;

-- select * from `monthly_txn`;

-- 	AVG transaction per customer

CREATE OR REPLACE VIEW `avg_txn` AS
SELECT owner_id, AVG(count_txn) AS avg_transactions_per_month
FROM `monthly_txn`
GROUP BY owner_id;

-- Summarise with frequency according to the table given 
SELECT
  CASE
    WHEN avg_transactions_per_month >= 10 THEN 'High Frequency'
    WHEN avg_transactions_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
    ELSE 'Low Frequency'
  END AS frequency_category,
  COUNT(*) AS customer_count,
  ROUND(AVG(avg_transactions_per_month), 1) AS avg_transactions_per_month
FROM avg_txn
GROUP BY frequency_category;


    
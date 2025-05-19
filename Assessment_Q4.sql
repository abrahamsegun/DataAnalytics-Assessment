USE `adashi_staging`;

-- select * from users_customuser;
-- select * from savings_savingsaccount;

-- Acct Tenure 
-- duration a customer have had a acct 

WITH tenure AS (
    SELECT 
        id AS customer_id,
        CONCAT(first_name, ' ', last_name) AS name,
        TIMESTAMPDIFF(MONTH, created_on, CURDATE()) AS tenure_months
    FROM users_customuser
),
-- total transaction per owner-id or customer

total_txn AS (
    SELECT 
        owner_id,
        ROUND(SUM(confirmed_amount) / 100, 2) AS total_transactions
    FROM savings_savingsaccount
    WHERE confirmed_amount > 0
    GROUP BY owner_id
),

-- applying the formula for avgerage profit and turning it to kobo 
	
avg_profit AS (
    SELECT 
        owner_id,
        ROUND(AVG(confirmed_amount * 0.001 / 100), 2) AS avg_profit_per_transaction
    FROM savings_savingsaccount
    WHERE confirmed_amount > 0
    GROUP BY owner_id
)

-- SELECT * FROM tenure;
-- SELECT * FROM total_txn;
-- SELECT * FROM avg_profit;

SELECT 
    tn.customer_id,
    tn.name,
    tn.tenure_months,
    ttxn.total_transactions,
    ROUND(((ttxn.total_transactions / NULLIF(tn.tenure_months, 0)) * 12 * ap.avg_profit_per_transaction), 2)
    AS estimated_clv
FROM tenure tn
JOIN total_txn ttxn
    ON tn.customer_id = ttxn.owner_id
JOIN avg_profit ap
    ON tn.customer_id = ap.owner_id
ORDER BY estimated_clv DESC;

-- replacing null months with zeros for mor accuracy     
-- round(((ttxn.total_transactions / NULLIF(tn.tenure_months, 0)) * 12 * ap.avg_profit_per_transaction), 2)

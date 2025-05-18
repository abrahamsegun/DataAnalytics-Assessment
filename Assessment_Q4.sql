USE `adashi_staging`;

-- select * from users_customuser;
-- select * from savings_savingsaccount;

-- Acct Tenure 
-- duration a customer have had a acct 
CREATE OR REPLACE VIEW tenure as (
    select 
        id AS customer_id,
        CONCAT(first_name, ' ', last_name) AS name,
        timestampdiff(month, created_on, curdate()) AS tenure_months
    from users_customuser
);

CREATE OR REPLACE VIEW total_txn AS (
    select 
        owner_id,
        ROUND(SUM(confirmed_amount) / 100, 2) AS total_transactions
     from savings_savingsaccount
     where confirmed_amount > 0
     group by owner_id
);

CREATE OR REPLACE VIEW avg_profit AS (
    select 
    owner_id,
    ROUND(AVG(confirmed_amount * 0.001 / 100), 2) AS avg_profit_per_transaction
	from savings_savingsaccount
    where confirmed_amount > 0
    group by owner_id
);

-- SELECT * FROM tenure;
-- SELECT * FROM total_txn;
-- SELECT * FROM avg_profit;

SELECT 
    tn.customer_id,
    tn.name,
    tn.tenure_months,
    ttxn.total_transactions,
    round(((ttxn.total_transactions / NULLIF(tn.tenure_months, 0)) * 12 * ap.avg_profit_per_transaction), 2)
    AS estimated_clv
FROM tenure tn
JOIN total_txn ttxn
ON tn.customer_id = ttxn.owner_id
JOIN avg_profit ap
ON tn.customer_id = ap.owner_id
ORDER BY estimated_clv DESC;

-- using the provided formula for avg_profit_per_transaction 
-- replacing null months with zeros for mor accuracy     
-- round(((ttxn.total_transactions / NULLIF(tn.tenure_months, 0)) * 12 * ap.avg_profit_per_transaction), 2)







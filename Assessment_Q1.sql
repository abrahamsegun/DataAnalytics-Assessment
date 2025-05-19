USE `adashi_staging`;
-- create a subquery for counting both savings and investment 
-- This will calculate all total_saving for each individaul and the number of times thaey have deposited
WITH savings AS (
    SELECT owner_id, COUNT(*) AS savings_count, SUM(confirmed_amount) AS total_savings
    FROM savings_savingsaccount
    WHERE confirmed_amount > 0
    GROUP BY owner_id
),
-- This will do the same for the investment
investments AS (
    SELECT owner_id, COUNT(*) AS investment_count, SUM(amount) AS total_investments
    FROM plans_plan
    WHERE amount > 0
    GROUP BY owner_id
)
-- Covert from kobo to naria by dividing by 100
SELECT 
    u.id AS owner_id,
    CONCAT(u.first_name, ' ', u.last_name) AS name,
    s.savings_count,
    i.investment_count,
    ROUND((s.total_savings + i.total_investments) / 100, 2) AS total_deposits
FROM users_customuser u
JOIN savings s ON u.id = s.owner_id
JOIN investments i ON u.id = i.owner_id
ORDER BY total_deposits DESC;

-- The ROUND((s.total_savings + i.total_investments)/100, 2) AS total_deposits is to add total saving and investment by a single individual in both account. 
-- This way it will calculate for at least one of them either saving or investemnt account and convert the result to naira and  round up to kobo, two decimal places 
-- Sort it by total deposit to rank from highest deposit to lowest 

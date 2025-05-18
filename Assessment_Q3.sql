USE `adashi_staging`;

-- SELECT * FROM `plans_plan`;
-- SELECT * FROM `savings_savingsaccount`;

-- NOTE : savings_plan : is_regular_savings = 1
--                      investment_plan: is_a_fund = 1

SELECT SSA.plan_id, SSA.owner_id,
case 
	when PP.is_a_fund = 1 then 'Investment'
	when PP.is_regular_savings = 1 then 'Savings'
end as `type`, date(max(SSA.transaction_date)) as last_transaction_date,
datediff(curdate(), max(SSA.transaction_date)) AS inactivity_days
FROM plans_plan AS PP 
JOIN savings_savingsaccount AS SSA
on PP.id = SSA.plan_id
where (PP.is_a_fund = 1 OR PP.is_regular_savings = 1)
group by SSA.plan_id, SSA.owner_id, PP.is_a_fund, PP.is_regular_savings
Having 
inactivity_days > 365
order by
inactivity_days asc;


-- datediff() function ddifferciate dates 
-- categorize acct into invsetment and saving
-- filter agg function of inactive account more than a year




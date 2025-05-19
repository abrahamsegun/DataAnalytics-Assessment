### Data Analytics Assessment 

# Database used `adashi_staging`

## Question One 
# Per-Question Explanation
1. To identify customers with at least one funded account, I joined the necessary tables: users_customer, saving_savingaccount, and plans_plan, using owner_id as the key and I used a subquery to get saving and investemnt amount from the individual table.
2. From the savings table, I used confirmed_amount to calculate total deposits. From the investments table, I used the amount field. I filtered only those with amount > 0 to ensure only funded accounts were considered. 
3. I used the CONCAT() function to combine first and last names into a full name
4. As suggested, I converted all monetary values from Kobo to Naira using the formula kobo / 100, and rounded the result to two decimal places
5. I added deposits from both savings and investments to calculate the total deposit per customer, as they belong to different account types
# Challenges:
1. Initially, I didn’t realize that owner_id in the savings and investment tables corresponds to the id in users_customer, which caused some confusion when joining tables.
2. Differentiating between confirmed_amount and amount in the savings table was tricky and required close attention

## Question Two
# Per-Question Explanation
1. To get how often customers transact per month, I first created a view to know the users transaction per month and group it by each user.
2. Created another view `avg_txn` to have the avg transaction per customer per month. 
3. Categories usig the case clause according. High, Medium and Low freq. 
# Challenges:
1. Breaking down the logic was hard

## Question Three
# Per-Question Explanation
1. Select the needed column from the output template provided.
2. used the `max()` to get the higest/latest date and then `date()` to only get dat from the datetime 
2. learnt the datediff() after being struck to the date differnces. 
3. I filtered by `PP.is_a_fund = 1 OR PP.is_regular_savings = 1` to make sure only active acct was selected
3. Because the `inactivity days` is a function, I had to use having to filtered  `inactivity days` greater than 365 hence inactive acct over a year can be seen.
4. Order by `inactivity days`
# Challenges:
1. Have to learn how the date diff calcultions work i.e `datediff()` and was struck init for a long time
2. May be the logic before finally getting it


## Question Four
# Per-Question Explanation
In order to get the CLV based on account tenure and transaction volume.
1. I had to get the acct tensure, the total duration for the acct, using the `timestampdiff()` method
2. Got the total txn using the saving table, the total money transacted and also got the avg profit per customer 
2. using     ` round(((ttxn.total_transactions / NULLIF(tn.tenure_months, 0)) * 12 * ap.avg_profit_per_transaction), 2)` provided and replacing null months with zeros for mor accuracy 
4. Order by `inactivity days`
# Challenges:
1. the handle of the Null values later handled with `nullif`
2. Interpretation 
3. Not sure of the total transaction being current_amount only but had to work with what table the question says was needed

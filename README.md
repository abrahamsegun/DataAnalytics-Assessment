### Data Analytics Assessment 

# Ran the database `adashi_staging`

## Question One 
# Per-Question Explanation
1. To find the customer with at least a funded account, I joined all the tables invloved users_customer, saving_savingaccount and plans_plan on owner_id using a subquery to get saving and investemnt information from the individual table.
2. For the saving i used the confimred amount to get total deposit and use amount for the investemnt table  and filtered amount > 0, to get funded account. 
3. In the final query to get my table I used concat() function to get my name 
4. I also convert the total deposit from kobo to naria as suggestion in the hint for the question using kobo/100 = naria and rounded into two decimal places
5. i used the saving plus investemnt deposit as my total deposit since both are from different account
# Challenges:
1. I did pay closer attention at first that the `owner_id` is same as `id` in users_customuser, it gave headache initially to join all the three tables together.
2. Hard time trying not to misinterpret `confirmed_amount` and just` amount` on the saving table

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

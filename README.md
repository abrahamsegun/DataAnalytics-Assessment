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
1. It took some time to break down the logic into workable steps and understand how well to segment transaction frequency. 

## Question Three
# Per-Question Explanation
1. I selected relevant columns based on the provided output template.
2. To find the most recent transaction date, I used MAX() and then converted it to a date using the DATE() function and applied the DATEDIFF() to get the date differennce. 
3. I filtered records using the condition PP.is_a_fund = 1 OR PP.is_regular_savings = 1 to ensure only active accounts were considered.
4. Since inactivity_days was a calculated field, I used HAVING instead of WHERE to filter for customers with over 365 days of inactivity.
5. I ordered the results by `inactivity_days` to show the most inactive users first
# Challenges:
1. Structuring the logic and getting the correct filters in place was somewhat complex


## Question Four
# Per-Question Explanation
In order to get the CLV based on account tenure and transaction volume.
1. I calculated the account tenure (in months) using the TIMESTAMPDIFF() function.
2. I calculated total transaction volume using the savings table, and also computed the average profit per customer 
3. I used the provided formula: ROUND(((total_transactions / NULLIF(tenure_months, 0)) * 12 * avg_profit_per_transaction), 2) to calculate CLV, replacing zero tenure months with NULL to avoid division errors. 
4. Order by `inactivity days`
# Challenges:
1. Handling NULL values correctly using NULLIF() was important to ensure the formula didn’t break
2. Understanding the formula and interpreting what was meant by “total transactions” required some assumption. I relied on current_amount from the savings table based on the table given for question 4 - users_customers and savings account.

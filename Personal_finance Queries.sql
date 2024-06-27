SELECT *
FROM Transactions

--Change Amount column data type to DECIMAL

ALTER TABLE Transactions
ALTER COLUMN Amount DECIMAL(10, 2)

--Calculate spending per month

SELECT
SUM(Amount) AS Spending_PerMonth
FROM
Transactions
WHERE 
DATE BETWEEN '2018-01-01' AND '2018-01-29'

--Calculate average spending per month

SELECT 
SUM(Amount) / 21 AS Average_Spending
FROM 
Transactions

--Total spent by category
SELECT 
    category, 
    SUM(amount) AS total_spent 
FROM 
    transactions 
WHERE 
    transaction_type = 'debit' 
GROUP BY 
    category

--Total average by category

SELECT 
    category, 
    SUM(amount)/21 AS total_spent 
FROM 
    transactions 
WHERE 
    transaction_type = 'debit' 
GROUP BY 
    category

--budget vs actual spent

SELECT 
    b.category, 
	DATEPART(YEAR, t.date) AS year,
    DATEPART(MONTH, t.date) AS month,
    b.Budget AS budgeted_amount, 
    COALESCE(SUM(t.amount), 0) AS actual_spent, 
    (b.Budget - COALESCE(SUM(t.amount), 0)) AS difference 
FROM 
    budget b 
LEFT JOIN 
    transactions t 
ON 
    b.category = t.category 
    AND t.transaction_type = 'debit' 
GROUP BY 
    b.category, 
	DATEPART(YEAR, t.date),
    DATEPART(MONTH, t.date),
    b.Budget;

--Total Income per month

SELECT 
    SUM(amount) AS total_income,
	DATEPART(YEAR, date) AS year,
    DATEPART(MONTH, date) AS month
FROM 
    transactions 
WHERE 
    transaction_type = 'credit'
GROUP BY 
    DATEPART(YEAR, date), 
    DATEPART(MONTH, date);

--Total income

SELECT 
    SUM(amount) AS total_income 
FROM 
    transactions 
WHERE 
    transaction_type = 'credit';

--Net savings

SELECT 
    (SELECT SUM(amount) FROM transactions WHERE transaction_type = 'credit') - 
    (SELECT SUM(amount) FROM transactions WHERE transaction_type = 'debit') AS net_savings;


--Amount spent each day

SELECT 
    date, 
    SUM(amount) AS total_spent 
FROM 
    transactions 
WHERE 
    transaction_type = 'debit' 
GROUP BY 
    date 
ORDER BY 
    date;

--Expense by account name

SELECT 
    account_name, 
    SUM(amount) AS total_spent 
FROM 
    transactions 
WHERE 
    transaction_type = 'debit' 
GROUP BY 
    account_name;



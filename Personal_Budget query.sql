SELECT *
FROM Budget

--Change the data type on budget from varchar to int

ALTER TABLE Budget
ALTER COLUMN Budget INT

--Calculate the total of the budget--

SELECT
SUM(Budget) AS Total_Budget
From Budget


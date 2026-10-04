-- Salesperson Performance Analysis
-- Load Salesperson_Performance_Data.csv into a table named sales_data.

-- 1. Overall salesperson performance
SELECT Salesperson, Territory,
       SUM(Sales) AS Total_Sales,
       SUM(Profit) AS Total_Profit,
       COUNT(DISTINCT Order_ID) AS Orders,
       AVG(Sales) AS Average_Order_Value,
       SUM(Profit) / NULLIF(SUM(Sales),0) AS Profit_Margin
FROM sales_data
GROUP BY Salesperson, Territory
ORDER BY Total_Sales DESC;

-- 2. Year-over-year sales growth
WITH yearly AS (
    SELECT Salesperson, EXTRACT(YEAR FROM Order_Date) AS Sales_Year,
           SUM(Sales) AS Yearly_Sales
    FROM sales_data
    GROUP BY Salesperson, EXTRACT(YEAR FROM Order_Date)
)
SELECT Salesperson,
       MAX(CASE WHEN Sales_Year=2024 THEN Yearly_Sales END) AS Sales_2024,
       MAX(CASE WHEN Sales_Year=2025 THEN Yearly_Sales END) AS Sales_2025,
       (MAX(CASE WHEN Sales_Year=2025 THEN Yearly_Sales END)
        - MAX(CASE WHEN Sales_Year=2024 THEN Yearly_Sales END))
        / NULLIF(MAX(CASE WHEN Sales_Year=2024 THEN Yearly_Sales END),0) * 100 AS Growth_Percent
FROM yearly
GROUP BY Salesperson
ORDER BY Growth_Percent DESC;

-- 3. Profit ranking
SELECT Salesperson, SUM(Profit) AS Total_Profit,
       RANK() OVER (ORDER BY SUM(Profit) DESC) AS Profit_Rank
FROM sales_data
GROUP BY Salesperson;

-- 4. Territory comparison
SELECT Territory, SUM(Sales) AS Total_Sales, SUM(Profit) AS Total_Profit,
       SUM(Profit)/NULLIF(SUM(Sales),0) AS Profit_Margin,
       AVG(Sales) AS Average_Order_Value
FROM sales_data
GROUP BY Territory
ORDER BY Total_Sales DESC;

-- 5. Multi-KPI comparison
WITH metrics AS (
    SELECT Salesperson, SUM(Sales) AS Sales, SUM(Profit) AS Profit, AVG(Sales) AS AOV
    FROM sales_data
    GROUP BY Salesperson
)
SELECT Salesperson, Sales, Profit, AOV,
       RANK() OVER (ORDER BY Sales DESC) AS Sales_Rank,
       RANK() OVER (ORDER BY Profit DESC) AS Profit_Rank,
       RANK() OVER (ORDER BY AOV DESC) AS AOV_Rank
FROM metrics
ORDER BY Profit DESC;

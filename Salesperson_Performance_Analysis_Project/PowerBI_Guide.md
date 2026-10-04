# Power BI Dashboard Guide

## Import
Get Data → Text/CSV → Salesperson_Performance_Data.csv.

## DAX measures
```DAX
Total Sales = SUM(Salesperson_Performance_Data[Sales])
Total Profit = SUM(Salesperson_Performance_Data[Profit])
Total Orders = DISTINCTCOUNT(Salesperson_Performance_Data[Order_ID])
Average Order Value = DIVIDE([Total Sales], [Total Orders])
Profit Margin = DIVIDE([Total Profit], [Total Sales])
Sales 2024 = CALCULATE([Total Sales], YEAR(Salesperson_Performance_Data[Order_Date]) = 2024)
Sales 2025 = CALCULATE([Total Sales], YEAR(Salesperson_Performance_Data[Order_Date]) = 2025)
Sales Growth % = DIVIDE([Sales 2025]-[Sales 2024], [Sales 2024])
```

## Visuals
- KPI cards: Sales, Profit, Margin, Orders, AOV
- Salesperson vs Sales
- Salesperson vs Profit
- Salesperson vs Growth %
- Sales vs Profit scatter; bubble size = Orders; legend = Territory
- Monthly Sales line chart
- Matrix: Salesperson, Territory, Sales, Profit, Growth %, AOV
- Slicers: Year, Territory, Category, Salesperson

## Fair comparison
Use Territory as a slicer and compare salespeople within the same territory. Do not judge performance from raw revenue alone.

# Coffee-Shop-Sales-Analysis-SQL
# ☕ Coffee Shop Sales & Market Potential Analysis (SQL)
<img width="1500" height="1018" alt="image" src="https://github.com/user-attachments/assets/987d0b35-69ed-4fae-ad6b-51f2e92b8538" />


## 📌 Project Overview
This project is a data analysis portfolio piece focused on evaluating the sales performance and market potential of a coffee shop chain. By querying a relational database, the analysis extracts actionable insights regarding customer segmentation, product performance, and monthly revenue growth, ultimately aiming to identify the most profitable locations for business expansion.

## 📊 Dataset Overview
- **Timeframe:** January 2023 - October 2024.
- **Geographic Scope:** 14 major cities in India (Bangalore, Chennai, Pune, Jaipur, Delhi, Mumbai, Hyderabad, Ahmedabad, Kolkata, Surat, Lucknow, Kanpur, Nagpur, Indore).
- **Data Volume:** Contains over 10388 transaction records, 497 unique customers, and 28 coffee products.
- **Data Source:** Simulated educational dataset sourced from an online YouTube guided analytics project.

## 🛠 Tech Stack & SQL Concepts
- **Database Environment:** SQLite
- **Key SQL Skills Applied:**
  - Complex `JOIN` operations
  - Data Aggregation (`SUM`, `AVG`, `COUNT`, `ROUND`)
  - Common Table Expressions (CTEs) using `WITH`
  - Window Functions (`DENSE_RANK()`, `LAG()`)
  - Time-series Data Extraction (`strftime`)

## 🗂️ Database Schema
The relational database consists of four main tables:
1. `city`: Contains city demographics (population, estimated rent).
2. `products`: Product details and pricing.
3. `customers`: Customer IDs mapped to their respective cities.
4. `sales`: Transaction-level data recording sales dates, product IDs, and total amounts.
<img width="1076" height="480" alt="schema_diagram" src="https://github.com/user-attachments/assets/06d2d6be-1c07-4106-a829-0ce44c9249a2" />

## 🎯 Key Business Questions Answered
The `queries.sql` file contains solutions to the following 10 business problems:
1. **Coffee Consumers Count:** Estimating the target audience (25% of the population) per city.
2. **Total Revenue:** Calculating total revenue generated in Q4 2023.
3. **Sales Count for Each Product:** Identifying total units sold and revenue per product.
4. **Average Sales Amount:** Calculating average order value and average revenue per customer by city.
5. **City Population vs. Consumers:** Returning city population alongside estimated consumer bases.
6. **Top Selling Products:** Ranking the Top 3 products in each city using Window Functions.
7. **Customer Segmentation:** Counting unique customers per city.
8. **Average Sale vs. Rent:** Comparing average revenue per customer against the city's estimated rent per customer to evaluate profitability.
9. **Monthly Sales Growth:** Calculating the month-over-month (MoM) growth/decline rate by city.
10. **Market Potential Analysis:** Identifying the Top 3 cities based on highest sales and summarizing key metrics.

## 💡 Key Insights (Executive Summary)
- **Top Performing Markets:** Pune, Chennai, and Bangalore are the undisputed leaders in generating the highest total revenue, establishing themselves as the core markets for the business.
- **Cost Efficiency & High Profitability:** A direct comparison between average sales and estimated rent per customer reveals massive profit margins in top-tier cities. For instance, in Pune and Chennai, the revenue per customer substantially outweighs the allocated rental cost, indicating low real estate risk and high operational efficiency.
- **Primary Revenue Driver:** While product preferences vary slightly by region, the 'Cold Brew Coffee Pack (6 Bottles)' stands out as the ultimate flagship product, generating the highest total revenue across the entire network..

## 🚀 How to Run
1. Clone this repository to your local machine.
2. Ensure you have a SQLite environment set up (e.g., DB Browser for SQLite, DBeaver, or standard CLI).
3. Load the provided dataset file.
4. Execute the code found in `queries.sql` to replicate the analysis.

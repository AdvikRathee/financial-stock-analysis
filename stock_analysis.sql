-- ================================================
-- 📈 Financial Stock Analysis — SQL Queries
-- Dataset: S&P 500 (Kaggle) | 619K rows
-- Companies: AAPL, MSFT, GOOGL, AMZN
-- Period: 2013 - 2018
-- ================================================


-- ── 1. Basic Data Exploration ──────────────────

-- Total records and unique companies
SELECT 
    COUNT(*) AS total_records,
    COUNT(DISTINCT Name) AS total_companies
FROM cleaned_stocks;

-- Date range of dataset
SELECT 
    MIN(date) AS start_date,
    MAX(date) AS end_date,
    DATEDIFF(MAX(date), MIN(date)) AS total_days
FROM cleaned_stocks;

-- Check for null values
SELECT
    SUM(CASE WHEN close IS NULL THEN 1 ELSE 0 END) AS null_close,
    SUM(CASE WHEN open IS NULL THEN 1 ELSE 0 END) AS null_open,
    SUM(CASE WHEN volume IS NULL THEN 1 ELSE 0 END) AS null_volume,
    SUM(CASE WHEN Name IS NULL THEN 1 ELSE 0 END) AS null_name
FROM cleaned_stocks;


-- ── 2. Company Performance Summary ─────────────

-- Total return % for each of the 4 companies
SELECT 
    Name,
    ROUND(MIN(close), 2) AS start_price,
    ROUND(MAX(close), 2) AS peak_price,
    ROUND(((MAX(close) - MIN(close)) / MIN(close)) * 100, 2) AS total_return_pct
FROM cleaned_stocks
WHERE Name IN ('AAPL', 'MSFT', 'GOOGL', 'AMZN')
GROUP BY Name
ORDER BY total_return_pct DESC;

-- Average closing price and volume per company
SELECT 
    Name,
    ROUND(AVG(close), 2) AS avg_close_price,
    ROUND(AVG(volume), 0) AS avg_daily_volume,
    COUNT(*) AS trading_days
FROM cleaned_stocks
WHERE Name IN ('AAPL', 'MSFT', 'GOOGL', 'AMZN')
GROUP BY Name
ORDER BY avg_close_price DESC;


-- ── 3. Yearly Price Trends ─────────────────────

-- Average, max, min closing price per year per company
SELECT 
    Name,
    YEAR(date) AS year,
    ROUND(AVG(close), 2) AS avg_close,
    ROUND(MAX(close), 2) AS max_close,
    ROUND(MIN(close), 2) AS min_close,
    ROUND(MAX(close) - MIN(close), 2) AS yearly_range
FROM cleaned_stocks
WHERE Name IN ('AAPL', 'MSFT', 'GOOGL', 'AMZN')
GROUP BY Name, YEAR(date)
ORDER BY Name, year;


-- ── 4. Best and Worst Trading Days ─────────────

-- Top 5 best single days across all companies
SELECT 
    date,
    Name,
    ROUND(open, 2) AS open_price,
    ROUND(close, 2) AS close_price,
    ROUND(((close - open) / open) * 100, 2) AS daily_return_pct
FROM cleaned_stocks
WHERE Name IN ('AAPL', 'MSFT', 'GOOGL', 'AMZN')
ORDER BY daily_return_pct DESC
LIMIT 5;

-- Top 5 worst single days across all companies
SELECT 
    date,
    Name,
    ROUND(open, 2) AS open_price,
    ROUND(close, 2) AS close_price,
    ROUND(((close - open) / open) * 100, 2) AS daily_return_pct
FROM cleaned_stocks
WHERE Name IN ('AAPL', 'MSFT', 'GOOGL', 'AMZN')
ORDER BY daily_return_pct ASC
LIMIT 5;


-- ── 5. Volatility Analysis ─────────────────────

-- Daily price range (high - low) as volatility proxy
SELECT 
    Name,
    ROUND(AVG(high - low), 2) AS avg_daily_range,
    ROUND(MAX(high - low), 2) AS max_daily_range,
    ROUND(MIN(high - low), 2) AS min_daily_range
FROM cleaned_stocks
WHERE Name IN ('AAPL', 'MSFT', 'GOOGL', 'AMZN')
GROUP BY Name
ORDER BY avg_daily_range DESC;

-- Monthly volatility (avg daily range per month)
SELECT 
    Name,
    YEAR(date) AS year,
    MONTH(date) AS month,
    ROUND(AVG(high - low), 2) AS avg_monthly_range
FROM cleaned_stocks
WHERE Name IN ('AAPL', 'MSFT', 'GOOGL', 'AMZN')
GROUP BY Name, YEAR(date), MONTH(date)
ORDER BY avg_monthly_range DESC
LIMIT 10;


-- ── 6. Window Functions ────────────────────────

-- 20-day moving average for AAPL
SELECT 
    date,
    Name,
    ROUND(close, 2) AS close_price,
    ROUND(AVG(close) OVER (
        PARTITION BY Name 
        ORDER BY date 
        ROWS BETWEEN 19 PRECEDING AND CURRENT ROW
    ), 2) AS moving_avg_20d,
    ROUND(AVG(close) OVER (
        PARTITION BY Name 
        ORDER BY date 
        ROWS BETWEEN 49 PRECEDING AND CURRENT ROW
    ), 2) AS moving_avg_50d
FROM cleaned_stocks
WHERE Name = 'AAPL'
ORDER BY date;

-- Rank companies by avg closing price each year
SELECT 
    Name,
    YEAR(date) AS year,
    ROUND(AVG(close), 2) AS avg_close,
    RANK() OVER (
        PARTITION BY YEAR(date) 
        ORDER BY AVG(close) DESC
    ) AS price_rank
FROM cleaned_stocks
WHERE Name IN ('AAPL', 'MSFT', 'GOOGL', 'AMZN')
GROUP BY Name, YEAR(date)
ORDER BY year, price_rank;

-- Cumulative max price (all-time high tracker) for AMZN
SELECT 
    date,
    Name,
    ROUND(close, 2) AS close_price,
    ROUND(MAX(close) OVER (
        PARTITION BY Name 
        ORDER BY date
    ), 2) AS all_time_high,
    CASE 
        WHEN close = MAX(close) OVER (PARTITION BY Name ORDER BY date)
        THEN 'NEW HIGH 🚀'
        ELSE ''
    END AS ath_flag
FROM cleaned_stocks
WHERE Name = 'AMZN'
ORDER BY date;

-- LAG function — compare today vs yesterday close (MSFT)
SELECT 
    date,
    Name,
    ROUND(close, 2) AS close_price,
    ROUND(LAG(close) OVER (PARTITION BY Name ORDER BY date), 2) AS prev_close,
    ROUND(close - LAG(close) OVER (PARTITION BY Name ORDER BY date), 2) AS price_change,
    ROUND(((close - LAG(close) OVER (PARTITION BY Name ORDER BY date)) / 
           LAG(close) OVER (PARTITION BY Name ORDER BY date)) * 100, 4) AS daily_return_pct
FROM cleaned_stocks
WHERE Name = 'MSFT'
ORDER BY date;


-- ── 7. Comparative Analysis ────────────────────

-- Which company had most trading days above $200?
SELECT 
    Name,
    COUNT(*) AS days_above_200
FROM cleaned_stocks
WHERE close > 200
  AND Name IN ('AAPL', 'MSFT', 'GOOGL', 'AMZN')
GROUP BY Name
ORDER BY days_above_200 DESC;

-- Quarter-wise average returns
SELECT 
    Name,
    YEAR(date) AS year,
    QUARTER(date) AS quarter,
    ROUND(AVG(close), 2) AS avg_close,
    ROUND(MAX(close) - MIN(close), 2) AS quarterly_range
FROM cleaned_stocks
WHERE Name IN ('AAPL', 'MSFT', 'GOOGL', 'AMZN')
GROUP BY Name, YEAR(date), QUARTER(date)
ORDER BY Name, year, quarter;

-- Final summary — key metrics for recruiter insight
SELECT 
    Name,
    COUNT(*) AS total_trading_days,
    ROUND(MIN(close), 2) AS lowest_price,
    ROUND(MAX(close), 2) AS highest_price,
    ROUND(AVG(close), 2) AS avg_price,
    ROUND(AVG(volume)/1000000, 2) AS avg_volume_millions,
    ROUND(((MAX(close) - MIN(close)) / MIN(close)) * 100, 1) AS total_return_pct
FROM cleaned_stocks
WHERE Name IN ('AAPL', 'MSFT', 'GOOGL', 'AMZN')
GROUP BY Name
ORDER BY total_return_pct DESC;

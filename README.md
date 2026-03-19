# 📈 Financial Stock Analysis Dashboard

## 📌 Project Overview
Analyzed **619,000+ rows** of S&P 500 historical stock data to uncover price trends, volatility patterns, and investment returns for major tech companies (AAPL, MSFT, GOOGL, AMZN).

Built an end-to-end data pipeline from raw CSV → Python EDA → Moving Averages → Volatility Analysis → Power BI Dashboard + Live Yahoo Finance API integration.

> *"This project demonstrates: data extraction, cleaning, financial analysis, volatility modeling, and business storytelling."*

---

## 🎯 Problem Statement
Every investor faces 3 core questions:
- **Which stock gave the best returns?**
- **Which stock carries the most risk?**
- **How do stocks perform in real-time vs historically?**

This project answers all 3 using real S&P 500 data.

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|------|---------|
| Python (Pandas, NumPy) | Data cleaning, EDA, feature engineering |
| Matplotlib & Seaborn | Charts, distributions, visualizations |
| yfinance | Live stock data via Yahoo Finance API |
| SQL | Data querying and aggregation |
| Power BI | Interactive dashboard |

---

## 📁 Project Structure

```
financial-stock-analysis/
├── 📂 data/
│   ├── all_stocks_5yr.csv          ← Raw Kaggle dataset
│   ├── cleaned_stocks.csv          ← Cleaned data (5,036 rows)
│   ├── summary_stats.csv           ← Company performance summary
│   ├── live_returns_long.csv       ← Yahoo Finance live data
│   └── volatility_data.csv         ← Rolling volatility data
├── 📂 plots/
│   ├── aapl_moving_avg.png
│   ├── cumulative_returns.png
│   ├── daily_returns_dist.png
│   ├── live_returns_2024.png
│   └── volatility.png
├── analysis.ipynb                  ← Full Python analysis
├── stock_analysis.sql              ← SQL queries
├── stock_analysis.pbix             ← Power BI Dashboard
└── README.md
```

---

## ⚙️ Project Workflow

```
RAW DATA → DATA CLEANING → EDA → MOVING AVERAGES → VOLATILITY → LIVE DATA → POWER BI
```

### Step 1 — Data Extraction & Cleaning
- Loaded 619,040 rows from Kaggle S&P 500 dataset
- Removed null values (open: 11, high/low: 8 each)
- Removed duplicates and negative price/volume entries
- Converted date column to proper datetime format
- Filtered 4 key companies: AAPL, MSFT, GOOGL, AMZN

### Step 2 — Exploratory Data Analysis (Python)
- Analyzed price distributions using Pandas describe()
- Plotted closing price trends over 5 years
- Identified seasonal patterns and peak periods

### Step 3 — Moving Averages (Trend Analysis)
- Calculated 20-day and 50-day rolling moving averages
- Identified bullish/bearish crossover signals
- Visualized short-term vs long-term price trends

### Step 4 — Returns & Volatility Analysis
- Calculated daily returns using pct_change()
- Computed 20-day annualized rolling volatility
- Compared cumulative returns across all 4 companies

### Step 5 — Live Data (Yahoo Finance API)
- Fetched 2023-2024 live data using yfinance
- Compared historical vs live cumulative returns
- Validated findings with real-time market data

### Step 6 — Power BI Dashboard
- Built interactive dashboard with company slicer
- Created KPI cards, line charts, bar charts, area charts
- Added key insights section for business storytelling

---

## 📊 Company Performance Summary

| Company | Total Return | Avg Volatility | Best Day | Worst Day |
|---------|-------------|----------------|----------|-----------|
| 🏆 AMZN | **440.9%** | 28.9% | +14.13% | -11.00% |
| 📈 MSFT | 225.3% | 22.6% | +10.45% | -11.40% |
| 📊 GOOGL | 168.5% | 22.0% | +16.26% | -5.41% |
| 🍎 AAPL | 135.1% | 23.2% | +8.20% | -7.99% |

---

## 💡 Key Business Insights

```
🏆 AMZN gave 440.9% return (2013-2018) — best performer by far
⚡ AMZN highest risk: 28.9% volatility vs GOOGL lowest at 22.0%
📉 MSFT worst single day: -11.40% drawdown
🚀 Live 2024: AMZN again top with ~160% cumulative return in 2 years
💡 AAPL most stable — daily returns follow normal distribution
📊 All 4 companies significantly outperformed S&P 500 average
```

---

## 📸 Dashboard Preview

<img width="1371" height="766" alt="image" src="https://github.com/user-attachments/assets/894a269b-b5d0-4b29-95d8-b5f95df19d78" />


---

## 🚀 How to Run

**Python:**
```bash
# Clone the repo
git clone https://github.com/AdvikRathee/financial-stock-analysis

# Install dependencies
pip install pandas numpy matplotlib seaborn yfinance jupyter

# Open notebook
jupyter notebook analysis.ipynb
```

**SQL:**
```sql
-- Run stock_analysis.sql in any MySQL / SQL Server environment
-- Or use SQLite for local testing
```

**Power BI:**
```
Open stock_analysis.pbix in Power BI Desktop
```

---

## 📦 Dataset

- **Source:** [S&P 500 Stock Data — Kaggle](https://www.kaggle.com/datasets/camnugent/sandp500)
- **Live Data:** Yahoo Finance API via yfinance
- **Records:** 619,040 rows (raw) → 5,036 rows (filtered, 4 companies)
- **Period:** February 2013 – February 2018 (Historical) + 2023-2024 (Live)
- **Companies:** AAPL, MSFT, GOOGL, AMZN

---

## 📬 Connect

**Advik Rathee**
- 🔗 [LinkedIn](https://linkedin.com/in/advikrathee)
- 💻 [GitHub](https://github.com/AdvikRathee)
- 📧 advikrathee@gmail.com

---

⭐ If you found this project helpful, please give it a star!


⭐ If you found this project helpful, please give it a star!

# 🏭 Industrial Equipment Downtime & Efficiency Analysis (SQL)

## 📌 Project Overview
This project focuses on analyzing real-time industrial data from a processing plant (specifically targeting Pumps, Steam Boilers, and Compressors). The goal is to detect unplanned downtime, calculate financial/energy losses during idle times, and trigger automated alarm statuses based on critical operational thresholds (temperature and pressure).
---

## 📖 Data Dictionary (Azerbaijani to English)
Since the source database utilizes industry-standard terms in Azerbaijani (reflecting real plant operations), this guide helps translate the objects:

| Azerbaijani Term | English Translation | Description |
|---|---|---|
| `Avadanliqlar` / `AvadanliqID` | Equipment / Asset ID | Equipment master table |
| `Dayanma_Logu` | Downtime Log | Table tracking equipment stops |
| `Parametr_Logu` | Process Metrics Log | Hourly sensor readings |
| `Tezyiq_Bar` | Pressure (Bar) | Pressure sensor reading |
| `Temperatur_C` | Temperature (°C) | Temperature sensor reading |
| `Axin_m3_h` | Flow Rate (m³/h) | Flow rate of the fluid/gas |
| `Enerji_kWh` | Energy Consumption | Electrical energy used |
| `Səbəb` | Failure Reason | The cause of the downtime |
| `Tip` (Planlı / Plansız) | Type (Scheduled / Unscheduled) | Downtime classification |

---
## 🗄️ Database Schema & Architecture
The database (`test_zavod`) consists of three main tables designed with proper relational constraints:
1. **`Avadanliqlar` (Assets):** Master data of factory equipment.
2. **`Dayanma_Logu` (Downtime Logs):** Tracked events of scheduled and unscheduled breakdowns.
3. **`Parametr_Logu` (Process Metrics):** Hourly sensor logs capturing Pressure (Bar), Temperature (°C), Flow Rate (m³/h), and Energy Consumption (kWh).

---

## 📊 Analytical Scenarios Resolved

### 🔍 Scenario 1: Unplanned Downtime Impact (MTTR Analysis)
Calculates total lost operational time and Mean Time to Repair (MTTR) per asset for emergency breakdowns. Helps maintenance planning.

### ⚡ Scenario 2: Idle Energy Loss Detection
Identifies periods where equipment flow rate is `0` (stopped), but auxiliary systems are still drawing electrical power. Isolates direct financial waste.

### 🌡️ Scenario 3: Smart Process Alarms (Anomaly Detection)
Uses custom dynamic threshold logic per asset type (e.g., Boiler temperature > 249°C, Compressor pressure > 6.45 Bar) to filter and display operational risks instantly.

---

## 🛠️ How to Run
1. Import the full script from `zavod_analiz.sql`.
2. Run the database setup and data insertion sections.
3. Execute the analytical queries to extract the business insights.

**Tech Stack:** MySQL Workbench, Relational Database Design, SQL Joins, CASE WHEN Conditional Logic, HAVING Filter, Aggregation.

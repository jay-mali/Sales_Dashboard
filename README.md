# Sales_Dashboard
<img width="1383" height="777" alt="image" src="https://github.com/user-attachments/assets/d6520f34-2b26-46c2-9f0a-99004053397d" />

# Retail Sales Analytics Project  
*Excel • MySQL • Power BI*

## 📘 Introduction  

The Retail Sales Analytics dashboard provides a complete picture of sales performance across regions, categories, products, and customers.  
The goal is simple: **turn raw retail transaction data into meaningful business insights**.

Using Excel for data cleaning, MySQL for structured storage and validation, and Power BI for interactive reporting, this project simulates a real-world analytics workflow used in companies.

This project highlights:
- Data transformation  
- SQL analysis  
- Data modeling  
- DAX measures  
- KPI-driven dashboards  

It is designed to demonstrate end-to-end analytics capability.

---

## 🧠 Skills Showcased  

### **⚙️ Data Cleaning & Preparation (Excel & Power Query)**  
- Standardized inconsistent date formats  
- Removed duplicate rows  
- Ensured product name consistency  
- Verified column-level data types  

### **🗄️ SQL for Data Quality & Analysis (MySQL)**  
- Duplicate detection and safe deletion  
- KPI computations (sales, profit, order count, AOV)  
- Aggregations by region, category, and time period  
- Joins using product name matching  
- Created a reporting view (`vw_sales_orders`) for BI tools  

### **📊 Power BI Reporting & Modeling**  
- Clean star schema model (Orders ↔ Sales ↔ Products)  
- DAX measures for:  
  - Total Sales  
  - Total Profit  
  - Average Order Value  
- Visuals:  
  - Line chart (Monthly Sales Trend)  
  - Bar chart (Sales by Region)  
  - KPI Cards  
  - Dynamic slicers  
- Dashboard design optimized for readability and interaction  

---

## 📂 Project Workflow  

### **1. Excel (Initial Cleanup)**  
- Cleaned raw CSVs  
- Standardized date formats  
- Exported final cleaned files for MySQL import  

### **2. MySQL (Core Analysis)**  
- Imported 3 tables: `orders`, `sales`, `products`  
- Executed queries for:  
  - Duplicate checks  
  - Time-series validation  
  - Category mapping  
  - Profitability metrics  
- Created final BI view:  
```sql
vw_sales_orders
```

### **3. Power BI (Dashboard)**  
Connected directly to the SQL view and built visuals for:

- High-level KPIs  
- Regional insights  
- Monthly sales trend  
- Category performance  
- Top customers and products  

---

## 📊 Dashboard Overview  

### **Main Dashboard Page**

This page includes all essential KPIs and visuals stakeholders need:

- **Two slicers:** Region, Category  
- **KPI Cards:** Total Sales, Total Profit  
- **Line Chart:** Monthly Sales Trend  
- **Bar Chart:** Sales by Region  

Screenshots are stored in:  
```
screenshots/dashboard/
```

---

## 🗄️ SQL Output & Validation Screenshots  

Stored inside:  

```
screenshots/sql/
```

Includes:  
- Total Sales  
- Profit  
- AOV  
- Duplicate check  
- Date range validation  
- Monthly trend  
- Category sales  
- View creation confirmation  

These screenshots demonstrate that SQL analysis supports the visuals shown in Power BI.

---

## 🔧 Data Model  

A clear relationship model ensures accurate calculations.  
Screenshot is inside:

```
screenshots/model/model_relationships.png
```

---

## 📁 Repository Structure  

```
Retail-Sales-Project/
│
├── queries.sql
├── README.md
├── dashboard.pbix
├── data/
│   ├── orders.csv
│   ├── sales.csv
│   └── products.csv
│
└── screenshots/
    ├── dashboard/
    ├── model/
    └── sql/
```

---

## 🎯 What This Project Demonstrates  

- Ability to clean and structure raw datasets  
- SQL mastery through joins, grouping, KPI calculations  
- Power BI modeling and DAX  
- Ability to convert data into business insights  
- Understanding of end-to-end BI pipeline  

---

## 👤 Author  
**Jayesh Malik**  
*(Add LinkedIn/GitHub profile link here)*


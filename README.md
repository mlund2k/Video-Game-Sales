# Video-Game-Sales

## Objective

**Goal:** Clean and analyze data to perform an exploratory data analysis on top-selling video game titles.

**Business Prompt:** 
I am part of a business looking to create a new video game. Success is to be based on the success of past video games,
and I am to examine past video game sales to determine what platforms and genres of video games appeal to what region demographic and critics.


## Process

I first downloaded the [Dataset](https://www.kaggle.com/datasets/asaniczka/video-game-sales-2024) through Kaggle, then opened it in Excel for some initial cleaning.

- Raw Data File: [vgames.csv](https://github.com/mlund2k/Video-Game-Sales/blob/main/vgames.csv)

In Excel, I prepped the data for MySQL by converting the necessary data types, and making sure the data was formatted as 'yyyy-mm-dd'. I also removed a column or two that were not necessary to the analysis.

I then moved on to create a database from scratch with the contents of the csv file within MySQL Workbench.

Using SQL, I was able to create a database and schema for the table to be imported, then query the raw data table to create a aggregated table fit for analysis.
A full outlined step by step documentation of the data cleaning process with SQL queries, output, and explanation can be found through [Github](https://github.com/mlund2k/Video-Game-Sales/blob/main/Query.sql)

[Resulting Query Table](https://github.com/mlund2k/Video-Game-Sales/blob/main/query.csv)

Part 2 of the analysis takes place within Power BI building a dashboard and performing further data cleaning. This can be viewed in the following links:
- [Power BI Dashboard](https://github.com/mlund2k/Video-Game-Sales/blob/main/dashboard.pdf) (pdf format)
- [Power BI Project File](https://github.com/mlund2k/Video-Game-Sales/blob/main/proj.pbix) This requires Power BI Desktop to run, alternatively check out the non-interactive preview above.

create table zepto (
sku_id SERIAL PRIMARY KEY,
category VARCHAR(120),
name VARCHAR(150)NOT NULL,
mrp NUMERIC(8,2),
discountpercent NUMERIC(8,2),
availableQuantity INTEGER,
discountedSellingPrice INTEGER,
weightInGms INTEGER,
Outofstock BOOLEAN,
Quantity INTEGER
);
SELECT * FROM Zepto;
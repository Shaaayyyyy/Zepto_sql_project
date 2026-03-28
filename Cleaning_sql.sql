-- Data Exploration
-- Count Of Rows
SELECT COUNT(*) FROM Zepto;
-- Sample Data
SELECT * FROM Zepto
LIMIT 10;
-- Null values
SELECT * FROM Zepto
WHERE name is null
OR
category is null
or
mrp is null
OR
discountpercent is null
OR
availablequantity is null
OR
discountedsellingprice is null
OR
Weightingms is null
OR
Outofstock is null
OR
Quantity is null;
-- Different Product Category
SELECT DISTINCT category
FROM Zepto
ORDER BY Category;
-- Product In stock vs Out of stock
SELECT Outofstock, COUNT (sku_id)
FROM Zepto
GROUP BY Outofstock;
-- product name present multiple times
SELECT name, COUNT(sku_id) as "Number of SKUs"
FROM zepto
GROUP BY name
HAVING count(sku_id) > 1
ORDER BY count(sku_id) DESC;
-- Data Cleaning
-- Products with price = 0
SELECT * FROM Zepto
WHERE mrp =0 OR discountedsellingprice = 0;
DELETE FROM Zepto
WHERE mrp = 0;
-- Convert Paise into Rupees
UPDATE Zepto
SET mrp = mrp/100.0,
discountedsellingprice = discountedsellingprice/100.0;
SELECT mrp,discountedsellingprice FROM zepto;
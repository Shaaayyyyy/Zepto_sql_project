--CUSTOMER VALUE INDEX
SELECT name, category,
ROUND((discountPercent / 100.0) * (weightInGms / discountedSellingPrice),4) AS value_index
FROM zepto
WHERE discountedSellingPrice > 0
ORDER BY value_index DESC
LIMIT 10;
--CATEGORY PERFORMANCE SCORE
SELECT category,

SUM(discountedSellingPrice * availableQuantity) AS revenue,

AVG(discountPercent) AS avg_discount,

COUNT(*) FILTER (WHERE availableQuantity < 20) AS high_demand,

COUNT(*) FILTER (WHERE availableQuantity > 100) AS overstock,

ROUND(
    SUM(discountedSellingPrice * availableQuantity) 
    / NULLIF(COUNT(*),0),2
) AS efficiency_score

FROM zepto
GROUP BY category
ORDER BY efficiency_score DESC;

--PRICE OPTIMIZATION
SELECT name, category,
discountedSellingPrice,

CASE 
    WHEN availableQuantity < 20 THEN discountedSellingPrice * 1.10
    WHEN availableQuantity > 100 THEN discountedSellingPrice * 0.90
    ELSE discountedSellingPrice
END AS suggested_price

FROM zepto;

--INVENTORY TURNOVER
SELECT category,

SUM(availableQuantity) AS total_stock,

COUNT(*) FILTER (WHERE availableQuantity < 20) AS fast_moving,

ROUND(
COUNT(*) FILTER (WHERE availableQuantity < 20) * 100.0 / COUNT(*),2
) AS turnover_rate

FROM zepto
GROUP BY category
ORDER BY turnover_rate DESC;

--PRICE  DETECTION
SELECT name, category, mrp, discountedSellingPrice
FROM zepto
WHERE discountedSellingPrice > mrp;

--DUPLICATE PRODUCT PRICE
SELECT name,
MIN(discountedSellingPrice) AS min_price,
MAX(discountedSellingPrice) AS max_price,
(MAX(discountedSellingPrice) - MIN(discountedSellingPrice)) AS price_diff
FROM zepto
GROUP BY name
HAVING COUNT(*) > 1
ORDER BY price_diff DESC;

--INVENTORY COST
SELECT category,
SUM(mrp * availableQuantity) AS inventory_cost
FROM zepto
GROUP BY category
ORDER BY inventory_cost DESC;

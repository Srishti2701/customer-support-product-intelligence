
USE customer_intelligence;
SELECT * FROM customers LIMIT 5;



USE customer_intelligence;

-- 1. Count customers by city
SELECT City, COUNT(*) AS total_customers
FROM customers
GROUP BY City
ORDER BY total_customers DESC;

-- 2. Top 5 cities by customer count
SELECT City, COUNT(*) AS total_customers
FROM customers
GROUP BY City
ORDER BY total_customers DESC
LIMIT 5;

-- 3. Customers by acquisition channel
SELECT AcquisitionChannel, COUNT(*) AS total_customers
FROM customers
GROUP BY AcquisitionChannel
ORDER BY total_customers DESC;

-- 4. Customers by segment at signup
SELECT CustomerSegmentAtSignup, COUNT(*) AS total_customers
FROM customers
GROUP BY CustomerSegmentAtSignup
ORDER BY total_customers DESC;

-- 5. Orders by status


-- 6. Total revenue by order status
SELECT
    Status,
    ROUND(SUM(OrderValue), 2) AS total_order_value
FROM orders
GROUP BY Status
ORDER BY total_order_value DESC;

-- 7. Revenue by product category
SELECT
    Category,
    ROUND(SUM(OrderValue), 2) AS total_revenue
FROM orders
GROUP BY Category
ORDER BY total_revenue DESC;

-- 8. Quantity sold by category
SELECT
    Category,
    SUM(Quantity) AS units_sold
FROM orders
GROUP BY Category
ORDER BY units_sold DESC;

-- 9. Average order value by status
SELECT
    Status,
    ROUND(AVG(OrderValue), 2) AS average_order_value
FROM orders
GROUP BY Status
ORDER BY average_order_value DESC;

-- 10. Monthly order trends
SELECT
    DATE_FORMAT(STR_TO_DATE(OrderDate, '%Y-%m-%d'), '%Y-%m')
        AS order_month,
    COUNT(*) AS total_orders,
    ROUND(SUM(OrderValue), 2) AS total_order_value
FROM orders
GROUP BY order_month
ORDER BY order_month;




-- 11. Top 10 customers by total order value
SELECT
    CustomerID,
    COUNT(*) AS total_orders,
    ROUND(SUM(OrderValue), 2) AS total_order_value
FROM orders
GROUP BY CustomerID
ORDER BY total_order_value DESC
LIMIT 10;

-- 12. Average order value by city
SELECT
    City,
    ROUND(AVG(OrderValue), 2) AS avg_order_value,
    COUNT(*) AS total_orders
FROM orders
GROUP BY City
ORDER BY avg_order_value DESC;

-- 13. Cancellation rate by city
SELECT
    City,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN Status = 'Cancelled' THEN 1 ELSE 0 END)
        AS cancelled_orders,
    ROUND(
        100.0 * SUM(CASE WHEN Status = 'Cancelled' THEN 1 ELSE 0 END)
        / COUNT(*), 2
    ) AS cancellation_pct
FROM orders
GROUP BY City
ORDER BY cancellation_pct DESC;

-- 14. Revenue by acquisition channel
SELECT
    c.AcquisitionChannel,
    COUNT(o.OrderID) AS total_orders,
    ROUND(SUM(o.OrderValue), 2) AS total_order_value
FROM customers c
JOIN orders o ON c.CustomerID = o.CustomerID
GROUP BY c.AcquisitionChannel
ORDER BY total_order_value DESC;

-- 15. Repeat customers versus one-time customers
SELECT
    CASE
        WHEN order_count = 1 THEN 'One-time customer'
        ELSE 'Repeat customer'
    END AS customer_type,
    COUNT(*) AS customer_count
FROM (
    SELECT CustomerID, COUNT(*) AS order_count
    FROM orders
    GROUP BY CustomerID
) AS customer_orders
GROUP BY customer_type;

-- 16. Monthly cancellation trend


USE customer_intelligence;

-- 17. Customers with the highest number of orders
SELECT
    CustomerID,
    COUNT(*) AS total_orders,
    ROUND(SUM(OrderValue), 2) AS total_order_value
FROM orders
GROUP BY CustomerID
ORDER BY total_orders DESC, total_order_value DESC
LIMIT 10;

-- 18. Feedback volume by issue category
SELECT
    IssueCategory,
    COUNT(*) AS feedback_count
FROM feedback
GROUP BY IssueCategory
ORDER BY feedback_count DESC;

-- 19. Feedback sentiment distribution
SELECT
    Sentiment,
    COUNT(*) AS feedback_count
FROM feedback
GROUP BY Sentiment
ORDER BY feedback_count DESC;

-- 20. Orders and order value by status
SELECT
    Status,
    COUNT(*) AS total_orders,
    ROUND(SUM(OrderValue), 2) AS total_order_value,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM orders), 2)
        AS order_percentage
FROM orders
GROUP BY Status
ORDER BY total_orders DESC;


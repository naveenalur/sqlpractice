-- SQL QUESTIONS FOR AGENTS, CUSTOMER, AND ORDERS TABLES
-- ====================================================

-- BASIC SELECT QUERIES
-- 1. Display all agents
SELECT * FROM agents;

-- 2. Display all customers
SELECT * FROM customer;

-- 3. Display all orders
SELECT * FROM orders;

-- 4. Display only agent names and their working areas
SELECT agent_code, working_area FROM agents;

-- 5. Display customer names and their cities
SELECT cust_name, cust_city FROM customer;

-- WHERE CLAUSE QUERIES
-- 6. Find all agents from Bangalore
SELECT * FROM agents WHERE working_area = 'Bangalore';

-- 7. Find customers with grade 1
SELECT * FROM customer WHERE grade = '1';

-- 8. Find customers from India
SELECT * FROM customer WHERE cust_country = 'India';

-- 9. Find agents with commission greater than 0.13
SELECT * FROM agents WHERE commission > '0.13';

-- 10. Find customers with outstanding amount greater than 10000
SELECT * FROM customer WHERE outstanding_amt > 10000;

-- SORTING AND ORDERING
-- 11. Display all customers ordered by customer name
SELECT * FROM customer ORDER BY cust_name;

-- 12. Display agents ordered by commission in descending order
SELECT * FROM agents ORDER BY commission DESC;

-- 13. Display customers ordered by outstanding amount (highest first)
SELECT * FROM customer ORDER BY outstanding_amt DESC;

-- AGGREGATE FUNCTIONS
-- 14. Count total number of agents
SELECT COUNT(*) as total_agents FROM agents;

-- 15. Count total number of customers
SELECT COUNT(*) as total_customers FROM customer;

-- 16. Find maximum outstanding amount
SELECT MAX(outstanding_amt) as max_outstanding FROM customer;

-- 17. Find minimum outstanding amount
SELECT MIN(outstanding_amt) as min_outstanding FROM customer;

-- 18. Find average outstanding amount
SELECT AVG(outstanding_amt) as avg_outstanding FROM customer;

-- 19. Find sum of all outstanding amounts
SELECT SUM(outstanding_amt) as total_outstanding FROM customer;

-- GROUP BY QUERIES
-- 20. Count customers by country
SELECT cust_country, COUNT(*) as customer_count 
FROM customer 
GROUP BY cust_country;

-- 21. Count customers by grade
SELECT grade, COUNT(*) as customer_count 
FROM customer 
GROUP BY grade;

-- 22. Average outstanding amount by country
SELECT cust_country, AVG(outstanding_amt) as avg_outstanding 
FROM customer 
GROUP BY cust_country;

-- 23. Count agents by working area
SELECT working_area, COUNT(*) as agent_count 
FROM agents 
GROUP BY working_area;

-- HAVING CLAUSE
-- 24. Countries with more than 2 customers
SELECT cust_country, COUNT(*) as customer_count 
FROM customer 
GROUP BY cust_country 
HAVING COUNT(*) > 2;

-- 25. Grades with average outstanding amount greater than 8000
SELECT grade, AVG(outstanding_amt) as avg_outstanding 
FROM customer 
GROUP BY grade 
HAVING AVG(outstanding_amt) > 8000;

-- STRING FUNCTIONS AND PATTERN MATCHING
-- 26. Find customers whose name starts with 'S'
SELECT * FROM customer WHERE cust_name LIKE 'S%';

-- 27. Find customers whose name ends with 'a'
SELECT * FROM customer WHERE cust_name LIKE '%a';

-- 28. Find customers whose name contains 'an'
SELECT * FROM customer WHERE cust_name LIKE '%an%';

-- 29. Find agents with phone numbers starting with '077'
SELECT * FROM agents WHERE phone_no LIKE '077%';

-- INNER JOIN QUERIES
-- 30. Display customer details with their agent information
SELECT c.cust_name, c.cust_city, c.cust_country, a.agent_code, a.working_area, a.commission
FROM customer c
INNER JOIN agents a ON c.agent_code = a.agent_code;

-- 31. Display customer names with their agent names (assuming agent_code contains name)
SELECT c.cust_name, c.cust_city, a.agent_code, a.working_area
FROM customer c
INNER JOIN agents a ON c.agent_code = a.agent_code;

-- 32. Show orders with customer details
SELECT o.ord_num, o.ord_amount, o.ord_date, c.cust_name, c.cust_city
FROM orders o
INNER JOIN customer c ON o.cust_code = c.cust_code;

-- 33. Show orders with both customer and agent details
SELECT o.ord_num, o.ord_amount, c.cust_name, a.agent_code, a.working_area
FROM orders o
INNER JOIN customer c ON o.cust_code = c.cust_code
INNER JOIN agents a ON o.agent_code = a.agent_code;

-- LEFT JOIN QUERIES
-- 34. Display all agents and their customers (if any)
SELECT a.agent_code, a.working_area, c.cust_name, c.cust_city
FROM agents a
LEFT JOIN customer c ON a.agent_code = c.agent_code;

-- 35. Display all customers and their orders (if any)
SELECT c.cust_name, c.cust_city, o.ord_num, o.ord_amount
FROM customer c
LEFT JOIN orders o ON c.cust_code = o.cust_code;

-- RIGHT JOIN QUERIES
-- 36. Display all customers and their agents
SELECT c.cust_name, c.cust_city, a.agent_code, a.working_area
FROM customer c
RIGHT JOIN agents a ON c.agent_code = a.agent_code;

-- SUBQUERY EXAMPLES
-- 37. Find customers with outstanding amount greater than average
SELECT * FROM customer 
WHERE outstanding_amt > (SELECT AVG(outstanding_amt) FROM customer);

-- 38. Find agents who have customers
SELECT * FROM agents 
WHERE agent_code IN (SELECT DISTINCT agent_code FROM customer);

-- 39. Find customers from the same country as customer 'Holmes'
SELECT * FROM customer 
WHERE cust_country = (SELECT cust_country FROM customer WHERE cust_name = 'Holmes');

-- 40. Find the customer with maximum outstanding amount
SELECT * FROM customer 
WHERE outstanding_amt = (SELECT MAX(outstanding_amt) FROM customer);

-- CORRELATED SUBQUERY
-- 41. Find customers whose outstanding amount is above average for their country
SELECT c1.* FROM customer c1
WHERE c1.outstanding_amt > (
    SELECT AVG(c2.outstanding_amt) 
    FROM customer c2 
    WHERE c2.cust_country = c1.cust_country
);

-- EXISTS QUERIES
-- 42. Find agents who have at least one customer
SELECT * FROM agents a
WHERE EXISTS (SELECT 1 FROM customer c WHERE c.agent_code = a.agent_code);

-- 43. Find customers who have placed orders
SELECT * FROM customer c
WHERE EXISTS (SELECT 1 FROM orders o WHERE o.cust_code = c.cust_code);

-- UNION QUERIES
-- 44. Combine all working areas of agents and customer cities
SELECT working_area as location FROM agents
UNION
SELECT cust_city as location FROM customer;

-- 45. Combine agent codes and customer codes
SELECT agent_code as code, 'Agent' as type FROM agents
UNION
SELECT cust_code as code, 'Customer' as type FROM customer;

-- CASE STATEMENTS
-- 46. Categorize customers by outstanding amount
SELECT cust_name, outstanding_amt,
    CASE 
        WHEN outstanding_amt > 10000 THEN 'High'
        WHEN outstanding_amt > 5000 THEN 'Medium'
        ELSE 'Low'
    END as outstanding_category
FROM customer;

-- 47. Categorize agents by commission
SELECT agent_code, commission,
    CASE 
        WHEN commission >= '0.15' THEN 'High Commission'
        WHEN commission >= '0.12' THEN 'Medium Commission'
        ELSE 'Low Commission'
    END as commission_category
FROM agents;

-- ADVANCED JOIN QUERIES
-- 48. Find total business (sum of outstanding amounts) handled by each agent
SELECT a.agent_code, a.working_area, SUM(c.outstanding_amt) as total_business
FROM agents a
LEFT JOIN customer c ON a.agent_code = c.agent_code
GROUP BY a.agent_code, a.working_area
ORDER BY total_business DESC;

-- 49. Find customers and their agents in the same city/area
SELECT c.cust_name, c.cust_city, a.agent_code, a.working_area
FROM customer c
INNER JOIN agents a ON c.agent_code = a.agent_code
WHERE c.cust_city = a.working_area;

-- 50. Complex query: Find top 3 agents by total customer outstanding amounts
SELECT a.agent_code, a.working_area, 
       COUNT(c.cust_code) as customer_count,
       SUM(c.outstanding_amt) as total_outstanding
FROM agents a
LEFT JOIN customer c ON a.agent_code = c.agent_code
GROUP BY a.agent_code, a.working_area
ORDER BY total_outstanding DESC
LIMIT 3;

-- WINDOW FUNCTIONS (if supported by your database)
-- 51. Rank customers by outstanding amount within their country
SELECT cust_name, cust_country, outstanding_amt,
       RANK() OVER (PARTITION BY cust_country ORDER BY outstanding_amt DESC) as country_rank
FROM customer;

-- 52. Running total of outstanding amounts
SELECT cust_name, outstanding_amt,
       SUM(outstanding_amt) OVER (ORDER BY cust_name) as running_total
FROM customer;

-- DATE QUERIES (for orders table when populated)
-- 53. Orders from current year (modify date as needed)
-- SELECT * FROM orders WHERE YEAR(ord_date) = YEAR(CURDATE());

-- 54. Orders from last 30 days
-- SELECT * FROM orders WHERE ord_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);

-- COMPLEX MULTI-TABLE QUERIES
-- 55. Customer summary with agent and order information
SELECT 
    c.cust_name,
    c.cust_country,
    c.outstanding_amt,
    a.agent_code,
    a.working_area,
    a.commission,
    COUNT(o.ord_num) as order_count,
    COALESCE(SUM(o.ord_amount), 0) as total_order_value
FROM customer c
LEFT JOIN agents a ON c.agent_code = a.agent_code
LEFT JOIN orders o ON c.cust_code = o.cust_code
GROUP BY c.cust_code, c.cust_name, c.cust_country, c.outstanding_amt, 
         a.agent_code, a.working_area, a.commission;

-- DATA MODIFICATION QUERIES
-- 56. Update commission for agents in Bangalore
-- UPDATE agents SET commission = '0.16' WHERE working_area = 'Bangalore';

-- 57. Delete customers with grade 0
-- DELETE FROM customer WHERE grade = '0';

-- 58. Insert a new agent
-- INSERT INTO agents VALUES ('A013', 'Mumbai', '0.14', '022-12345678', 'India');

-- CONSTRAINT AND DATA INTEGRITY QUERIES
-- 59. Find customers without valid agent codes
SELECT * FROM customer c
WHERE c.agent_code NOT IN (SELECT agent_code FROM agents);

-- 60. Find orphaned records (customers without agents)
SELECT c.* FROM customer c
LEFT JOIN agents a ON c.agent_code = a.agent_code
WHERE a.agent_code IS NULL;

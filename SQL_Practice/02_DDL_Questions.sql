-- ===============================================
-- DDL (DATA DEFINITION LANGUAGE) QUESTIONS
-- ===============================================

-- BASIC DDL QUESTIONS
-- ===================

-- Question 1: Create a new table called 'Reviews'
-- Create a new table called 'Reviews' with the following columns:
-- - ReviewID (Primary Key, Auto-increment)
-- - ProductID (Foreign Key to Products table)
-- - CustomerID (Foreign Key to Customers table)
-- - Rating (Integer between 1-5)
-- - Comment (Text up to 500 characters)
-- - ReviewDate (DateTime with default current date)

-- Question 2: Add new column to Suppliers
-- Add a new column 'IsActive' (bit type with default value 1) to the Suppliers table.

-- Question 3: Create index
-- Create an index on the 'Email' column of the Customers table for faster lookups.

-- Question 4: Add check constraint
-- Add a check constraint to ensure that 'Rating' in Reviews table is between 1 and 5.

-- Question 5: Modify column
-- Modify the 'Phone' column in the Customers table to allow up to 15 characters instead of 20.

-- INTERMEDIATE DDL QUESTIONS
-- ===========================

-- Question 6: Create view
-- Create a view called 'ProductSummary' that shows ProductName, CategoryName, 
-- CompanyName (supplier), and UnitPrice.

-- Question 7: Add computed column
-- Add a computed column 'FullName' to the Customers table that concatenates 
-- FirstName and LastName.

-- Question 8: Create stored procedure
-- Create a stored procedure that adds a new product with input parameters 
-- for all required fields.

-- Question 9: Drop and recreate constraint
-- Drop the constraint 'CHK_UnitPrice' from the Products table and recreate it 
-- to allow prices between 0 and 10000.

-- Question 10: Create backup table
-- Create a backup table called 'Products_Backup' with the same structure as Products table.

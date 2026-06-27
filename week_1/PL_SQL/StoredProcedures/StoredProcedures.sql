-- ==========================================================
-- Exercise 3: Stored Procedures
-- Name: StoredProcedures.sql
-- Objective:
-- Implement Oracle PL/SQL stored procedures for banking operations.
-- ==========================================================

SET SERVEROUTPUT ON;

-- ==========================================================
-- TABLE CREATION
-- ==========================================================

-- Customers Table
CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    Age NUMBER,
    Balance NUMBER(10,2),
    IsVIP VARCHAR2(5)
);

-- Accounts Table
CREATE TABLE Accounts (
    AccountID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    AccountType VARCHAR2(20),
    Balance NUMBER(10,2),
    CONSTRAINT fk_customer
        FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
);

-- Employees Table
CREATE TABLE Employees (
    EmployeeID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    Department VARCHAR2(50),
    Salary NUMBER(10,2),
    PerformanceRating NUMBER
);

-- ==========================================================
-- INSERT SAMPLE DATA
-- ==========================================================

-- Customers
INSERT INTO Customers VALUES (1, 'Rahul Sharma', 35, 50000, 'No');
INSERT INTO Customers VALUES (2, 'Priya Singh', 42, 75000, 'Yes');
INSERT INTO Customers VALUES (3, 'Amit Kumar', 28, 30000, 'No');
INSERT INTO Customers VALUES (4, 'Sneha Reddy', 55, 90000, 'Yes');

-- Accounts
INSERT INTO Accounts VALUES (101, 1, 'Savings', 10000);
INSERT INTO Accounts VALUES (102, 2, 'Savings', 20000);
INSERT INTO Accounts VALUES (103, 3, 'Current', 15000);
INSERT INTO Accounts VALUES (104, 4, 'Savings', 5000);

-- Employees
INSERT INTO Employees VALUES (1, 'Ramesh', 'IT', 50000, 5);
INSERT INTO Employees VALUES (2, 'Suresh', 'HR', 45000, 4);
INSERT INTO Employees VALUES (3, 'Anita', 'IT', 60000, 5);
INSERT INTO Employees VALUES (4, 'Priya', 'Finance', 55000, 4);
INSERT INTO Employees VALUES (5, 'Karan', 'IT', 70000, 5);

COMMIT;

-- ==========================================================
-- SCENARIO 1
-- ProcessMonthlyInterest
-- Applies 1% interest to all Savings accounts.
-- ==========================================================

CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest
IS
BEGIN
    UPDATE Accounts
    SET Balance = Balance + (Balance * 0.01)
    WHERE AccountType = 'Savings';

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Monthly interest processed successfully.');
END;
/

-- Execute Procedure
BEGIN
    ProcessMonthlyInterest;
END;
/

-- Verify Result
SELECT * FROM Accounts;

-- ==========================================================
-- SCENARIO 2
-- UpdateEmployeeBonus
-- Updates employee salaries for a specified department
-- using the bonus percentage passed as a parameter.
-- ==========================================================

CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus
(
    p_department IN VARCHAR2,
    p_bonus IN NUMBER
)
IS
BEGIN
    UPDATE Employees
    SET Salary = Salary + (Salary * p_bonus / 100)
    WHERE Department = p_department;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Employee bonus updated successfully.');
END;
/

-- Execute Procedure
BEGIN
    UpdateEmployeeBonus('IT', 10);
END;
/

-- Verify Result
SELECT * FROM Employees;

-- ==========================================================
-- SCENARIO 3
-- TransferFunds
-- Transfers funds from one account to another after
-- verifying sufficient balance.
-- ==========================================================

CREATE OR REPLACE PROCEDURE TransferFunds
(
    p_fromAccount IN NUMBER,
    p_toAccount   IN NUMBER,
    p_amount      IN NUMBER
)
IS
    v_balance NUMBER;
BEGIN
    SELECT Balance
    INTO v_balance
    FROM Accounts
    WHERE AccountID = p_fromAccount;

    IF v_balance >= p_amount THEN

        UPDATE Accounts
        SET Balance = Balance - p_amount
        WHERE AccountID = p_fromAccount;

        UPDATE Accounts
        SET Balance = Balance + p_amount
        WHERE AccountID = p_toAccount;

        COMMIT;

        DBMS_OUTPUT.PUT_LINE('Transfer Successful.');

    ELSE
        DBMS_OUTPUT.PUT_LINE('Insufficient Balance.');
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Account not found.');
END;
/

-- Execute Procedure
BEGIN
    TransferFunds(101, 102, 500);
END;
/

-- Verify Result
SELECT * FROM Accounts;
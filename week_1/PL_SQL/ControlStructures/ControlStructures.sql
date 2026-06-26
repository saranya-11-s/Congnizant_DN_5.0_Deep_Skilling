CREATE TABLE Customers
(
    CustomerID NUMBER PRIMARY KEY,
    Name       VARCHAR2(100),
    Age        NUMBER,
    Balance    NUMBER(12,2),
    IsVIP      VARCHAR2(5)
);

CREATE TABLE Loans
(
    LoanID NUMBER PRIMARY KEY,

    CustomerID NUMBER,

    InterestRate NUMBER(5,2),

    DueDate DATE,

    CONSTRAINT fk_customer
    FOREIGN KEY(CustomerID)
    REFERENCES Customers(CustomerID)
);


/**********************************************************************
                    INSERT SAMPLE DATA
**********************************************************************/

INSERT INTO Customers VALUES
(101,'Rahul',65,12000,'FALSE');

INSERT INTO Customers VALUES
(102,'Priya',45,8000,'FALSE');

INSERT INTO Customers VALUES
(103,'Amit',72,18000,'FALSE');

INSERT INTO Customers VALUES
(104,'Sneha',29,4000,'FALSE');

INSERT INTO Customers VALUES
(105,'Kiran',61,9500,'FALSE');


INSERT INTO Loans VALUES
(1,101,8.50,SYSDATE+15);

INSERT INTO Loans VALUES
(2,102,9.00,SYSDATE+40);

INSERT INTO Loans VALUES
(3,103,10.00,SYSDATE+20);

INSERT INTO Loans VALUES
(4,104,7.50,SYSDATE+90);

INSERT INTO Loans VALUES
(5,105,8.80,SYSDATE+10);

COMMIT;


/**********************************************************************
                    ENABLE DBMS OUTPUT
**********************************************************************/

SET SERVEROUTPUT ON;


/**********************************************************************
                    SCENARIO 1
Apply 1% Discount to Customers Above 60 Years
**********************************************************************/

BEGIN

    FOR customer_rec IN
    (
        SELECT CustomerID,
               Age
        FROM Customers
    )

    LOOP

        IF customer_rec.Age > 60 THEN

            UPDATE Loans
            SET InterestRate = InterestRate - 1
            WHERE CustomerID = customer_rec.CustomerID;

            DBMS_OUTPUT.PUT_LINE(
                '1% Discount Applied Successfully for Customer ID : '
                || customer_rec.CustomerID
            );

        END IF;

    END LOOP;

    COMMIT;

END;
/

// ===== Scenario 1 Verification =====

SELECT LoanID,
       CustomerID,
       InterestRate
FROM Loans
ORDER BY LoanID;


/**********************************************************************
                    SCENARIO 2 Customers to VIP
**********************************************************************/

BEGIN

    FOR customer_rec IN
    (
        SELECT CustomerID,
               Balance
        FROM Customers
    )

    LOOP

        IF customer_rec.Balance > 10000 THEN

            UPDATE Customers
            SET IsVIP='TRUE'
            WHERE CustomerID=customer_rec.CustomerID;

            DBMS_OUTPUT.PUT_LINE(
                'Customer ID '
                || customer_rec.CustomerID
                || ' Promoted to VIP.'
            );

        END IF;

    END LOOP;

    COMMIT;

END;
/

// ===== Scenario 2 Verification =====

SELECT CustomerID,
       Name,
       Balance,
       IsVIP
FROM Customers
ORDER BY CustomerID;


/**********************************************************************
                    SCENARIO 3 Loan Due Reminder
**********************************************************************/

BEGIN

    FOR loan_rec IN
    (
        SELECT

            c.CustomerID,
            c.Name,
            l.LoanID,
            l.DueDate

        FROM Customers c

        INNER JOIN Loans l

        ON c.CustomerID=l.CustomerID

        WHERE l.DueDate
        BETWEEN SYSDATE
        AND SYSDATE+30

        ORDER BY l.DueDate

    )

    LOOP

        DBMS_OUTPUT.PUT_LINE(

            'Reminder: Dear '

            || loan_rec.Name

            || ' (Customer ID : '

            || loan_rec.CustomerID

            || ') Your Loan ID '

            || loan_rec.LoanID

            || ' is due on '

            || TO_CHAR(loan_rec.DueDate,'DD-MON-YYYY')

        );

    END LOOP;

END;
/

//===== Scenario 3 Verification =====

SELECT
    l.LoanID,
    c.CustomerID,
    c.Name,
    l.DueDate
FROM Customers c
INNER JOIN Loans l
ON c.CustomerID=l.CustomerID
WHERE l.DueDate
BETWEEN SYSDATE
AND SYSDATE+30
ORDER BY l.DueDate;


/**********************************************************************
                    FINAL DATABASE VERIFICATION
**********************************************************************/

//===== Customers Table =====

SELECT *
FROM Customers
ORDER BY CustomerID;


// ===== Loans Table =====

SELECT *
FROM Loans
ORDER BY LoanID;
--1
CREATE TABLE #MonthlySales (
    ProductID INT,
    TotalQuantity INT,
    TotalRevenue DECIMAL(18, 2)
);
INSERT INTO #MonthlySales (ProductID, TotalQuantity, TotalRevenue)
SELECT 
    ProductID,
    SUM(Quantity) AS TotalQuantity,
    SUM(Quantity * Quantity) AS TotalRevenue
FROM 
    Sales
WHERE 
    MONTH(SaleDate) = MONTH(GETDATE())
    AND YEAR(SaleDate) = YEAR(GETDATE())
GROUP BY 
    ProductID;
SELECT * FROM #MonthlySales;

--2
CREATE VIEW vw_ProductSalesSummary AS
SELECT 
    p.ProductID,
    p.ProductName,
    p.Category,
    SUM(s.Quantity) AS TotalQuantitySold
FROM 
    Products p
JOIN 
    Sales s ON p.ProductID = s.ProductID
GROUP BY 
    p.ProductID, p.ProductName, p.Category;


--3
CREATE FUNCTION fn_GetTotalRevenueForProduct (@ProductID INT)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @TotalRevenue DECIMAL(18, 2);

    SELECT @TotalRevenue = SUM(Quantity * Quantity)
    FROM Sales
    WHERE ProductID = @ProductID;

    RETURN ISNULL(@TotalRevenue, 0);
END;

--4
CREATE FUNCTION fn_GetSalesByCategory (@Category VARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT 
        p.ProductName,
        SUM(s.Quantity) AS TotalQuantity,
        SUM(s.Quantity * s.Quantity) AS TotalRevenue
    FROM 
        Products p
    JOIN 
        Sales s ON p.ProductID = s.ProductID
    WHERE 
        p.Category = @Category
    GROUP BY 
        p.ProductName
);

--5
CREATE FUNCTION dbo.fn_IsPrime (@Number INT)
RETURNS VARCHAR(3)
AS
BEGIN
    DECLARE @i INT = 2;
    DECLARE @IsPrime BIT = 1;

    IF @Number <= 1
        RETURN 'No';

    IF @Number = 2
        RETURN 'Yes';

    WHILE @i <= SQRT(@Number)
    BEGIN
        IF @Number % @i = 0
        BEGIN
            SET @IsPrime = 0;
            BREAK;
        END
        SET @i = @i + 1;
    END

    IF @IsPrime = 1
        RETURN 'Yes';
    ELSE
        RETURN 'No';
END;

--6
CREATE FUNCTION fn_GetNumbersBetween (@Start INT, @End INT)
RETURNS @Numbers TABLE (Number INT)
AS
BEGIN
    DECLARE @Current INT = @Start;

    WHILE @Current <= @End
    BEGIN
        INSERT INTO @Numbers (Number)
        VALUES (@Current);

        SET @Current = @Current + 1;
    END

    RETURN;
END;


--7
CREATE FUNCTION getNthHighestSalary (@N INT)
RETURNS TABLE
AS
RETURN (
    SELECT MIN(salary) AS HighestNSalary
    FROM (
        SELECT DISTINCT salary
        FROM Employee
        ORDER BY salary DESC
        OFFSET 0 ROWS FETCH NEXT @N ROWS ONLY
    ) AS TopSalaries
);


--8
SELECT TOP 1 id, COUNT(*) AS num
FROM (
    SELECT requester_id AS id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS id FROM RequestAccepted
) AS AllFriends
GROUP BY id
ORDER BY num DESC;


--9
CREATE VIEW vw_CustomerOrderSummary AS
SELECT
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS total_orders,
    ISNULL(SUM(o.amount), 0) AS total_amount,
    MAX(o.order_date) AS last_order_date
FROM
    Customers c
LEFT JOIN
    Orders o ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.name;

--10
SELECT 
    RowNumber,
    MAX(Workflow) OVER (
        ORDER BY RowNumber
        ROWS UNBOUNDED PRECEDING
    ) AS Workflow
FROM Gaps
ORDER BY RowNumber;


select * from sales

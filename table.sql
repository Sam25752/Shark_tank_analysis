use SharkTank

if object_id ('STA' , 'U') is not null
	drop table STA;


CREATE TABLE dbo.SharkTankPitches (
    [Season Number] INT,
    [Startup Name] VARCHAR(100),
    [Episode Number] INT,
    [Pitch Number] INT,
    [Season Start] DATE,
    [Season End] DATE,
    [Original Air Date] DATE,
    [Episode Title] VARCHAR(255),
    [Anchor] VARCHAR(100),
    [Industry] VARCHAR(100),
    [Business Description] VARCHAR(MAX),
    [Company Website] VARCHAR(255),
    [Started in] INT,
    [Number of Presenters] INT,
    [Male Presenters] INT,
    [Female Presenters] INT,
    [Transgender Presenters] INT,
    [Couple Presenters] INT,
    [Pitchers Average Age] VARCHAR(50),
    [Pitchers City] VARCHAR(100),
    [Pitchers State] VARCHAR(100),
    [Yearly Revenue] INT,
    [Monthly Sales] FLOAT,
    [Gross Margin] INT,
    [Net Margin] INT,
    [EBITDA] FLOAT,
    [Cash Burn] VARCHAR(50),
    [SKUs] INT,
    [Has Patents] VARCHAR(10),
    [Bootstrapped] VARCHAR(10),
    [Part of Match off] VARCHAR(10),
    [Original Ask Amount] DECIMAL(18, 2),
    [Original Offered Equity] DECIMAL(18, 2),
    [Valuation Requested] DECIMAL(18, 2),
    [Received Offer] INT,
    [Accepted Offer] INT,
    [Total Deal Amount] DECIMAL(18, 2),
    [Total Deal Equity] DECIMAL(18, 2),
    [Total Deal Debt] DECIMAL(18, 2),
    [Debt Interest] DECIMAL(18, 2),
    [Deal Valuation] FLOAT,
    [Number of Sharks in Deal] INT,
    [Deal Has Conditions] VARCHAR(10),
    [Royalty Percentage] FLOAT,
    [Royalty Recouped Amount] FLOAT,
    [Advisory Shares Equity] DECIMAL(18, 2),
    [Namita Investment Amount] DECIMAL(18, 2),
    [Namita Investment Equity] DECIMAL(18, 2),
    [Namita Debt Amount] DECIMAL(18, 2),
    [Vineeta Investment Amount] DECIMAL(18, 2),
    [Vineeta Investment Equity] DECIMAL(18, 2),
    [Vineeta Debt Amount] DECIMAL(18, 2),
    [Anupam Investment Amount] DECIMAL(18, 2),
    [Anupam Investment Equity] DECIMAL(18, 2),
    [Anupam Debt Amount] DECIMAL(18, 2),
    [Aman Investment Amount] DECIMAL(18, 2),
    [Aman Investment Equity] DECIMAL(18, 2),
    [Aman Debt Amount] DECIMAL(18, 2),
    [Peyush Investment Amount] DECIMAL(18, 2),
    [Peyush Investment Equity] DECIMAL(18, 2),
    [Peyush Debt Amount] DECIMAL(18, 2),
    [Ritesh Investment Amount] DECIMAL(18, 2),
    [Ritesh Investment Equity] DECIMAL(18, 2),
    [Ritesh Debt Amount] DECIMAL(18, 2),
    [Amit Investment Amount] DECIMAL(18, 2),
    [Amit Investment Equity] DECIMAL(18, 2),
    [Amit Debt Amount] DECIMAL(18, 2),
    [Guest Investment Amount] DECIMAL(18, 2),
    [Guest Investment Equity] DECIMAL(18, 2),
    [Guest Debt Amount] DECIMAL(18, 2),
    [Invested Guest Name] VARCHAR(100),
    [All Guest Names] VARCHAR(255),
    [Namita Present] INT,
    [Vineeta Present] INT,
    [Anupam Present] INT,
    [Aman Present] INT,
    [Peyush Present] INT,
    [Ritesh Present] INT,
    [Amit Present] INT,
    [Guest Present] INT
);
GO


BULK INSERT dbo.SharkTankPitches
FROM "C:\Users\DELL\OneDrive\Desktop\shark tank analysis\Shark Tank India.csv"
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,           -- Skips the column header row
    FIELDTERMINATOR = ',',  -- CSV column separator
    ROWTERMINATOR = '\n',   -- Line break
    TABLOCK
);
GO
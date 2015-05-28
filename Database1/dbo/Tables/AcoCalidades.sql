CREATE TABLE [dbo].[AcoCalidades] (
    [IdAcoCalidad] INT IDENTITY (1, 1) NOT NULL,
    [IdRubro]      INT NULL,
    [IdSubRubro]   INT NULL,
    CONSTRAINT [PK_AcoCalidades] PRIMARY KEY CLUSTERED ([IdAcoCalidad] ASC) WITH (FILLFACTOR = 90)
);


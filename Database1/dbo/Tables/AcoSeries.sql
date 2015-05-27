CREATE TABLE [dbo].[AcoSeries] (
    [IdAcoSerie] INT IDENTITY (1, 1) NOT NULL,
    [IdRubro]    INT NULL,
    [IdSubrubro] INT NULL,
    CONSTRAINT [PK_AcoSeries] PRIMARY KEY CLUSTERED ([IdAcoSerie] ASC) WITH (FILLFACTOR = 90)
);


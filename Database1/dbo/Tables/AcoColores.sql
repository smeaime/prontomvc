CREATE TABLE [dbo].[AcoColores] (
    [IdAcoColor] INT IDENTITY (1, 1) NOT NULL,
    [IdRubro]    INT NULL,
    [IdSubrubro] INT NULL,
    CONSTRAINT [PK_AcoColores] PRIMARY KEY CLUSTERED ([IdAcoColor] ASC) WITH (FILLFACTOR = 90)
);


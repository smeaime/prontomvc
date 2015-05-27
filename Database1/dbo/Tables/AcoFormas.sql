CREATE TABLE [dbo].[AcoFormas] (
    [IdAcoForma] INT IDENTITY (1, 1) NOT NULL,
    [IdRubro]    INT NULL,
    [IdSubrubro] INT NULL,
    CONSTRAINT [PK_AcoFormas] PRIMARY KEY CLUSTERED ([IdAcoForma] ASC) WITH (FILLFACTOR = 90)
);


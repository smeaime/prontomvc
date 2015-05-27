CREATE TABLE [dbo].[AcoModelos] (
    [IdAcoModelo] INT IDENTITY (1, 1) NOT NULL,
    [IdRubro]     INT NULL,
    [IdSubrubro]  INT NULL,
    CONSTRAINT [PK_AcoModelos] PRIMARY KEY CLUSTERED ([IdAcoModelo] ASC) WITH (FILLFACTOR = 90)
);


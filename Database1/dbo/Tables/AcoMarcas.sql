CREATE TABLE [dbo].[AcoMarcas] (
    [IdAcoMarca] INT IDENTITY (1, 1) NOT NULL,
    [IdRubro]    INT NULL,
    [IdSubrubro] INT NULL,
    CONSTRAINT [PK_AcoMarcas] PRIMARY KEY CLUSTERED ([IdAcoMarca] ASC) WITH (FILLFACTOR = 90)
);


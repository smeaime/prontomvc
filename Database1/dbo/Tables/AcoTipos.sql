CREATE TABLE [dbo].[AcoTipos] (
    [IdAcoTipo]  INT IDENTITY (1, 1) NOT NULL,
    [IdRubro]    INT NULL,
    [IdSubrubro] INT NULL,
    CONSTRAINT [PK_AcoTipos] PRIMARY KEY CLUSTERED ([IdAcoTipo] ASC) WITH (FILLFACTOR = 90)
);


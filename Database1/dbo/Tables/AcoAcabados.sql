CREATE TABLE [dbo].[AcoAcabados] (
    [IdAcoAcabado] INT IDENTITY (1, 1) NOT NULL,
    [IdRubro]      INT NULL,
    [IdSubrubro]   INT NULL,
    CONSTRAINT [PK_AcoAcabados] PRIMARY KEY CLUSTERED ([IdAcoAcabado] ASC) WITH (FILLFACTOR = 90)
);


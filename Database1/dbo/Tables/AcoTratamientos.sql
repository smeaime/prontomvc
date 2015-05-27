CREATE TABLE [dbo].[AcoTratamientos] (
    [IdAcoTratamiento] INT IDENTITY (1, 1) NOT NULL,
    [IdRubro]          INT NULL,
    [IdSubrubro]       INT NULL,
    CONSTRAINT [PK_AcoTratamientos] PRIMARY KEY CLUSTERED ([IdAcoTratamiento] ASC) WITH (FILLFACTOR = 90)
);


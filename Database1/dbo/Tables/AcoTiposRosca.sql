CREATE TABLE [dbo].[AcoTiposRosca] (
    [IdAcoTipoRosca] INT IDENTITY (1, 1) NOT NULL,
    [IdRubro]        INT NULL,
    [IdSubrubro]     INT NULL,
    CONSTRAINT [PK_AcoTiposRosca] PRIMARY KEY CLUSTERED ([IdAcoTipoRosca] ASC) WITH (FILLFACTOR = 90)
);


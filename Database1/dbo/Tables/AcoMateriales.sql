CREATE TABLE [dbo].[AcoMateriales] (
    [IdAcoMaterial] INT IDENTITY (1, 1) NOT NULL,
    [IdRubro]       INT NULL,
    [IdSubRubro]    INT NULL,
    CONSTRAINT [PK_AcoMateriales] PRIMARY KEY CLUSTERED ([IdAcoMaterial] ASC) WITH (FILLFACTOR = 90)
);


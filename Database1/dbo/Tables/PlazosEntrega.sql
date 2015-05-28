CREATE TABLE [dbo].[PlazosEntrega] (
    [IdPlazoEntrega] INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion]    VARCHAR (50) NULL,
    [Detalle]        NTEXT        NULL,
    CONSTRAINT [PK_PlazosEntrega] PRIMARY KEY CLUSTERED ([IdPlazoEntrega] ASC) WITH (FILLFACTOR = 90)
);


CREATE TABLE [dbo].[Regiones] (
    [IdRegion]    INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion] VARCHAR (50) NULL,
    [Codigo]      INT          NULL,
    CONSTRAINT [PK_Regiones] PRIMARY KEY CLUSTERED ([IdRegion] ASC) WITH (FILLFACTOR = 90)
);


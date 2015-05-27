CREATE TABLE [dbo].[DetalleAcoMateriales] (
    [IdDetalleAcoMaterial] INT         IDENTITY (1, 1) NOT NULL,
    [IdAcoMaterial]        INT         NULL,
    [IdMaterial]           INT         NULL,
    [Marca]                VARCHAR (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_DetalleAcoMateriales] PRIMARY KEY CLUSTERED ([IdDetalleAcoMaterial] ASC) WITH (FILLFACTOR = 90)
);


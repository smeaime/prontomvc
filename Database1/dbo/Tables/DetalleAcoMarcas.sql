CREATE TABLE [dbo].[DetalleAcoMarcas] (
    [IdDetalleAcoMarca] INT         IDENTITY (1, 1) NOT NULL,
    [IdAcoMarca]        INT         NULL,
    [IdMarca]           INT         NULL,
    [Marca]             VARCHAR (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_DetalleAcoMarcas] PRIMARY KEY CLUSTERED ([IdDetalleAcoMarca] ASC) WITH (FILLFACTOR = 90)
);


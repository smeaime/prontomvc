CREATE TABLE [dbo].[DetalleObrasSectores] (
    [IdDetalleObraSector] INT          IDENTITY (1, 1) NOT NULL,
    [IdObra]              INT          NULL,
    [Descripcion]         VARCHAR (50) NULL,
    CONSTRAINT [PK_DetalleObrasSectores] PRIMARY KEY CLUSTERED ([IdDetalleObraSector] ASC) WITH (FILLFACTOR = 90)
);


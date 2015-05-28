CREATE TABLE [dbo].[DetalleArticulosDocumentos] (
    [IdDetalleArticuloDocumentos] INT           IDENTITY (1, 1) NOT NULL,
    [IdArticulo]                  INT           NULL,
    [PathDocumento]               VARCHAR (200) NULL,
    CONSTRAINT [PK_DetalleArticulosDocumentos] PRIMARY KEY CLUSTERED ([IdDetalleArticuloDocumentos] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleArticulosDocumentos_Articulos] FOREIGN KEY ([IdArticulo]) REFERENCES [dbo].[Articulos] ([IdArticulo])
);


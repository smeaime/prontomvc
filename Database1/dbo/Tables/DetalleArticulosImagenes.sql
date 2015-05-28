CREATE TABLE [dbo].[DetalleArticulosImagenes] (
    [IdDetalleArticuloImagenes] INT           IDENTITY (1, 1) NOT NULL,
    [IdArticulo]                INT           NULL,
    [PathImagen]                VARCHAR (200) NULL,
    CONSTRAINT [PK_DetalleArticulosImagenes] PRIMARY KEY CLUSTERED ([IdDetalleArticuloImagenes] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleArticulosImagenes_Articulos] FOREIGN KEY ([IdArticulo]) REFERENCES [dbo].[Articulos] ([IdArticulo])
);


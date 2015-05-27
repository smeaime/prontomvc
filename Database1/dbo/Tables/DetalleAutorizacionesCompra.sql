CREATE TABLE [dbo].[DetalleAutorizacionesCompra] (
    [IdDetalleAutorizacionCompra] INT             IDENTITY (1, 1) NOT NULL,
    [IdAutorizacionCompra]        INT             NULL,
    [IdArticulo]                  INT             NULL,
    [Cantidad]                    NUMERIC (18, 2) NULL,
    [IdUnidad]                    INT             NULL,
    [Observaciones]               NTEXT           NULL,
    CONSTRAINT [PK_DetalleAutorizacionesCompra] PRIMARY KEY CLUSTERED ([IdDetalleAutorizacionCompra] ASC) WITH (FILLFACTOR = 90)
);


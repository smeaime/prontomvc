CREATE TABLE [dbo].[DetalleFacturasClientesPRESTO] (
    [IdDetalleFacturaClientePRESTO] INT             IDENTITY (1, 1) NOT NULL,
    [IdFacturaClientePRESTO]        INT             NULL,
    [IdArticulo]                    INT             NULL,
    [Cantidad]                      NUMERIC (18, 2) NULL,
    [Importe]                       NUMERIC (18, 2) NULL,
    [Observaciones]                 NTEXT           NULL,
    CONSTRAINT [PK_DetalleFacturasClientesPRESTO] PRIMARY KEY CLUSTERED ([IdDetalleFacturaClientePRESTO] ASC) WITH (FILLFACTOR = 90)
);


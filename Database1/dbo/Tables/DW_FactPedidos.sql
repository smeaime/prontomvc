CREATE TABLE [dbo].[DW_FactPedidos] (
    [IdDetallePedido]        INT             NOT NULL,
    [NumeroPedido]           VARCHAR (20)    NULL,
    [IdProveedor]            INT             NULL,
    [FechaPedido]            INT             NULL,
    [IdComprador]            INT             NULL,
    [Moneda]                 VARCHAR (15)    NULL,
    [NumeroItem]             INT             NULL,
    [IdArticulo]             INT             NULL,
    [Cantidad]               NUMERIC (18, 2) NULL,
    [Unidad]                 VARCHAR (15)    NULL,
    [PrecioUnitario]         NUMERIC (18, 4) NULL,
    [IdObra]                 INT             NULL,
    [IdDetalleRequerimiento] INT             NULL,
    CONSTRAINT [PK_DW_FactPedidos] PRIMARY KEY CLUSTERED ([IdDetallePedido] ASC) WITH (FILLFACTOR = 90)
);


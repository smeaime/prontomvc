CREATE TABLE [dbo].[_TempCuboCostosImportacion] (
    [IdTempCuboCostosImportacion] INT             IDENTITY (1, 1) NOT NULL,
    [Articulo]                    VARCHAR (500)   NULL,
    [Pedido]                      VARCHAR (12)    NULL,
    [DatosPedido]                 VARCHAR (70)    NULL,
    [Origen]                      VARCHAR (40)    NULL,
    [Movimientos]                 VARCHAR (200)   NULL,
    [Cantidad]                    NUMERIC (18, 2) NULL,
    [Entregado]                   NUMERIC (18, 2) NULL,
    [CostoPedido]                 NUMERIC (18, 4) NULL,
    [CostoItemPedido]             NUMERIC (18, 2) NULL,
    [TotalPedido]                 NUMERIC (18, 2) NULL,
    [TotalComprobantes]           NUMERIC (18, 2) NULL,
    [CostoAAsignar]               NUMERIC (18, 4) NULL,
    [CostoPedidoDolar]            NUMERIC (18, 4) NULL,
    [CostoItemPedidoDolar]        NUMERIC (18, 2) NULL,
    [TotalPedidoDolar]            NUMERIC (18, 2) NULL,
    [TotalComprobantesDolar]      NUMERIC (18, 2) NULL,
    [CostoAAsignarDolar]          NUMERIC (18, 4) NULL,
    CONSTRAINT [PK__TempCuboCostosImportacion] PRIMARY KEY CLUSTERED ([IdTempCuboCostosImportacion] ASC) WITH (FILLFACTOR = 90)
);


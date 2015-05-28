CREATE TABLE [dbo].[DetallePedidosCambiosPrecio] (
    [IdDetallePedidoCambioPrecio] INT             IDENTITY (1, 1) NOT NULL,
    [IdDetallePedido]             INT             NULL,
    [Fecha]                       DATETIME        NULL,
    [IdUsuario]                   INT             NULL,
    [Observaciones]               NTEXT           NULL,
    [PrecioAnterior]              NUMERIC (18, 2) NULL,
    [PrecioNuevo]                 NUMERIC (18, 2) NULL,
    CONSTRAINT [PK_DetallePedidosCambiosPrecio] PRIMARY KEY CLUSTERED ([IdDetallePedidoCambioPrecio] ASC) WITH (FILLFACTOR = 90)
);


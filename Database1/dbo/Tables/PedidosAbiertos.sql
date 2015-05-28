CREATE TABLE [dbo].[PedidosAbiertos] (
    [IdPedidoAbierto]     INT             IDENTITY (1, 1) NOT NULL,
    [NumeroPedidoAbierto] INT             NULL,
    [FechaPedidoAbierto]  DATETIME        NULL,
    [IdProveedor]         INT             NULL,
    [FechaLimite]         DATETIME        NULL,
    [ImporteLimite]       NUMERIC (18, 2) NULL,
    CONSTRAINT [PK_PedidosAbiertos] PRIMARY KEY CLUSTERED ([IdPedidoAbierto] ASC) WITH (FILLFACTOR = 90)
);


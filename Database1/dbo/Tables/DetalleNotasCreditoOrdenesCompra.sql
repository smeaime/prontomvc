CREATE TABLE [dbo].[DetalleNotasCreditoOrdenesCompra] (
    [IdDetalleNotaCreditoOrdenesCompra] INT             IDENTITY (1, 1) NOT NULL,
    [IdNotaCredito]                     INT             NULL,
    [IdDetalleOrdenCompra]              INT             NULL,
    [Cantidad]                          NUMERIC (18, 2) NULL,
    [PorcentajeCertificacion]           NUMERIC (12, 6) NULL,
    CONSTRAINT [PK_DetalleNotasCreditoOrdenesCompra] PRIMARY KEY CLUSTERED ([IdDetalleNotaCreditoOrdenesCompra] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleNotasCreditoOrdenesCompra_NotasCredito] FOREIGN KEY ([IdNotaCredito]) REFERENCES [dbo].[NotasCredito] ([IdNotaCredito])
);


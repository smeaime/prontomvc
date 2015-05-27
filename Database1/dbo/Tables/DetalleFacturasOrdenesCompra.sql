CREATE TABLE [dbo].[DetalleFacturasOrdenesCompra] (
    [IdDetalleFacturaOrdenesCompra] INT     IDENTITY (1, 1) NOT NULL,
    [IdDetalleFactura]              INT     NULL,
    [IdFactura]                     INT     NULL,
    [IdDetalleOrdenCompra]          INT     NULL,
    [EnviarEmail]                   TINYINT NULL,
    CONSTRAINT [PK_DetalleFacturasOrdenesCompra] PRIMARY KEY CLUSTERED ([IdDetalleFacturaOrdenesCompra] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleFacturasOrdenesCompra_DetalleFacturas] FOREIGN KEY ([IdDetalleFactura]) REFERENCES [dbo].[DetalleFacturas] ([IdDetalleFactura]),
    CONSTRAINT [FK_DetalleFacturasOrdenesCompra_Facturas] FOREIGN KEY ([IdFactura]) REFERENCES [dbo].[Facturas] ([IdFactura])
);


GO
CREATE NONCLUSTERED INDEX [Indice1]
    ON [dbo].[DetalleFacturasOrdenesCompra]([IdDetalleOrdenCompra] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [Indice2]
    ON [dbo].[DetalleFacturasOrdenesCompra]([IdDetalleFactura] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [Indice3]
    ON [dbo].[DetalleFacturasOrdenesCompra]([IdFactura] ASC) WITH (FILLFACTOR = 90);


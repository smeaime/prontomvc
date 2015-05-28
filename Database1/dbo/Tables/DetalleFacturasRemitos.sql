CREATE TABLE [dbo].[DetalleFacturasRemitos] (
    [IdDetalleFacturaRemitos] INT     IDENTITY (1, 1) NOT NULL,
    [IdDetalleFactura]        INT     NULL,
    [IdFactura]               INT     NULL,
    [IdDetalleRemito]         INT     NULL,
    [EnviarEmail]             TINYINT NULL,
    CONSTRAINT [PK_DetalleFacturasRemitos] PRIMARY KEY CLUSTERED ([IdDetalleFacturaRemitos] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleFacturasRemitos_DetalleFacturas] FOREIGN KEY ([IdDetalleFactura]) REFERENCES [dbo].[DetalleFacturas] ([IdDetalleFactura]),
    CONSTRAINT [FK_DetalleFacturasRemitos_Facturas] FOREIGN KEY ([IdFactura]) REFERENCES [dbo].[Facturas] ([IdFactura])
);


GO
CREATE NONCLUSTERED INDEX [Indice 1]
    ON [dbo].[DetalleFacturasRemitos]([IdDetalleRemito] ASC) WITH (FILLFACTOR = 90);


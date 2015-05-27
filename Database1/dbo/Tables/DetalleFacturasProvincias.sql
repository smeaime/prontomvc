CREATE TABLE [dbo].[DetalleFacturasProvincias] (
    [IdDetalleFacturaProvincias] INT            IDENTITY (1, 1) NOT NULL,
    [IdFactura]                  INT            NULL,
    [IdProvinciaDestino]         INT            NULL,
    [Porcentaje]                 NUMERIC (6, 2) NULL,
    [EnviarEmail]                TINYINT        NULL,
    CONSTRAINT [PK_DetalleFacturasProvincias] PRIMARY KEY CLUSTERED ([IdDetalleFacturaProvincias] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleFacturasProvincias_Facturas] FOREIGN KEY ([IdFactura]) REFERENCES [dbo].[Facturas] ([IdFactura])
);


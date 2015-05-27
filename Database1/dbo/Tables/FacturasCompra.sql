CREATE TABLE [dbo].[FacturasCompra] (
    [IdFacturaCompra]      INT             IDENTITY (1, 1) NOT NULL,
    [TipoComprobante]      INT             NULL,
    [IdComprobante]        INT             NULL,
    [IdDetalleComprobante] INT             NULL,
    [NumeroItem]           INT             NULL,
    [IdProveedor]          INT             NULL,
    [NumeroFactura1]       INT             NULL,
    [NumeroFactura2]       INT             NULL,
    [FechaFactura]         DATETIME        NULL,
    [ImporteFactura]       NUMERIC (18, 2) NULL,
    [Usuario]              VARCHAR (6)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [FechaIngreso]         DATETIME        NULL,
    [IdMoneda]             INT             NULL,
    CONSTRAINT [PK_FacturasCompra] PRIMARY KEY CLUSTERED ([IdFacturaCompra] ASC) WITH (FILLFACTOR = 90)
);


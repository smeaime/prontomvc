CREATE TABLE [dbo].[DetalleSolicitudesCompra] (
    [IdDetalleSolicitudCompra] INT             IDENTITY (1, 1) NOT NULL,
    [IdSolicitudCompra]        INT             NULL,
    [IdDetalleRequerimiento]   INT             NULL,
    [Cantidad]                 NUMERIC (18, 2) NULL,
    CONSTRAINT [PK_DetalleSolicitudesCompra] PRIMARY KEY CLUSTERED ([IdDetalleSolicitudCompra] ASC) WITH (FILLFACTOR = 90)
);


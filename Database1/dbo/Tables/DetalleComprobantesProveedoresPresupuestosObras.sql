CREATE TABLE [dbo].[DetalleComprobantesProveedoresPresupuestosObras] (
    [IdDetalleComprobanteProveedorPresupuestosObras] INT             IDENTITY (1, 1) NOT NULL,
    [IdComprobanteProveedor]                         INT             NULL,
    [IdPresupuestoObrasNodo]                         INT             NULL,
    [Importe]                                        NUMERIC (18, 2) NULL,
    CONSTRAINT [PK_DetalleComprobantesProveedoresPresupuestosObras] PRIMARY KEY CLUSTERED ([IdDetalleComprobanteProveedorPresupuestosObras] ASC) WITH (FILLFACTOR = 90)
);


CREATE TABLE [dbo].[DetalleComprobantesProveedoresProvincias] (
    [IdDetalleComprobanteProveedorProvincias] INT            IDENTITY (1, 1) NOT NULL,
    [IdComprobanteProveedor]                  INT            NULL,
    [IdProvinciaDestino]                      INT            NULL,
    [Porcentaje]                              NUMERIC (6, 2) NULL,
    CONSTRAINT [PK_DetalleComprobantesProveedoresProvincias] PRIMARY KEY CLUSTERED ([IdDetalleComprobanteProveedorProvincias] ASC) WITH (FILLFACTOR = 90)
);


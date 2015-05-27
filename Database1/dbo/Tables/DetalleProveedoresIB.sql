CREATE TABLE [dbo].[DetalleProveedoresIB] (
    [IdDetalleProveedorIB] INT            IDENTITY (1, 1) NOT NULL,
    [IdProveedor]          INT            NULL,
    [IdIBCondicion]        INT            NULL,
    [AlicuotaAAplicar]     NUMERIC (6, 2) NULL,
    [FechaVencimiento]     DATETIME       NULL,
    CONSTRAINT [PK_DetalleProveedoresIB] PRIMARY KEY CLUSTERED ([IdDetalleProveedorIB] ASC) WITH (FILLFACTOR = 90)
);


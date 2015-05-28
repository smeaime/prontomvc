CREATE TABLE [dbo].[DetalleProveedoresRubros] (
    [IdDetalleProveedorRubros] INT IDENTITY (1, 1) NOT NULL,
    [IdProveedor]              INT NULL,
    [IdRubro]                  INT NULL,
    [IdSubrubro]               INT NULL,
    CONSTRAINT [PK_DetalleProveedoresRubros] PRIMARY KEY CLUSTERED ([IdDetalleProveedorRubros] ASC) WITH (FILLFACTOR = 90)
);


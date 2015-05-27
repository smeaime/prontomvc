CREATE TABLE [dbo].[DW_DimProveedores] (
    [IdProveedor]   INT          NOT NULL,
    [CodigoEmpresa] VARCHAR (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Proveedor]     VARCHAR (50) NULL,
    [Direccion]     VARCHAR (50) NULL,
    [IdLocalidad]   INT          NULL,
    [CodigoPostal]  VARCHAR (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IdProvincia]   INT          NULL,
    [IdPais]        INT          NULL,
    [Telefono1]     VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Email]         VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Cuit]          VARCHAR (13) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [IdCodigoIva]   TINYINT      NULL,
    CONSTRAINT [PK_DW_DimProveedores] PRIMARY KEY CLUSTERED ([IdProveedor] ASC) WITH (FILLFACTOR = 90)
);


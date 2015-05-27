CREATE TABLE [dbo].[ProveedoresRubros] (
    [IdProveedorRubro] INT         IDENTITY (1, 1) NOT NULL,
    [IdProveedor]      INT         NULL,
    [IdRubro]          INT         NULL,
    [IdSubrubro]       INT         NULL,
    [IdFamilia]        INT         NULL,
    [Marca]            VARCHAR (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_ProveedoresRubros] PRIMARY KEY CLUSTERED ([IdProveedorRubro] ASC) WITH (FILLFACTOR = 90)
);


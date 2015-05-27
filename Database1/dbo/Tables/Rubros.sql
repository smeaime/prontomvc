CREATE TABLE [dbo].[Rubros] (
    [IdRubro]               INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion]           VARCHAR (50) NULL,
    [Abreviatura]           VARCHAR (15) NULL,
    [EnviarEmail]           TINYINT      NULL,
    [IdCuenta]              INT          NULL,
    [IdCuentaCompras]       INT          NULL,
    [IdCuentaComprasActivo] INT          NULL,
    [IdCuentaCompras1]      INT          NULL,
    [IdCuentaCompras2]      INT          NULL,
    [IdCuentaCompras3]      INT          NULL,
    [IdCuentaCompras4]      INT          NULL,
    [IdCuentaCompras5]      INT          NULL,
    [IdCuentaCompras6]      INT          NULL,
    [IdCuentaCompras7]      INT          NULL,
    [IdCuentaCompras8]      INT          NULL,
    [IdCuentaCompras9]      INT          NULL,
    [IdCuentaCompras10]     INT          NULL,
    [Codigo]                INT          NULL,
    [IdTipoOperacion]       INT          NULL,
    CONSTRAINT [PK_Rubros] PRIMARY KEY CLUSTERED ([IdRubro] ASC) WITH (FILLFACTOR = 90)
);


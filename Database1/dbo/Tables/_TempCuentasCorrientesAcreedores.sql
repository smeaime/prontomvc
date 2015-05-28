CREATE TABLE [dbo].[_TempCuentasCorrientesAcreedores] (
    [IdTempCtaCte]      INT             IDENTITY (1, 1) NOT NULL,
    [IdCtaCte]          INT             NULL,
    [IdProveedor]       INT             NULL,
    [Fecha]             DATETIME        NULL,
    [IdTipoComp]        INT             NULL,
    [IdComprobante]     INT             NULL,
    [NumeroComprobante] INT             NULL,
    [IdImputacion]      INT             NULL,
    [ImporteTotal]      NUMERIC (19, 2) NULL,
    [Saldo]             NUMERIC (19, 2) NULL,
    CONSTRAINT [PK__TempCuentasCorrientesAcreedores] PRIMARY KEY CLUSTERED ([IdTempCtaCte] ASC) WITH (FILLFACTOR = 90)
);


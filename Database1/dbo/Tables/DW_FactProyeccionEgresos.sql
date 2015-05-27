CREATE TABLE [dbo].[DW_FactProyeccionEgresos] (
    [IdProyeccionEgresos] INT             IDENTITY (1, 1) NOT NULL,
    [IdProveedor]         INT             NULL,
    [Fecha]               INT             NULL,
    [Saldo]               NUMERIC (18, 2) NULL,
    [ClaveComprobante]    NUMERIC (16)    NULL,
    CONSTRAINT [PK_DW_FactProyeccionEgresos] PRIMARY KEY CLUSTERED ([IdProyeccionEgresos] ASC) WITH (FILLFACTOR = 90)
);


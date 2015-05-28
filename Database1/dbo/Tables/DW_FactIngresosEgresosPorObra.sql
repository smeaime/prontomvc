CREATE TABLE [dbo].[DW_FactIngresosEgresosPorObra] (
    [IdIngresosEgresosPorObra] INT             IDENTITY (1, 1) NOT NULL,
    [IdTipoMovimiento]         INT             NULL,
    [IdObra]                   INT             NULL,
    [IdRubroContable]          INT             NULL,
    [Fecha]                    INT             NULL,
    [ClaveComprobante]         NUMERIC (16)    NULL,
    [Importe]                  NUMERIC (18, 2) NULL,
    CONSTRAINT [PK_DW_FactIngresosEgresosPorObra] PRIMARY KEY CLUSTERED ([IdIngresosEgresosPorObra] ASC) WITH (FILLFACTOR = 90)
);


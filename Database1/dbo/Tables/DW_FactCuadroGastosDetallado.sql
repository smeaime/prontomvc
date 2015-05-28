CREATE TABLE [dbo].[DW_FactCuadroGastosDetallado] (
    [IdCuadroGastosDetallado] INT             IDENTITY (1, 1) NOT NULL,
    [IdObra]                  INT             NULL,
    [IdRubroContable]         INT             NULL,
    [Fecha]                   INT             NULL,
    [IdProviciaDestino]       INT             NULL,
    [ClaveComprobante]        NUMERIC (16)    NULL,
    [Importe]                 NUMERIC (18, 2) NULL,
    CONSTRAINT [PK_DW_FactCuadroGastosDetallado] PRIMARY KEY CLUSTERED ([IdCuadroGastosDetallado] ASC) WITH (FILLFACTOR = 90)
);


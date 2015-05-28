CREATE TABLE [dbo].[DetalleLiquidacionesFletes] (
    [IdDetalleLiquidacionFlete] INT             IDENTITY (1, 1) NOT NULL,
    [IdLiquidacionFlete]        INT             NULL,
    [IdTipoComprobante]         INT             NULL,
    [IdComprobante]             INT             NULL,
    [Importe]                   NUMERIC (18, 2) NULL,
    [IdTarifaFlete]             INT             NULL,
    [ValorUnitarioTarifa]       NUMERIC (18, 2) NULL,
    [EquivalenciaAUnidadTarifa] NUMERIC (18, 6) NULL,
    [Tipo]                      VARCHAR (12)    NULL,
    CONSTRAINT [PK_DetalleLiquidacionesFletes] PRIMARY KEY CLUSTERED ([IdDetalleLiquidacionFlete] ASC) WITH (FILLFACTOR = 90)
);


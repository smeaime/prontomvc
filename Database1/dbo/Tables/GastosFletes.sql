CREATE TABLE [dbo].[GastosFletes] (
    [IdGastoFlete]                               INT             IDENTITY (1, 1) NOT NULL,
    [IdFlete]                                    INT             NULL,
    [Fecha]                                      DATETIME        NULL,
    [IdConcepto]                                 INT             NULL,
    [Importe]                                    NUMERIC (18, 2) NULL,
    [Detalle]                                    VARCHAR (50)    NULL,
    [SumaResta]                                  INT             NULL,
    [IdDetalleLiquidacionFlete]                  INT             NULL,
    [IdUsuarioDioPorCumplidoLiquidacionFletes]   INT             NULL,
    [FechaDioPorCumplidoLiquidacionFletes]       DATETIME        NULL,
    [ObservacionDioPorCumplidoLiquidacionFletes] NTEXT           NULL,
    [Gravado]                                    VARCHAR (2)     NULL,
    [Iva]                                        NUMERIC (18, 2) NULL,
    [Total]                                      NUMERIC (18, 2) NULL,
    [IdObra]                                     INT             NULL,
    [IdPresupuestoObrasNodo]                     INT             NULL,
    CONSTRAINT [PK_GastosFletes] PRIMARY KEY CLUSTERED ([IdGastoFlete] ASC) WITH (FILLFACTOR = 90)
);


CREATE TABLE [dbo].[_TempCuboVentasEnCuotas] (
    [IdTempCuboVentasEnCuotas] INT             IDENTITY (1, 1) NOT NULL,
    [Articulo]                 VARCHAR (250)   NULL,
    [NumeroManzana]            VARCHAR (20)    NULL,
    [Estado]                   VARCHAR (10)    NULL,
    [Detalle]                  VARCHAR (200)   NULL,
    [Cuotas]                   INT             NULL,
    [ImporteCuotas]            NUMERIC (18, 2) NULL,
    [ImporteCuotasPagas]       NUMERIC (18, 2) NULL,
    [ImporteCuotasVencidas]    NUMERIC (18, 2) NULL,
    [CuotasVencidas]           INT             NULL,
    CONSTRAINT [PK__TempCuboVentasEnCuotas] PRIMARY KEY CLUSTERED ([IdTempCuboVentasEnCuotas] ASC) WITH (FILLFACTOR = 90)
);


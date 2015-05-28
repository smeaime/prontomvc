CREATE TABLE [dbo].[_TempCuboPresupuestoObra] (
    [IdCuboPresupuestoObra] INT             IDENTITY (1, 1) NOT NULL,
    [CentroCostos]          VARCHAR (70)    NULL,
    [Fecha]                 DATETIME        NULL,
    [Detalle]               VARCHAR (500)   NULL,
    [CantidadPresupuestada] NUMERIC (18, 2) NULL,
    [ImportePresupuestado]  NUMERIC (18, 2) NULL,
    [CantidadReal]          NUMERIC (18, 2) NULL,
    [ImporteReal]           NUMERIC (18, 2) NULL
);


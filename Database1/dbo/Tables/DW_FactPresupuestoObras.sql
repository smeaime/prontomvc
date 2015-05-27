CREATE TABLE [dbo].[DW_FactPresupuestoObras] (
    [IdAuxiliar]             INT             IDENTITY (1, 1) NOT NULL,
    [IdPresupuestoObrasNodo] INT             NULL,
    [CodigoPresupuesto]      INT             NULL,
    [Importe]                NUMERIC (18, 8) NULL,
    [Cantidad]               NUMERIC (18, 8) NULL,
    [CantidadBase]           NUMERIC (18, 2) NULL,
    [Rendimiento]            NUMERIC (18, 2) NULL,
    [Incidencia]             NUMERIC (18, 8) NULL,
    [Costo]                  NUMERIC (18, 8) NULL,
    CONSTRAINT [PK_DW_FactPresupuestoObras] PRIMARY KEY CLUSTERED ([IdAuxiliar] ASC) WITH (FILLFACTOR = 90)
);


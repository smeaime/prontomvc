CREATE TABLE [dbo].[DW_FactPresupuestoObrasReal] (
    [IdAuxiliar]             INT             IDENTITY (1, 1) NOT NULL,
    [IdPresupuestoObrasNodo] INT             NULL,
    [CodigoPresupuesto]      INT             NULL,
    [Fecha]                  INT             NULL,
    [Porcentaje]             NUMERIC (18, 2) NULL,
    [CantidadTeorica]        NUMERIC (18, 2) NULL,
    [ImporteTeorico]         NUMERIC (18, 2) NULL,
    [CantidadReal]           NUMERIC (18, 2) NULL,
    [ImporteReal]            NUMERIC (18, 2) NULL,
    CONSTRAINT [PK_DW_FactPresupuestoObrasReal] PRIMARY KEY CLUSTERED ([IdAuxiliar] ASC) WITH (FILLFACTOR = 90)
);


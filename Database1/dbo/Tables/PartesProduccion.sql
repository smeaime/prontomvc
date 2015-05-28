CREATE TABLE [dbo].[PartesProduccion] (
    [IdParteProduccion]                INT             IDENTITY (1, 1) NOT NULL,
    [NumeroParteProduccion]            INT             NULL,
    [FechaParteProduccion]             DATETIME        NULL,
    [IdObra]                           INT             NULL,
    [IdArticulo]                       INT             NULL,
    [Cantidad]                         NUMERIC (18, 2) NULL,
    [IdUnidad]                         INT             NULL,
    [Importe]                          NUMERIC (18, 2) NULL,
    [IdPresupuestoObrasNodo]           INT             NULL,
    [Observaciones]                    NTEXT           NULL,
    [IdObraDestino]                    INT             NULL,
    [IdPresupuestoObrasNodoMateriales] INT             NULL,
    [IdDetalleSalidaMateriales]        INT             NULL,
    CONSTRAINT [PK_PartesProduccion] PRIMARY KEY CLUSTERED ([IdParteProduccion] ASC) WITH (FILLFACTOR = 90)
);


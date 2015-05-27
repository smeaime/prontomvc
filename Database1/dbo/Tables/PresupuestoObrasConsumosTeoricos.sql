CREATE TABLE [dbo].[PresupuestoObrasConsumosTeoricos] (
    [IdPresupuestoObraConsumoTeorico] INT             IDENTITY (1, 1) NOT NULL,
    [IdDetalleObraDestino]            INT             NULL,
    [IdPresupuestoObraRubro]          INT             NULL,
    [CodigoPresupuesto]               INT             NULL,
    [IdArticulo]                      INT             NULL,
    [Cantidad]                        NUMERIC (18, 2) NULL,
    [Importe]                         NUMERIC (18, 2) NULL,
    [IdUnidad]                        INT             NULL,
    CONSTRAINT [PK_PresupuestoObrasConsumosTeoricos] PRIMARY KEY CLUSTERED ([IdPresupuestoObraConsumoTeorico] ASC) WITH (FILLFACTOR = 90)
);


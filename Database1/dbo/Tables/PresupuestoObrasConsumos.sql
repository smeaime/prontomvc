CREATE TABLE [dbo].[PresupuestoObrasConsumos] (
    [IdPresupuestoObraConsumo] INT             IDENTITY (1, 1) NOT NULL,
    [IdArticulo]               INT             NULL,
    [IdObra]                   INT             NULL,
    [IdDetalleObraDestino]     INT             NULL,
    [IdPresupuestoObraRubro]   INT             NULL,
    [Año]                      INT             NULL,
    [Mes]                      INT             NULL,
    [Cantidad]                 NUMERIC (18, 2) NULL,
    [Importe]                  NUMERIC (18, 2) NULL,
    [Detalle]                  VARCHAR (50)    NULL,
    [IdUnidad]                 INT             NULL,
    [Origen]                   VARCHAR (5)     NULL,
    CONSTRAINT [PK_PresupuestoObrasConsumos] PRIMARY KEY CLUSTERED ([IdPresupuestoObraConsumo] ASC) WITH (FILLFACTOR = 90)
);


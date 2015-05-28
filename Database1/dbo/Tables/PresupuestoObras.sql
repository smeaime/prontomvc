CREATE TABLE [dbo].[PresupuestoObras] (
    [IdPresupuestoObra]      INT             IDENTITY (1, 1) NOT NULL,
    [IdDetalleObraDestino]   INT             NULL,
    [IdPresupuestoObraRubro] INT             NULL,
    [Año]                    INT             NULL,
    [Mes]                    INT             NULL,
    [Cantidad]               NUMERIC (18, 2) NULL,
    [Importe]                NUMERIC (18, 2) NULL,
    [IdUnidad]               INT             NULL,
    [CodigoPresupuesto]      INT             NULL,
    CONSTRAINT [PK_PresupuestoObras] PRIMARY KEY CLUSTERED ([IdPresupuestoObra] ASC) WITH (FILLFACTOR = 90)
);


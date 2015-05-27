CREATE TABLE [dbo].[PresupuestoObrasNodosDatos] (
    [IdPresupuestoObrasNodoDatos] INT             IDENTITY (1, 1) NOT NULL,
    [IdPresupuestoObrasNodo]      INT             NULL,
    [CodigoPresupuesto]           INT             NULL,
    [Importe]                     NUMERIC (18, 8) NULL,
    [Cantidad]                    NUMERIC (18, 8) NULL,
    [CantidadBase]                NUMERIC (18, 2) NULL,
    [Rendimiento]                 NUMERIC (18, 2) NULL,
    [Incidencia]                  NUMERIC (18, 8) NULL,
    [Costo]                       NUMERIC (18, 8) NULL,
    [PrecioVentaUnitario]         NUMERIC (18, 2) NULL,
    CONSTRAINT [PK_PresupuestoObrasNodosDatos] PRIMARY KEY CLUSTERED ([IdPresupuestoObrasNodoDatos] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_PresupuestoObrasNodosDatos_PresupuestoObrasNodos] FOREIGN KEY ([IdPresupuestoObrasNodo]) REFERENCES [dbo].[PresupuestoObrasNodos] ([IdPresupuestoObrasNodo])
);


GO
CREATE NONCLUSTERED INDEX [Indice1]
    ON [dbo].[PresupuestoObrasNodosDatos]([IdPresupuestoObrasNodo] ASC, [CodigoPresupuesto] ASC) WITH (FILLFACTOR = 90);


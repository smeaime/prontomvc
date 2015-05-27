CREATE TABLE [dbo].[PresupuestoObrasNodosPxQxPresupuesto] (
    [IdPresupuestoObrasNodosPxQxPresupuesto] INT             IDENTITY (1, 1) NOT NULL,
    [IdPresupuestoObrasNodo]                 INT             NULL,
    [CodigoPresupuesto]                      INT             NULL,
    [Importe]                                NUMERIC (18, 4) NULL,
    [Cantidad]                               NUMERIC (18, 8) NULL,
    [ImporteDesnormalizado]                  NUMERIC (18, 2) NULL,
    [Mes]                                    INT             NULL,
    [Año]                                    INT             NULL,
    [ImporteAvance]                          NUMERIC (18, 4) NULL,
    [CantidadAvance]                         NUMERIC (18, 8) NULL,
    [CantidadTeorica]                        NUMERIC (18, 8) NULL,
    [Certificado]                            NUMERIC (18, 4) NULL,
    [PrecioVentaUnitario]                    NUMERIC (18, 2) NULL,
    CONSTRAINT [PK_PresupuestoObrasNodosPxQxPresupuesto] PRIMARY KEY CLUSTERED ([IdPresupuestoObrasNodosPxQxPresupuesto] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_PresupuestoObrasNodosPxQxPresupuesto_PresupuestoObrasNodos] FOREIGN KEY ([IdPresupuestoObrasNodo]) REFERENCES [dbo].[PresupuestoObrasNodos] ([IdPresupuestoObrasNodo])
);


GO
CREATE NONCLUSTERED INDEX [Indice1]
    ON [dbo].[PresupuestoObrasNodosPxQxPresupuesto]([IdPresupuestoObrasNodo] ASC, [CodigoPresupuesto] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [Indice2]
    ON [dbo].[PresupuestoObrasNodosPxQxPresupuesto]([IdPresupuestoObrasNodo] ASC, [CodigoPresupuesto] ASC, [Año] ASC, [Mes] ASC);


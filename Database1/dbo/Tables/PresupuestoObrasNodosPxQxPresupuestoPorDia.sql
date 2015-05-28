CREATE TABLE [dbo].[PresupuestoObrasNodosPxQxPresupuestoPorDia] (
    [IdPresupuestoObrasNodosPxQxPresupuestoPorDia] INT             IDENTITY (1, 1) NOT NULL,
    [IdPresupuestoObrasNodo]                       INT             NULL,
    [CodigoPresupuesto]                            INT             NULL,
    [Dia]                                          INT             NULL,
    [Mes]                                          INT             NULL,
    [Año]                                          INT             NULL,
    [CantidadAvance]                               NUMERIC (18, 8) NULL,
    CONSTRAINT [PK_PresupuestoObrasNodosPxQxPresupuestoPorDia] PRIMARY KEY CLUSTERED ([IdPresupuestoObrasNodosPxQxPresupuestoPorDia] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_PresupuestoObrasNodosPxQxPresupuestoPorDia_PresupuestoObrasNodos] FOREIGN KEY ([IdPresupuestoObrasNodo]) REFERENCES [dbo].[PresupuestoObrasNodos] ([IdPresupuestoObrasNodo])
);


GO
CREATE NONCLUSTERED INDEX [Indice1]
    ON [dbo].[PresupuestoObrasNodosPxQxPresupuestoPorDia]([IdPresupuestoObrasNodo] ASC, [CodigoPresupuesto] ASC, [Año] ASC, [Mes] ASC, [Dia] ASC) WITH (FILLFACTOR = 90);


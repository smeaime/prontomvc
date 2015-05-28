CREATE TABLE [dbo].[_TempPresupuestoObrasNodosPxQxPresupuestoPorDia] (
    [Id_TempPresupuestoObrasNodosPxQxPresupuestoPorDia] INT             IDENTITY (1, 1) NOT NULL,
    [IdPresupuestoObrasNodosPxQxPresupuestoPorDia]      INT             NOT NULL,
    [IdPresupuestoObrasNodo]                            INT             NULL,
    [CodigoPresupuesto]                                 INT             NULL,
    [Dia]                                               INT             NULL,
    [Mes]                                               INT             NULL,
    [Año]                                               INT             NULL,
    [CantidadAvance]                                    NUMERIC (18, 8) NULL,
    [IdentificadorSesion]                               INT             NULL,
    [FechaSesion]                                       DATETIME        NULL
);


GO
CREATE NONCLUSTERED INDEX [IX__TempPresupuestoObrasNodosPxQxPresupuestoPorDia]
    ON [dbo].[_TempPresupuestoObrasNodosPxQxPresupuestoPorDia]([IdentificadorSesion] ASC, [IdPresupuestoObrasNodosPxQxPresupuestoPorDia] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IX__TempPresupuestoObrasNodosPxQxPresupuestoPorDia_1]
    ON [dbo].[_TempPresupuestoObrasNodosPxQxPresupuestoPorDia]([IdentificadorSesion] ASC, [IdPresupuestoObrasNodo] ASC, [CodigoPresupuesto] ASC, [Año] ASC, [Mes] ASC, [Dia] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [Indice3]
    ON [dbo].[_TempPresupuestoObrasNodosPxQxPresupuestoPorDia]([FechaSesion] ASC) WITH (FILLFACTOR = 90);


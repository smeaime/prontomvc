CREATE TABLE [dbo].[_TempPresupuestoObrasNodosPxQxPresupuesto] (
    [Id_TempPresupuestoObrasNodosPxQxPresupuesto] INT             IDENTITY (1, 1) NOT NULL,
    [IdPresupuestoObrasNodosPxQxPresupuesto]      INT             NOT NULL,
    [IdPresupuestoObrasNodo]                      INT             NULL,
    [CodigoPresupuesto]                           INT             NULL,
    [Importe]                                     NUMERIC (18, 4) NULL,
    [Cantidad]                                    NUMERIC (18, 8) NULL,
    [ImporteDesnormalizado]                       NUMERIC (18, 2) NULL,
    [Mes]                                         INT             NULL,
    [Año]                                         INT             NULL,
    [ImporteAvance]                               NUMERIC (18, 4) NULL,
    [CantidadAvance]                              NUMERIC (18, 8) NULL,
    [CantidadTeorica]                             NUMERIC (18, 8) NULL,
    [Certificado]                                 NUMERIC (18, 4) NULL,
    [IdentificadorSesion]                         INT             NULL,
    [FechaSesion]                                 DATETIME        NULL
);


GO
CREATE NONCLUSTERED INDEX [IX__TempPresupuestoObrasNodosPxQxPresupuesto]
    ON [dbo].[_TempPresupuestoObrasNodosPxQxPresupuesto]([IdentificadorSesion] ASC, [IdPresupuestoObrasNodosPxQxPresupuesto] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IX__TempPresupuestoObrasNodosPxQxPresupuesto_1]
    ON [dbo].[_TempPresupuestoObrasNodosPxQxPresupuesto]([IdentificadorSesion] ASC, [IdPresupuestoObrasNodo] ASC, [CodigoPresupuesto] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [Indice3]
    ON [dbo].[_TempPresupuestoObrasNodosPxQxPresupuesto]([FechaSesion] ASC) WITH (FILLFACTOR = 90);


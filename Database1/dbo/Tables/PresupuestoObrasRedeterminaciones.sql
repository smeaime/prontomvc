CREATE TABLE [dbo].[PresupuestoObrasRedeterminaciones] (
    [IdPresupuestoObraRedeterminacion] INT             IDENTITY (1, 1) NOT NULL,
    [IdObra]                           INT             NULL,
    [Fecha]                            DATETIME        NULL,
    [NumeroCertificado]                INT             NULL,
    [Importe]                          NUMERIC (18, 2) NULL,
    [Año]                              INT             NULL,
    [Mes]                              INT             NULL,
    [IdPresupuestoObrasNodo]           INT             NULL,
    [Observaciones]                    NTEXT           NULL,
    CONSTRAINT [PK_PresupuestoObrasRedeterminaciones] PRIMARY KEY CLUSTERED ([IdPresupuestoObraRedeterminacion] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_PresupuestoObrasRedeterminaciones_PresupuestoObrasNodos] FOREIGN KEY ([IdPresupuestoObrasNodo]) REFERENCES [dbo].[PresupuestoObrasNodos] ([IdPresupuestoObrasNodo])
);

